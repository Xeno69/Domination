// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ataxinet.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _strout = switch (_this) do {
	case 0: {localize "STR_DOM_MISSIONSTRING_634"};
	case 1: {d_heli_taxi_available = true; localize "STR_DOM_MISSIONSTRING_635"};
	case 2: {d_heli_taxi_available = true; localize "STR_DOM_MISSIONSTRING_636"};
	case 3: {localize "STR_DOM_MISSIONSTRING_637"};
	case 4: {d_heli_taxi_available = true; localize "STR_DOM_MISSIONSTRING_638"};
	case 5: {localize "STR_DOM_MISSIONSTRING_639"};
	case 6: {localize "STR_DOM_MISSIONSTRING_640"};
	case 7: {localize "STR_DOM_MISSIONSTRING_142"};
	default {""};
};
if (_strout != "") then {
	[playerSide, "HQ"] sideChat _strout;
};
if (d_heli_taxi_available) then {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_1453");
};