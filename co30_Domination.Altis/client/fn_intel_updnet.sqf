//#define __DEBUG__
// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

[1, format [localize ("STR_DOM_MISSIONSTRING_" + str(649 + (_this # 0))), _this # 1]] call d_fnc_sideorsyschat;
