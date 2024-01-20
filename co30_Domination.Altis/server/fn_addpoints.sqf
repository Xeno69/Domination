// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_points", "_killer", ["_dopcheck", true]];
if (_dopcheck && {!(isPlayer [_killer])}) exitWith {};
call {
	private _side = side (group _killer);
	if (_side == blufor) exitWith {d_points_blufor = d_points_blufor + _points};
	if (_side == opfor) exitWith {d_points_opfor = d_points_opfor + _points};
};
_killer addScore _points;