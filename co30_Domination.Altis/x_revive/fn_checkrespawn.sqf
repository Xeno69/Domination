// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkrespawn.sqf"
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

private _pos = getPosASL _this;
_pos set [2, _this distance (getPos _this)];
__TRACE_2("","_this","_pos")
xr_death_pos = [_pos, getDir _this];