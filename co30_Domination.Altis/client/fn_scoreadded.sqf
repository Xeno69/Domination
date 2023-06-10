// by Xeno
#include "..\x_setup.sqf"

if (!d_player_canu) exitWith {};

params ["_reason", "_score"];

// reason:
// 1 - barracks building destroyed at main target
// 2 - mobile HQ building destroyed at main target
// 3 - radio tower destroyed at main target
// 4 - player has taken camp
// 5 - player has resolved main target mission
// 6 - extra points seizing the main target
// 7 - points for reviving another player
// 8 - points for helping solving the sidemission
// 9 - points for repairing/refueling a vehicle
// 10 - points for healing another unit
// 11 - points for another player healing at a player mash
// 12 - points for another player spawning at squad leader
// 13 - points for transporting another player in a vehicle
// 15 - points subtracted when killing an animal, see fn_killedanimal.sqf

private _txt = call {
	if (_reason == 1) exitWith {
		localize "STR_DOM_MISSIONSTRING_1971"
	};
	if (_reason == 2) exitWith {
		localize "STR_DOM_MISSIONSTRING_1972"
	};
	if (_reason == 3) exitWith {
		localize "STR_DOM_MISSIONSTRING_1973"
	};
	if (_reason == 4) exitWith {
		localize "STR_DOM_MISSIONSTRING_1974"
	};
	if (_reason == 5) exitWith {
		localize "STR_DOM_MISSIONSTRING_1975"
	};
	if (_reason == 6) exitWith {
		localize "STR_DOM_MISSIONSTRING_1976"
	};
	if (_reason == 7) exitWith {
		localize "STR_DOM_MISSIONSTRING_1970"
	};
	if (_reason == 8) exitWith {
		localize "STR_DOM_MISSIONSTRING_1977"
	};
	if (_reason == 9) exitWith {
		localize "STR_DOM_MISSIONSTRING_1979"
	};
	if (_reason == 10) exitWith {
		localize "STR_DOM_MISSIONSTRING_1980"
	};
	if (_reason == 11) exitWith {
		localize "STR_DOM_MISSIONSTRING_1987"
	};
	if (_reason == 12) exitWith {
		localize "STR_DOM_MISSIONSTRING_1989"
	};
	if (_reason == 13) exitWith {
		localize "STR_DOM_MISSIONSTRING_2001"
	};
	if (_reason == 14) exitWith {
		localize "STR_DOM_MISSIONSTRING_1856"
	};
	if (_reason == 15) exitWith {
		format [localize "STR_DOM_MISSIONSTRING_2109", localize (_this # 2)]
	};
	""
};

if (_txt isEqualTo "") exitWith {};

d_scoreadd_qeue pushBack [_txt, _score];

if (isNull d_scoreadd_script) then {
	d_scoreadd_script = 0 spawn d_fnc_scoreaddqeue;
};
