// by Xeno
#include "..\x_setup.sqf"

if (player distance2D (_this # 0) > 20) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_339");
};
if (!d_eng_can_repfuel) then {
	d_eng_can_repfuel = true;
	systemChat (localize "STR_DOM_MISSIONSTRING_340");
};