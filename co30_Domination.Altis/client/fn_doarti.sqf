// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (d_player_canu && {player distance2D (_this # 0) < 50}) then {
	if (_this # 1 == 0) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_501");
	} else {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_1952");
	};
};