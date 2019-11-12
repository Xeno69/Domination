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
	""
};

if (_txt isEqualTo "") exitWith {};

disableSerialization;
private _ctrl = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
_ctrl ctrlSetPosition [safeZoneX + 0.1, safeZoneY + safeZoneH - 0.6, 0.5, 0.4];
_ctrl ctrlCommit 0;
_ctrl ctrlSetStructuredText parseText format ["<t size='1.3' color='#997F7F7F'>+ %1 </t><t size='1' color='#99ffffff'> %2</t>", _score, _txt];
sleep 2;
_ctrl ctrlSetPosition [safeZoneX + 0.1, safeZoneY + safeZoneH - 0.8, 0.5, 0.4];
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0.6;
sleep 1;
ctrlDelete _ctrl;
