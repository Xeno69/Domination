// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_1522", _this];
playSound "d_Notebook";
