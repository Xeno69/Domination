// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (d_player_canu && {player distance2D (_this # 0) < 50}) then {
	if ((d_force_isstreamfriendlyui != 1) && {!isStreamFriendlyUIEnabled}) then {
		if (_this # 1 == 0) then {
			[1, localize "STR_DOM_MISSIONSTRING_501"] call d_fnc_sideorsyschat;
		} else {
			[1, localize "STR_DOM_MISSIONSTRING_1952"] call d_fnc_sideorsyschat;
		};
	};
};