//#define __DEBUG__
#define THIS_FILE "fn_spawnvehicle.sqf"
#include "..\x_setup.sqf"
/*
	File: spawnVehicle.sqf
	Author: Joris-Jan van 't Land

	Description:
	Function to spawn a certain vehicle type with all crew (including turrets).
	The vehicle can either become part of an existing group or create a new group.

	Parameter(s):
	0: desired position (Array).
	1: desired azimuth (Number).
	2: type of the vehicle (String).
	3: side or existing group (Side or Group).

	Returns:
	Array:
	0: new vehicle (Object).
	1: all crew (Array of Objects).
	2: vehicle's group (Group).
*/

private ["_grp", "_newGrp"];
params ["_posv1", "_azi", "_typev1", ["_sideorgrp", sideUnknown], ["_addkills", true], ["_nocargo", false]];
__TRACE_1("","_this")

if (!isClass (configFile>>"CfgVehicles">>_typev1)) exitWith {
	diag_log ["ATTENTION: Couldn't spawn vehicle, fn_spawnvehicle.sqf, the following class does not exist (anymore):", _typev1, "_this:", _this];
	[objNull, [], grpNull]
};

if (_sideorgrp isEqualType sideUnknown) then {
	_grp = [_sideorgrp] call d_fnc_creategroup;
	_newGrp = true;
} else {
	_grp = _sideorgrp;
	_newGrp = false;
};

private "_veh";
private _cfg = configFile>>"CfgVehicles">>_typev1>>"simulation";

private _sim = if (isText _cfg) then {
	toLowerANSI getText(_cfg)
} else {
	private _ar = getArray (_cfg);
	toLowerANSI (_ar # 0)
};

__TRACE_1("","_sim")

if (_sim in ["airplane", "helicopter", "airplanex", "helicopterx", "helicopterrtd"]) then {
	if (count _posv1 == 2) then {
		_posv1 pushBack ((_posv1 # 2) max 300);
	} else {
		_posv1 set [2, (_posv1 # 2) max 300];
	};

	_veh = createVehicle [_typev1, _posv1, [], 0, "FLY"];
	_veh call d_fnc_nodamoff;

	_veh setDir _azi;
	if (getTerrainHeightASL _posv1 < 0) then {
		_veh setPosASL _posv1;
	} else {
		_veh setPosATL _posv1;
	};
	
	if (_sim == "airplanex" || {_sim == "airplane"}) then {
		private _v = velocity _veh;
		_veh setVelocity [
			(_v # 1) * sin _azi - (_v # 0) * cos _azi,
			(_v # 0) * sin _azi + (_v # 1) * cos _azi,
			_v # 2
		];
	};
} else {
	_veh = createVehicle [_typev1, _posv1, [], 0, "NONE"];
	_veh call d_fnc_nodamoff;
	if (d_del_crew_always == 1) then {
		if (random 100 > 50) then {_veh allowCrewInImmobile true};
	} else {
		_veh allowCrewInImmobile true;
	};
	_veh setDir _azi;
	_veh setVehiclePosition [_veh, [], 0, "NONE"];
};

if (d_del_crew_always == 0) then {
	_nocargo = true;
};
private _crew = [_veh, _grp, _nocargo] call d_fnc_spawnCrew;
_grp addVehicle _veh;
_grp deleteGroupWhenEmpty true;

if (d_del_crew_always == 1) then {
	_veh setUnloadInCombat [true, false];
} else {
	_veh setUnloadInCombat [false, false];
	_veh setVariable ["d_crew", _crew];
};

if (unitIsUAV _veh) then {
	_veh allowCrewInImmobile true;
	_veh setVehicleReceiveRemoteTargets true;
	_veh setVehicleReportRemoteTargets true;
	_veh setVehicleRadar 1;
	_veh setAutonomous true;
	_veh enableVehicleSensor ["manSensorComponent",true];
};

if (_newGrp) then {_grp selectLeader (commander _veh)};

if (_addkills) then {
#ifdef __TT__
	if !(_veh isKindOf "Air") then {
		[_veh, 0, 2, [false, true] select d_with_ace] call d_fnc_setekmode;
	} else {
		[_veh, 0, 3, [false, true] select d_with_ace] call d_fnc_setekmode;
	};
#endif
	if (d_with_ai && {d_with_ranked}) then {
		if !(_veh isKindOf "Air") then {
			[_veh, 4, 2] call d_fnc_setekmode;
		} else {
			[_veh, 4, 3] call d_fnc_setekmode;
		};
	};
};

if !(_veh isKindOf "Ship") then {
	_veh addEventHandler ["handleDamage", {call d_fnc_v_hd}];
	private _gvecs = _grp getVariable ["d_gvecs", []];
	_gvecs pushBack _veh;
	_grp setVariable ["d_gvecs", _gvecs];
};

#ifndef __TT__
[_veh] call d_fnc_addceo;
#endif
__TRACE_1("","_veh")
__TRACE_1("","_crew")
__TRACE_1("","_grp")
[_veh, _crew, _grp]
