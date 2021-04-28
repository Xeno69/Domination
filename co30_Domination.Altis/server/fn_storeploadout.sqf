// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_storeploadout.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

private _p = d_player_hash getOrDefault [getPlayerUID (_this # 0), []];
if (_p isNotEqualTo []) then {
	__TRACE_1("","_p")
	_p set [11, [_this # 1, _this # 2]];
};
