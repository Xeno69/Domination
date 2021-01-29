// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_incjail.sqf"
#include "..\x_setup.sqf"

private _p = d_player_hash getOrDefault [_this, []];
if (_p isNotEqualTo []) then {
	_p set [3, (_p # 3) + 1];
	__TRACE_1("","_p")
};
