// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_changerlifes.sqf"
#include "..\x_setup.sqf"

private _p = d_player_store getVariable (_this select 0);
if (!isNil "_p") then {
	_p set [8, _this select 1];
	__TRACE_1("","_p")
};