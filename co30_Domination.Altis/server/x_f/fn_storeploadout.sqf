// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_storeploadout.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

private _p = d_player_store getVariable (getPlayerUID (_this select 0));
if (!isNil "_p") then {
	__TRACE_1("","_p")
	_p set [11, [_this select 1, _this select 2]];
};