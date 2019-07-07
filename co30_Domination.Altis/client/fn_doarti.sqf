// by Xeno
#define THIS_FILE "fn_doarti.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (alive player && {player distance2D (_this # 0) < 50 && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}}) then {
	if (_this # 1 == 0) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_501");
	} else {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_1952");
	};
};