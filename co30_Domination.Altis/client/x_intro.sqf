// by Xeno
#define THIS_FILE "x_intro.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

diag_log [diag_frameno, diag_ticktime, time, "Dom intro started"];

enableRadio false;

disableSerialization;

waitUntil {sleep 0.112;!isNil "d_preloaddone"};
sleep 0.01;
1 fadeSound 1;

d_still_in_intro = true;

showCinemaBorder true;

createDialog "d_RscAnimatedLetters";
setMousePosition [1, 1];
private _line = 0;
d_animL_i = 0;
titleText ["", "BLACK IN", 0];
"BIS_layerStatic" cutRsc ["RscStatic", "PLAIN"];

private _pspsxx = getPosASL player;

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [6];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 15;

playMusic "LeadTrack01b_F";

if (sunOrMoon < 0.99) then {camUseNVG true};

#ifndef __TT__
d_intro_color = switch (d_own_side) do {case "WEST": {[0.85,0.88,1,1]};case "EAST": {[1,0.36,0.34,1]};case "GUER": {[1,1,0,1]};};
_camstart = markerPos "d_camstart";
deleteMarkerLocal "d_camstart";
#else
private "_camstart";
if (side (group player) == blufor) then {
	d_intro_color = [0,0,1,1];
	_camstart = markerPos "d_camstart";
} else {
	d_intro_color = [1,0,0,1];
	_camstart = markerPos "d_camstart_opfor";
};
deleteMarkerLocal "d_camstart";
deleteMarkerLocal "d_camstart_opfor";
#endif

private _camera = "camera" camCreate [_camstart # 0, (_camstart # 1) + 1, 120];
_camera camSetTarget [_pspsxx # 0, _pspsxx # 1 , (player modelToWorld [0,0,1.5]) # 2];
_camera camSetFov 0.7;
_camera cameraEffect ["INTERNAL", "Back"];
_camera camCommit 1;
waitUntil {camCommitted _camera};

private _str2 = "";
#ifndef __TT__
private _str = "One Team - " + d_version_string;
private _start_pos = 4;
if (d_with_ai) then {if (_str2 != "") then {_str2 = _str2 + " AI"} else {_str2 = _str2 + "AI"}};
#else
private _str = "Two Teams";
private _sarray = [];
private _start_pos = 8;
#endif
#ifdef __IFA3LITE__
_start_pos = 3;
#endif
#ifdef __RHS__
_start_pos = 3;
#endif
if (d_with_ranked) then {if (_str2 != "") then {_str2 = _str2 + " RA"} else {_str2 = _str2 + "RA"}};
if (d_WithRevive == 0) then {if (_str2 != "") then {_str2 = _str2 + " REVIVE"} else {_str2 = _str2 + "REVIVE"}};
private _start_pos2 = switch (count _str2) do {
	case 2: {11};
	case 3: {11};
	case 4: {10};
	case 5: {10};
	case 6: {9};
	case 7: {9};
	case 8: {8};
	case 9: {8};
	case 10: {8};
	case 11: {7};
	case 12: {6};
	case 13: {5};
	case 14: {5};
	case 15: {4};
	case 16: {3};
	default {0};
};

"d_DomLabel" cutRsc ["d_DomLabel", "PLAIN", 2];
"d_DomFour" cutRsc ["d_DomFour", "PLAIN", 2];
"d_ArmaLogo" cutRsc ["d_ArmaLogo", "PLAIN", 2];
[_start_pos, _str, 5] execVM "IntroAnim\animateLettersX.sqf";_line = _line + 1; waitUntil {d_animL_i == _line};
if (_str2 != "") then {[_start_pos2, _str2, 6] execVM "IntroAnim\animateLettersX.sqf";_line = _line + 1; waitUntil {d_animL_i == _line}};
switch (d_MissionType) do {
	case 2: {
		[4, localize "STR_DOM_MISSIONSTRING_263", 4] execVM "IntroAnim\animateLettersX.sqf";_line = _line + 1; waitUntil {d_animL_i == _line};
	};
	case 1: {
		[4, localize "STR_DOM_MISSIONSTRING_264", 4] execVM "IntroAnim\animateLettersX.sqf";_line = _line + 1; waitUntil {d_animL_i == _line};
	};
};

0 = [parseText format [ "<br/><t font='PuristaMedium' align='left' size='2.3'> Welcome to Domination! 4</t><br/>  <t align='left' size='1'>  Version 4.00  </t>"], [safeZoneX + 0.1,safeZoneY + safeZoneH - 0.2,0.9,0.3], nil, 5, 1, 0]  spawn BIS_fnc_textTiles;

_camera camSetTarget player;
_p_tpos = [_pspsxx # 0, _pspsxx # 1, (player modelToWorld [0,0,2]) # 2];
_camera camSetPos _p_tpos;
_camera camCommit 18;

0 spawn {
	scriptName "spawn_intro2";
	disableSerialization;
	sleep 3;
	private _control = (uiNamespace getVariable "d_DomLabel") displayCtrl 50;
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) - 0.1);
	_control ctrlCommit 0.3;
	waitUntil {ctrlCommitted _control};
	private _control2 = (uiNamespace getVariable "d_DomFour") displayCtrl 50;
	private _pos = ctrlPosition _control2;
	_control2 ctrlSetPosition [0.69, _pos # 1];
	_control2 ctrlCommit 0.5;
	waitUntil {ctrlCommitted _control2};
	"d_Lightning1" cutRsc ["d_Lightning1", "PLAIN"];
	"d_Eyeflare" cutRsc ["d_Eyeflare", "PLAIN"];
	sleep 0.1;
	playSound "thunder_2";
};

"d_Xlabel" cutRsc ["d_Xlabel", "PLAIN"];
sleep 6;
waitUntil {camCommitted _camera};
player cameraEffect ["terminate","back"];
camDestroy _camera;
closeDialog 0;

enableRadio true;
showChat true;
"dynamicBlur" ppEffectEnable false;

#ifndef __IFA3LITE__
if (sunOrMoon < 0.99 && {d_without_nvg == 1 && {player call d_fnc_hasnvgoggles}}) then {player action ["NVGoggles", player]};
#endif

private _uidcheck_done = false;
if (!(d_reserved_slot isEqualTo []) && {str player in d_reserved_slot}) then {
	_uidcheck_done = true;
	execVM "client\x_reservedslot.sqf";
};
if (!_uidcheck_done && {!(d_uid_reserved_slots isEqualTo [])} && {!(d_uids_for_reserved_slots isEqualTo [])}) then {
	d_uid_reserved_slots = d_uid_reserved_slots apply {toLower _x};
	if ((toLower str player) in d_uid_reserved_slots) then {
		if !(getPlayerUID player in d_uids_for_reserved_slots) then {
			execVM "client\x_reservedslot2.sqf";
		};
		d_uid_reserved_slots = nil;
		d_uids_for_reserved_slots = nil;
	};
};

d_still_in_intro = false;
enableEnvironment [false, true];

sleep 5;

[
	[
		[localize "STR_DOM_MISSIONSTRING_265", "<t size='1.0' font='RobotoCondensed'>%1</t><br/>", 0],
		[profileName, "<t size='1.0' font='RobotoCondensed'>%1</t><br/>", 5],
		[localize "STR_DOM_MISSIONSTRING_266", "<t size='0.9'>%1</t><br/>", 27]
	],
	-safezoneX, 0.85, "<t color='#FFFFFFFF' align='right'>%1</t>"
] spawn bis_fnc_typeText;

sleep 8;
"d_introtxt1" cutText [format [localize "STR_DOM_MISSIONSTRING_1434", actionKeysNames "TeamSwitch", actionKeysNames "User16", actionKeysNames "User15"], "PLAIN"];
xr_phd_invulnerable = false;

uiNamespace setVariable ["D_DomLabel", nil];
uiNamespace setVariable ["d_DomFour", nil];

if (name player == "Error: No unit" || {!isPlayer player}) then {
	hintC "Please rejoin again!!!! Your game has not connected correctly!!!!!";
};

diag_log [diag_frameno, diag_ticktime, time, "Dom intro ended"];