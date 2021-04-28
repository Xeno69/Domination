// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

player setVariable ["xr_cursorTarget", _this # 0];

call xr_fnc_dorevive;