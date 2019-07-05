// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_admindeltks.sqf"
#include "..\x_setup.sqf"

private _p = d_player_store getVariable _this;
if (!isNil "_p") then {
	_p set [7, 0];
	__TRACE_2("","_p","_this")
};