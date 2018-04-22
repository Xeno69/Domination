// by Xeno
#define THIS_FILE "fn_restoreeng.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

if (player distance2D (param [0]) > 20) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_339");
};
if (!d_eng_can_repfuel) then {
	d_eng_can_repfuel = true;
	systemChat (localize "STR_DOM_MISSIONSTRING_340");
};