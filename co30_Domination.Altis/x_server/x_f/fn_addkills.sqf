// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkills.sqf"
#include "..\..\x_setup.sqf"

// gameplay change:
// _points is now an array
// [points if the killer (player) is infantry unit, points if the killer is inside an APC, points if the killer is inside a tank, points if the player is inside an air vehicle]
// now, the lowest points number should be given for air vehicles and the highest for inf units
// second change: distance to target, the lower the higher, Only for infantry!!!!
params ["_points", "_killer", "_killed"];
if (d_with_ace && {isNull _killer}) then {
	_killer = _killed getVariable ["ace_medical_lastDamageSource", _killer];
};
if (isNull _killer || {!(_killer call d_fnc_isplayer)}) exitWith {};
private _endpoints = if (isNull objectParent _killer) then {
	private _dist = [_killed distance2D _killer, 500] select (isNull _killed);
	if (_dist < 0) then {_dist = 500};
	private _coef = [[1, 2] select (_dist < 70), 3] select (_dist < 20);
	_killer addScore round ((_points # 0) / 5);
	((_points # 0) * _coef)
} else {
	private _vec = vehicle _killer;
	call {
		if (_vec isKindOf "Wheeled_APC") exitWith {_points # 1};
		if (_vec isKindOf "Tank") exitWith {_points # 2};
		if (_vec isKindOf "Air") exitWith {_points # 3};
		1
	};
};
private _grs = side (group _killer);
if (_grs == blufor) then {
	d_kill_points_blufor = d_kill_points_blufor + _endpoints;
} else {
	if (_grs == opfor) then {
		d_kill_points_opfor = d_kill_points_opfor + _endpoints
	};
};
