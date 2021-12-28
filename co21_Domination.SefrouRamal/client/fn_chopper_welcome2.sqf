// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private ["_welcome_str2", "_welcome_str3"];
disableSerialization;

private _welcome_str1 = format [localize "STR_DOM_MISSIONSTRING_183", d_name_pl];

call {
	if (_this # 0 == 1) exitWith {
		_welcome_str2 = localize "STR_DOM_MISSIONSTRING_184";
		_welcome_str3 = localize "STR_DOM_MISSIONSTRING_185";
	};
	if (_this # 0 == 0) exitWith {
		_welcome_str2 = localize "STR_DOM_MISSIONSTRING_186";
		_welcome_str3 = localize "STR_DOM_MISSIONSTRING_187";
	};
	_welcome_str2 = localize "STR_DOM_MISSIONSTRING_188";
	_welcome_str3 = localize "STR_DOM_MISSIONSTRING_189";
};

private _vec = _this # 1;
private _welcome_str4 = [localize "STR_DOM_MISSIONSTRING_191", localize "STR_DOM_MISSIONSTRING_190"] select (_vec getVariable ["d_canloadbox", false]);

private _end_welcome = time + 14;
"d_chopper_hud" cutRsc ["d_chopper_hud", "PLAIN"];
private _t = format ["<t color='#b5f279' size='1.9'><t align='center'>%1</t><br/><br/><t color='#ffffff' size='1.5'><t align='center'>%2<br/><br/>%3<br/><br/>%4</t>", _welcome_str1, _welcome_str2, _welcome_str3, _welcome_str4];
((uiNamespace getVariable "d_chopper_hud") displayCtrl 9999) ctrlSetStructuredText parseText _t;

while {true} do {
	sleep 0.223;
	if (time >= _end_welcome || {isNull objectParent player || {player != currentPilot _vec || {!d_player_canu}}}) exitWith {};
};
"d_chopper_hud" cutFadeOut 0;
