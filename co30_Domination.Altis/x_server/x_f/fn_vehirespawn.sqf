// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vehirespawn.sqf"
#include "..\..\x_setup.sqf"

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
private _startdir = getDir _vec;
private _type = typeOf _vec;

_vec setVariable ["d_vec_islocked", (_vec call d_fnc_isVecLocked)];

if (_fuelcheck) then {
	_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_fuelCheck;}}];
};

if (unitIsUAV _vec) then {
	_vec allowCrewInImmobile true;
	if (isClass (configFile>>"CfgVehicles">>_vectypetouse>>"Components">>"TransportPylonsComponent")) then {
		_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
	};
};

_vec setVariable ["d_OUT_OF_SPACE", -1];

private _skinpoly = _vec call d_fnc_getskinpoly;

sleep 5;

while {true} do {
	private _disabled = false;
	private _empty = false;
	if (_delay != -1) then {
		sleep (_delay + random 15);
	} else {
		sleep (2 + random 2);
	};
	
	if (alive _vec) then {
		_empty = (crew _vec) findIf {alive _x} == -1;
		
		if (_delay != -1 && {_dempty_respawn != -1}) then {
			if (_empty) then {
				private _empty_respawn = _vec getVariable ["d_empty_respawn_time", -1];
				if (_empty_respawn == -1) then {
					if (_vec distance2D _startpos > 10) then {
						_vec setVariable ["d_empty_respawn_time", time + _dempty_respawn];
					};
				} else {
					if (time > _empty_respawn) then {
						private _runits = ((allPlayers - entities "HeadlessClient_F") select {!isNil "_x" && {!isNull _x}});
						sleep 0.1;
						if (!(_runits isEqualTo []) && {_runits findIf {_x distance2D _vec < 100} == -1}) then {
							_disabled = true;
						};
					};
				};
			} else {
				if (alive _vec) then {_vec setVariable ["d_empty_respawn_time", -1]};
			};
		};
		
		if (!_disabled && {damage _vec >= 0.9}) then {_disabled = true};
		
		if (_empty && {!_disabled && {alive _vec && {_vec call d_fnc_OutOfBounds}}}) then {
			private _outb = _vec getVariable "d_OUT_OF_SPACE";
			if (_outb != -1) then {
				if (time > _outb) then {_disabled = true};
			} else {
				_vec setVariable ["d_OUT_OF_SPACE", time + 600];
			};
		} else {
			_vec setVariable ["d_OUT_OF_SPACE", -1];
		};
		sleep 0.01;
	};
	
	if (!alive _vec || {_empty && {_disabled}}) then {
		private _isitlocked = _vec getVariable "d_vec_islocked";
		private _fuelleft = _vec getVariable ["d_fuel", 1];
		if (unitIsUAV _vec) then {
			{_vec deleteVehicleCrew _x} forEach (crew _vec);
		};
		deleteVehicle _vec;
		sleep 0.5;
		_vec = createVehicle [_type, _startpos, [], 0, "NONE"];
		_vec setDir _startdir;
		_vec setPos _startpos;
		_vec setVariable ["d_vec_islocked", _isitlocked];
		if (_isitlocked) then {_vec lock true};
		if (_fuelcheck) then {
			_vec setFuel _fuelleft;
			_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_fuelCheck}}];
		};
		if (unitIsUAV _vec) then {
			createVehicleCrew _vec;
			_vec allowCrewInImmobile true;
			if (isClass (configFile>>"CfgVehicles">>_type>>"Components">>"TransportPylonsComponent")) then {
				_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
			};
		};
		[_vec, _skinpoly] call d_fnc_skinpolyresp;
		if (_vec isKindOf "Air" && {surfaceIsWater _startpos}) then {
			private _cposc =+ _startpos;
			private _asl_height;
			if (!isNil "d_the_carrier") then {
				_asl_height = d_the_carrier getVariable "d_asl_height";
			};
			if (isNil "_asl_height") then {
				_asl_height = (getPosASL d_FLAG_BASE) # 2;
			};
			_cposc set [2, _asl_height];
			[_vec, _cposc] spawn {
				params ["_vec", "_cposc"];
				sleep 1;
				_vec setPosASL _cposc;
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
	};
};
