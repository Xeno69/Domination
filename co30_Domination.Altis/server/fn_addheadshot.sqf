// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addheadshot.sqf"
#include "..\x_setup.sqf"

params ["_pl"];

private _p = d_player_hash getOrDefault [getPlayerUID _pl, -1];
if (_p isEqualType []) then {
	_p set [16, (_p # 16) + 1];
	__TRACE_2("","_p","_this")
};
