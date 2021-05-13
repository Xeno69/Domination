// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

diag_log [diag_frameno, diag_ticktime, time, "Dom intro started"];

enableRadio false;
showChat false;

while {true} do {
	sleep 0.112;
	if (!isNil "d_preloaddone") exitWith {
		sleep 0.3;
	};
};

private _campos = if (isNil "d_cur_tgt_pos" || {d_cur_tgt_pos isEqualTo []}) then {player} else {d_cur_tgt_pos};
__TRACE_1("","_campos")

sleep 0.01;
1 fadeSound 1;
1 fadeEnvironment 1;

d_still_in_intro = true;

private ["_plicon", "_color"];
call {
	if (d_player_side == blufor) exitWith {
		_plicon = getText(configFile >> "CfgMarkers" >> "b_inf" >> "icon");
		_color = [blufor] call BIS_fnc_sidecolor;
	};
	if (d_player_side == opfor) exitWith {
		_plicon = getText(configFile >> "CfgMarkers" >> "o_inf" >> "icon");
		_color = [opfor] call BIS_fnc_sidecolor;
	};
	_plicon = getText(configFile >> "CfgMarkers" >> "n_inf" >> "icon");
	_color = [independent] call BIS_fnc_sidecolor;
};

private _txt = "Domination! 4 ";

#ifndef __TT__
_txt = _txt + "One Team - " + d_version_string;
if (d_with_ai) then {_txt = _txt + " AI"};
#else
_txt = _txt + "Two Teams";
#endif
if (d_with_ranked) then {_txt = _txt + " RANKED"};
if (d_WithRevive == 0) then {_txt = _txt + " REVIVE"};

#ifndef __IFA3LITE__
if (sunOrMoon < 0.99 && {d_without_nvg == 1 && {player call d_fnc_hasnvgoggles}}) then {player action ["NVGoggles", player]};
#endif

titleText ["", "BLACK IN", 3];
if (!isNil "BIS_fnc_establishingShot_fakeUAV") then {
	camDestroy BIS_fnc_establishingShot_fakeUAV;
};
BIS_fnc_establishingShot_fakeUAV = nil;

private _bfehandle = [_campos, _txt, 200, 250, 75, 1,
	[
	   [_plicon, _color, player, 1, 1, 0, profileName, 0]
	]
] spawn BIS_fnc_establishingShot;

sleep 1;
"d_Xlabel" cutRsc ["d_Xlabel", "PLAIN"];
"d_DomLabel" cutRsc ["d_DomLabel", "PLAIN"];
"d_ArmaLogo" cutRsc ["d_ArmaLogo", "PLAIN"];
sleep 2;
"d_rscmtexts" cutRsc ["d_rscmtexts", "PLAIN"];

0 = [parseText format [ "<br/><t font='PuristaMedium' align='left' size='2.3'> Welcome to Domination! 4</t><br/>  <t align='left' size='1'>  Version 4.51  </t>"], [safeZoneX + 0.1, safeZoneY + safeZoneH - 0.2, 0.9, 0.3], nil, 5, 1, 0]  spawn BIS_fnc_textTiles;

waitUntil {scriptDone _bfehandle};
enableSaving [false, false];
#ifndef __VN__
0 spawn {
	scriptName "spawn disable environment intro2";
	sleep 15;
	enableEnvironment [false, true];
};
#endif

"d_Xlabel" cutFadeout 1;
"d_DomLabel" cutFadeout 1;
"d_ArmaLogo" cutFadeout 1;

enableRadio true;
showChat true;

#ifndef __IFA3LITE__
if (sunOrMoon < 0.99 && {d_without_nvg == 1 && {player call d_fnc_hasnvgoggles}}) then {player action ["NVGoggles", player]};
#endif

private _uidcheck_done = false;
if (d_reserved_slot isNotEqualTo [] && {str player in d_reserved_slot}) then {
	_uidcheck_done = true;
	0 spawn d_fnc_reservedslot;
};
if (!_uidcheck_done && {d_uid_reserved_slots isNotEqualTo []} && {d_uids_for_reserved_slots isNotEqualTo []}) then {
	d_uid_reserved_slots = d_uid_reserved_slots apply {toLowerANSI _x};
	if ((toLowerANSI str player) in d_uid_reserved_slots) then {
		if !(getPlayerUID player in d_uids_for_reserved_slots) then {
			0 spawn d_fnc_reservedslot2;
		};
		d_uid_reserved_slots = nil;
		d_uids_for_reserved_slots = nil;
	};
};

d_still_in_intro = false;

sleep 5;

[
	[
		[localize "STR_DOM_MISSIONSTRING_265", "<t size='1.0' font='RobotoCondensed'>%1</t><br/>", 0],
		[profileName, "<t size='1.0' font='RobotoCondensed'>%1</t><br/>", 5],
		[localize "STR_DOM_MISSIONSTRING_266", "<t size='0.9'>%1</t><br/>", 27]
	],
	-safezoneX, 0.85,"<t color='#FFFFFFFF' align='right'>%1</t>"
] spawn bis_fnc_typeText;

sleep 8;
"d_introtxt1" cutText [format [localize "STR_DOM_MISSIONSTRING_1434", actionKeysNames "TeamSwitch", actionKeysNames d_3dmarker_userakey_str, actionKeysNames d_earplugs_userakey_str], "PLAIN"];
xr_phd_invulnerable = false;

if (!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}) then {
	0 spawn d_fnc_statusbar;
};

sleep 3;

if (d_WithMHQTeleport == 0) then {
	"d_introtxt2" cutText [format ["<t color='#ff0000' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_1988"], "PLAIN DOWN", -1, true, true];
};

4 fadeMusic 0;
0 spawn {
	scriptName "spawn_music_intro2";
	sleep 120;
	0 fadeMusic 1;
};

diag_log [diag_frameno, diag_ticktime, time, "Dom intro ended"];
