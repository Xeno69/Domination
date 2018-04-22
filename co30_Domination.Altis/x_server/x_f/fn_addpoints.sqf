// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addpoints.sqf"
#include "..\..\x_setup.sqf"

private _killer = param [1];
if (!isPlayer _killer) exitWith {};
private _points = param [0];
call {
	private _side = side (group _killer);
	if (_side == blufor) exitWith {d_points_blufor = d_points_blufor + _points};
	if (_side == opfor) exitWith {d_points_opfor = d_points_opfor + _points};
};
_killer addScore _points;