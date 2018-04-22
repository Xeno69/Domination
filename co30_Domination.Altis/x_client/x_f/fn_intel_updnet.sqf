//#define __DEBUG__
// by Xeno
#define THIS_FILE "fn_intel_updnet.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated || {!hasInterface}) exitWith {};

[playerSide, "HQ"] sideChat format [localize ("STR_DOM_MISSIONSTRING_" + str(649 + (param [0]))), param [1]];
