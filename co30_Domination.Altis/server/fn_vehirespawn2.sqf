// by Xeno
#define THIS_FILE "fn_vehirespawn2.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

params ["_vec", "_delay"];
private _startpos = getPosATL _vec;
private _startdir = getDir _vec;
private _type = typeOf _vec;

_vec setVariable ["d_vec_islocked", (_vec call d_fnc_isVecLocked)];

[_vec, "d_fuelc"] call d_fnc_setekmode;

if (unitIsUAV _vec) then {
	private _uavgrp = createVehicleCrew _vec;
	_vec allowCrewInImmobile true;
	_uavgrp deleteGroupWhenEmpty true;
	[_vec, "d_delcrewk"] call d_fnc_setekmode;
	if (isClass (configFile>>"CfgVehicles">>_vec_type>>"Components">>"TransportPylonsComponent")) then {
		_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
	};
} else {
	if (d_with_dynsim == 0) then {
		_vec spawn {
			scriptName "spawn enable dyn";
			sleep 10;
			if (alive _this) then {
				_this enableDynamicSimulation true;
			};
		};
	};
};

if (d_with_ranked) then {
	clearWeaponCargoGlobal _vec;
};

while {true} do {
	sleep (_delay + random 15);

	if ((crew _vec) findIf {alive _x} == -1 && {damage _vec > 0.9 || {!alive _vec}}) then {
		private _isitlocked = _vec getVariable "d_vec_islocked";
		private _fuelleft = _vec getVariable ["d_fuel", 1];
		private _skinpoly = [_vec] call d_fnc_getskinpoly;
#ifdef __GMCWG__
		private _attribs = _vec getvariable "GM_VEHICLE_ATTRIBUTES";
#endif
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
		_vec setFuel _fuelleft;
		[_vec, "d_fuelc"] call d_fnc_setekmode;
		if (unitIsUAV _vec) then {
			private _uavgrp = createVehicleCrew _vec;
			_vec allowCrewInImmobile true;
			_uavgrp deleteGroupWhenEmpty true;
			[_vec, "d_delcrewk"] call d_fnc_setekmode;
			if (isClass (configFile>>"CfgVehicles">>_vec_type>>"Components">>"TransportPylonsComponent")) then {
				_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
			};
		} else {
			if (d_with_dynsim == 0) then {
				_vec spawn {
					scriptName "spawn enable dyn";
					sleep 10;
					if (alive _this) then {
						_this enableDynamicSimulation true;
					};
				};
			};
		};
		[_vec, _skinpoly] call d_fnc_skinpolyresp;
#ifdef __GMCWG__
		if (!isNil "_attribs") then {
			_vec setVariable ["GM_VEHICLE_ATTRIBUTES", _attribs];
			[_vec] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;
		};
#endif
		if (d_with_ranked) then {
			clearWeaponCargoGlobal _vec;
		};
	};
};
