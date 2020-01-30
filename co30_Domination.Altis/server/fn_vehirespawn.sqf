// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vehirespawn.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

// delay = -1 respawn only when destroyed
params ["_vec", ["_delay", 300], ["_fuelcheck", true]];
__TRACE_1("","_vec")

private _temp = _vec getVariable "d_respawn_delay";
if (!isNil "_temp") then {
	_delay = _temp;
};
__TRACE_1("","_delay")
_temp = _vec getVariable "d_respawn_fuelcheck";
if (!isNil "_temp") then {
	_fuelcheck = _temp;
};
__TRACE_1("","_fuelcheck")
private _liftit = _vec getVariable ["d_respawn_liftit", false];
if (_liftit) then {
	_vec setVariable ["d_liftit", true, true];
};
__TRACE_1("","_liftit")
private _vicon = _vec getVariable ["d_respawn_icon_text_col", []];
if !(_vicon isEqualTo []) then {
	_vec setVariable ["d_vec", _vicon, true];
	_vec remoteExecCall ["d_fnc_initvec", [0, -2] select isDedicated];
};
__TRACE_1("","_vicon")
private _dempty_respawn = _vec getVariable ["d_empty_respawn", -1];
__TRACE_1("","_dempty_respawn")

private _startpos = if (_vec isKindOf "Air") then {
	(getPosATL _vec) vectorAdd [0, 0, 0.1];
} else {
	getPosATL _vec;
};
__TRACE_1("","_startpos")
private "_startposasl";
if (surfaceIsWater _startpos) then {
	_startposasl = ATLToASL _startpos;
	if (_vec isKindOf "Helicopter") then {
		__TRACE("vector add")
		_startposasl vectorAdd [0, 0, 2];
		_startpos vectorAdd [0, 0, 1];
	};
	__TRACE_1("","_startposasl")
};
private _startdir = getDir _vec;
private _type = typeOf _vec;

_vec setVariable ["d_vec_islocked", (_vec call d_fnc_isVecLocked)];

private _nopylon = _vec getVariable "d_disable_pylonloadout";

if (_fuelcheck) then {
	[_vec, 9] call d_fnc_setekmode;
};

if (unitIsUAV _vec) then {
	private _uavgrp = createVehicleCrew _vec;
	_vec allowCrewInImmobile true;
	_uavgrp deleteGroupWhenEmpty true;
	[_vec, 7] call d_fnc_setekmode;
	if (isClass (configFile>>"CfgVehicles">>_vec_type>>"Components">>"TransportPylonsComponent")) then {
		_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
	};
} else {
	if (d_with_dynsim == 0) then {
		[_vec, 10] spawn d_fnc_enabledynsim;
	};
};

_vec setVariable ["d_OUT_OF_SPACE", -1];

if (d_with_ranked) then {
	clearWeaponCargoGlobal _vec;
};

sleep 5;

private ["_disabled", "_empty"];
while {true} do {
	_disabled = false;
	_empty = false;
	if (_delay != -1) then {
		sleep (_delay + random 15);
	} else {
		sleep (2 + random 2);
	};
	
	if (alive _vec) then {
		_empty = (crew _vec) findIf {alive _x} == -1;
		__TRACE_2("","_vec","_empty")
		if (_delay != -1 && {_dempty_respawn != -1}) then {
			if (_empty) then {
				private _empty_respawn = _vec getVariable ["d_empty_respawn_time", -1];
				if (_empty_respawn == -1) then {
					if (_vec distance2D _startpos > 10) then {
						_vec setVariable ["d_empty_respawn_time", time + _dempty_respawn];
					};
				} else {
					if (time > _empty_respawn) then {
						private _runits = (allPlayers - entities "HeadlessClient_F") select {!isNil "_x" && {!isNull _x}};
						sleep 0.1;
						if (!(_runits isEqualTo []) && {_runits findIf {_x distance2D _vec < 100} == -1}) then {
							_disabled = true;
						};
					};
				};
			} else {
				_vec setVariable ["d_empty_respawn_time", -1];
			};
		};
		__TRACE_2("","_vec","_disabled")
		if (!_disabled && {_empty}) then {
			if (damage _vec >= 0.9) exitWith {
				_disabled = true;
			};
			
			if (alive _vec && {_vec call d_fnc_OutOfBounds}) then {
				private _outb = _vec getVariable "d_OUT_OF_SPACE";
					if (!isNil "_outb") then {
					if (_outb != -1) then {
						if (time > _outb) then {_disabled = true};
					} else {
						_vec setVariable ["d_OUT_OF_SPACE", time + 600];
					};
				} else {
					_vec setVariable ["d_OUT_OF_SPACE", -1];
				};
			} else {
				_vec setVariable ["d_OUT_OF_SPACE", -1];
			};
		};
		sleep 0.01;
	};
	__TRACE_3("","_vec","alive _vec","_empty")
	__TRACE_2("","_vec","_disabled")
	if (!alive _vec || {_empty && {_disabled}}) then {
		private _isitlocked = _vec getVariable "d_vec_islocked";
		private _fuelleft = _vec getVariable ["d_fuel", 1];
		private _skinpoly = [_vec] call d_fnc_getskinpoly;
		private _canloadbox = _vec getVariable ["d_canloadbox", false];
#ifdef __GMCWG__
		private _attribs = _vec getvariable "GM_VEHICLE_ATTRIBUTES";
#endif
		if (unitIsUAV _vec) then {
			{_vec deleteVehicleCrew _x} forEach (crew _vec);
		};
		deleteVehicle _vec;
		sleep 0.5;
		_vec = createVehicle [_type, _startpos, [], 0, "NONE"];
		_vec allowDamage false;
		_vec setDir _startdir;
		if (isNil "_startposasl") then {
			_vec setPos _startpos;
		} else {
			_vec setPosASL _startposasl;
		};
		_vec setVariable ["d_vec_islocked", _isitlocked];
		if (_isitlocked) then {_vec lock true};
		if (_fuelcheck) then {
			_vec setFuel _fuelleft;
			[_vec, 9] call d_fnc_setekmode;
		};
		if (unitIsUAV _vec) then {
			private _uavgrp = createVehicleCrew _vec;
			_vec allowCrewInImmobile true;
			_uavgrp deleteGroupWhenEmpty true;
			[_vec, 7] call d_fnc_setekmode;
			if (isClass (configFile>>"CfgVehicles">>_vec_type>>"Components">>"TransportPylonsComponent")) then {
				_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
			};
		} else {
			if (d_with_dynsim == 0) then {
				[_vec, 10] spawn d_fnc_enabledynsim;
			};
		};
		[_vec, _skinpoly] call d_fnc_skinpolyresp;
#ifdef __GMCWG__
		if (!isNil "_attribs") then {
			_vec setVariable ["GM_VEHICLE_ATTRIBUTES", _attribs];
			[_vec] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;
		};
#endif
		/*if (_vec isKindOf "Air" && {surfaceIsWater _startpos}) then {
			private _cposc =+ _startpos;
			private "_asl_height";
			if (!isNil "d_the_carrier") then {
				_asl_height = d_the_carrier getVariable "d_asl_height";
			};
			if (isNil "_asl_height") then {
				_asl_height = (getPosASL d_FLAG_BASE) # 2;
			};
			_cposc set [2, _asl_height];
			[_vec, _cposc] spawn {
				scriptName "spawn vehirespawn";
				params ["_vec", "_cposc"];
				sleep 1;
				_vec setPosASL _cposc;
				_vec setDamage 0;
			};
		};*/
		if (_canloadbox) then {
			_vec setVariable ["d_canloadbox", true, true];
		};
		if (isNil "_startposasl") then {
			_vec allowDamage true;
			_vec setDamage 0;
		} else {
			[_vec] spawn {
				scriptName "spawn vehirespawn2";
				params ["_vec"];
				sleep 2;
				_vec allowDamage true;
				_vec setDamage 0;
			};
		};
		if (_liftit) then {
			_vec setVariable ["d_liftit", true, true];
		};
		if !(_vicon isEqualTo []) then {
			_vec setVariable ["d_vec", _vicon, true];
			_vec remoteExecCall ["d_fnc_initvec", [0, -2] select isDedicated];
		};
		
		if (!isNil "_nopylon") then {
			_vec setVariable ["d_disable_pylonloadout", true, true];
		};
		
		if (d_with_ranked) then {
			clearWeaponCargoGlobal _vec;
		};
	};
};
