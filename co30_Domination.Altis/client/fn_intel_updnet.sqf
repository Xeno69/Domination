//#define __DEBUG__
// by Xeno
#define THIS_FILE "fn_intel_updnet.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

[playerSide, "HQ"] sideChat format [localize ("STR_DOM_MISSIONSTRING_" + str(649 + (_this # 0))), _this # 1];
