// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

[1, format [localize "STR_DOM_MISSIONSTRING_1522", _this]] call d_fnc_sideorsyschat;
playSound "d_Notebook";
