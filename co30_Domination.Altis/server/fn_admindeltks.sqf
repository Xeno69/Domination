// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_admindeltks.sqf"
#include "..\x_setup.sqf"

if (admin remoteExecutedOwner != 2) exitWith {};

private _p = d_player_hash getOrDefault [_this, []];
if (_p isNotEqualTo []) then {
	_p set [7, 0];
	__TRACE_2("","_p","_this")
};