// by Xeno
#define THIS_FILE "fn_teleportx.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (!isNull objectParent player) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_583")};

if (!isNull (flag player)) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_584")};

if (underwater player || {player call d_fnc_isswimming}) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_585")};

if (dialog) then {closeDialog 0};

d_beam_target = "";
// 0 = respawn, 1 = teleport
d_tele_dialog = [1, 2] select (d_WithTeleToBase == 0);

disableSerialization;

xr_respawn_available = true;

createDialog "d_TeleportDialog";

#define __CTRL(A) ((uiNamespace getVariable "d_TeleportDialog") displayCtrl A)

__CTRL(100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_533");
__CTRL(100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_586");

d_x_loop_end = false;

0 spawn {
	scriptName "spawn_teleportx_teleupdate";
	while {!d_x_loop_end && {alive player && {dialog}}} do {
		if (!d_x_loop_end && {alive player}) then {[0] call d_fnc_teleupdate_dlg};
		sleep 1.012;
	};
	if (!alive player) then {closeDialog 0};
	
	if (!isNil "d_resp_map_click_eh") then {
		removeMissionEventHandler ["MapSingleClick", d_resp_map_click_eh];
		d_resp_map_click_eh = nil;
		d_rmapclick_type = nil;
	};
	if (!isNil "d_respawn_posis") then {
		d_respawn_posis = nil;
	};
	if (!isNil "d_resp_lead_idx") then {
		d_resp_lead_idx = nil;
	};
};