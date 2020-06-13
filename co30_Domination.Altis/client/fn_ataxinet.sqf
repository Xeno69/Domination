// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ataxinet.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _strout = call {
	if (_this == 0) exitWith {localize "STR_DOM_MISSIONSTRING_634"};
	if (_this == 1) exitWith {d_heli_taxi_available = true; localize "STR_DOM_MISSIONSTRING_635"};
	if (_this == 2) exitWith {d_heli_taxi_available = true; localize "STR_DOM_MISSIONSTRING_636"};
	if (_this == 3) exitWith {localize "STR_DOM_MISSIONSTRING_637"};
	if (_this == 4) exitWith {d_heli_taxi_available = true; localize "STR_DOM_MISSIONSTRING_638"};
	if (_this == 5) exitWith {localize "STR_DOM_MISSIONSTRING_639"};
	if (_this == 6) exitWith {localize "STR_DOM_MISSIONSTRING_640"};
	if (_this == 7) exitWith {localize "STR_DOM_MISSIONSTRING_142"};
	if (_this == 200) exitWith {
		player setVariable ["d_can_change_taxi", player getVariable "d_can_change_taxix"];
		player setVariable ["d_can_change_taxix", nil];
	};
	""
}; 
if (_strout != "") then {
	[playerSide, "HQ"] sideChat _strout;
};
if (d_heli_taxi_available) then {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_1453");
	player setVariable ["d_can_change_taxi", nil];
};