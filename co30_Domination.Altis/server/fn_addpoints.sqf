// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addpoints.sqf"
#include "..\x_setup.sqf"

private _killer = _this select 1;
if !(_killer call d_fnc_isplayer) exitWith {};
private _points = _this select 0;
call {
	private _side = side (group _killer);
	if (_side == blufor) exitWith {d_points_blufor = d_points_blufor + _points};
	if (_side == opfor) exitWith {d_points_opfor = d_points_opfor + _points};
};
_killer addScore _points;