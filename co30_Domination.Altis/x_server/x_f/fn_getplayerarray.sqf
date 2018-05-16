// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_setplayerarray.sqf"
#include "..\..\x_setup.sqf"

params ["_uid"];
private _pa = d_player_store getVariable _uid;
if (!isNil "_pa") then {
	_pa set [4, _this select 1];
	__TRACE_2("","_uid","_pa")
	_pa set [5, _this select 2];
};