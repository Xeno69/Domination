// by Xeno
#define THIS_FILE "fn_restoreeng.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (player distance2D (_this select 0) > 20) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_339");
};
if (!d_eng_can_repfuel) then {
	d_eng_can_repfuel = true;
	systemChat (localize "STR_DOM_MISSIONSTRING_340");
};