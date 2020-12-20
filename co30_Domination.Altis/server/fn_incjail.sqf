// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_incjail.sqf"
#include "..\x_setup.sqf"

private _p = d_player_store getVariable _this;
if (!isNil "_p") then {
	_p set [3, (_p # 3) + 1];
	__TRACE_1("","_p")
};
