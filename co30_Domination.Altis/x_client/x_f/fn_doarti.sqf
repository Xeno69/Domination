// by Xeno
#define THIS_FILE "fn_doarti.sqf"
#include "..\..\x_setup.sqf"

if (alive player && {player distance2D _this < 50 && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}}) then {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_501");
};