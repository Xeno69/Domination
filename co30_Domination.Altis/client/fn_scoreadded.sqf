// by Xeno
#define THIS_FILE "fn_scoreadded.sqf"
#include "..\x_setup.sqf"

if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {};

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
	""
};

if (_txt isEqualTo "") exitWith {};

d_scoreadd_qeue pushBack [_txt, _score];

if (isNull d_scoreadd_script) then {
	d_scoreadd_script = 0 spawn d_fnc_scoreaddqeue;
};
