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

private ["_grp", "_side", "_newGrp"];
params ["_posv1", "_azi", "_typev1", ["_param4", sideUnknown], ["_addkills", true], ["_nocargo", false]];
__TRACE_1("","_this")

if (_param4 isEqualType sideUnknown) then {
	_side = _param4;
	_grp = [_side] call d_fnc_creategroup;
	_newGrp = true;
} else {
	_grp = _param4;
	_side = side _grp;
	_newGrp = false;
};

private "_veh";
private _sim = toLower getText(configFile>>"CfgVehicles">>_typev1>>"simulation");
__TRACE_1("","_sim")

if (_sim in ["airplane", "helicopter", "airplanex", "helicopterx", "helicopterrtd"]) then {
	if (count _posv1 == 2) then {
		_posv1 pushBack ((_posv1 # 2) max 300);
	} else {
		_posv1 set [2, (_posv1 # 2) max 300];
	};

	_veh = createVehicle [_typev1, _posv1, [], 0, "FLY"];

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
	if (random 100 > 50) then {_veh allowCrewInImmobile true};
	_veh setDir _azi;
	_veh setVehiclePosition [_veh, [], 0, "NONE"];
};

private _crew = [_veh, _grp] call d_fnc_spawnCrew;
_grp addVehicle _veh;
_grp deleteGroupWhenEmpty true;

_veh setUnloadInCombat [true, false];

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
		[_veh, "d_ktypett", 2, [false, true] select d_with_ace] call d_fnc_setekmode;
	} else {
		[_veh, "d_ktypett", 3, [false, true] select d_with_ace] call d_fnc_setekmode;
	};
#endif
	if (d_with_ai && {d_with_ranked}) then {
		if !(_veh isKindOf "Air") then {
			[_veh, "d_ktypeai", 2] call d_fnc_setekmode;
		} else {
			[_veh, "d_ktypeai", 3] call d_fnc_setekmode;
		};
	};
};

#ifndef __TT__
[_veh] call d_fnc_addceo;
#endif
__TRACE_1("","_veh")
__TRACE_1("","_crew")
__TRACE_1("","_grp")
[_veh, _crew, _grp]
