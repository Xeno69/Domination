// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dohousepatrol.sqf"
#include "..\..\x_setup.sqf"

params ["_units"];

_units = _units select {alive _x && {isNil {_x getVariable "d_housepatrol"}}};

if (_units isEqualTo []) exitWith {};

private _building = nearestBuilding (_units select 0);
if (_building distance2D (_units select 0) > 150) exitWith {};
{
	
	if (alive _building) then {
		[_x, behaviour _x, 30, [], -1, "HIGH", false, _building] spawn d_fnc_housepatrol;
	};
	sleep 0.2;
} forEach _units;
