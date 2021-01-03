// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pdistarsqf"
#include "..\x_setup.sqf"

params ["_pl"];

if (remoteExecutedOwner != owner _pl) exitWith {};

private _p = d_player_hash getOrDefault [getPlayerUID _pl, -1];
if (_p isEqualType []) then {
	_p set [15, _this # 1];
	__TRACE_2("","_p","_this")
};