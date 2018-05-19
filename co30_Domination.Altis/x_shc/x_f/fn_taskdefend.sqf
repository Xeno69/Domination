#define THIS_FILE "fn_taskDefend.sqf"
#include "..\..\x_setup.sqf"
/*
	File: taskDefend.sqf
	Author: Joris-Jan van 't Land

	Description:
	Group will man nearby static defenses and guard the position.

	Parameter(s):
	0: group (Group)
	1: defense position (Array)
	
	Returns:
	Boolean - success flag
*/

if (count _this < 2) exitWith {false};

params ["_grp", "_pos"];

if (!(_grp isEqualType grpNull) || {!(_pos isEqualType [])}) exitWith {false};

_grp setBehaviour "SAFE";

private _units = (units _grp) - [leader _grp];

{
	if (random 1 > 0.2 && {!(_units isEqualTo [])}) then {
		private _unit = _units select ((count _units) - 1);
		_unit assignAsGunner _x;
		[_unit] orderGetIn true;
		_units resize ((count _units) - 1);
	};
} forEach ((_pos nearEntities ["StaticWeapon", 100]) select {_x emptyPositions "gunner" > 0});

private _wp = _grp addWaypoint [_pos, 10];
_wp setWaypointType "SENTRY";

_units spawn {
	scriptName "spawn_x_taskDefend_sitdown";
	sleep 5;
	{
		if (random 1 > 0.4) then {
			doStop _x;
			sleep 0.5;
			_x action ["SitDown", _x];
		};
	} forEach _this;
};
true