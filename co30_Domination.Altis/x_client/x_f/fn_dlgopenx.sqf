// by Xeno
#define THIS_FILE "fn_dlgopenx.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

if (dialog) then {closeDialog 0};

d_beam_target = "";
d_tele_dialog = 0; // 0 = respawn, 1 = teleport

disableSerialization;

xr_respawn_available = true;

createDialog "d_TeleportDialog";

#define __CTRL(A) ((uiNamespace getVariable "d_TeleportDialog") displayCtrl A)
__CTRL(100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_298");
__CTRL(100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_299");

d_x_loop_end = false;

0 spawn {
	scriptName "spawn_x_open_teleupdate";
	sleep 0.1;
	while {!d_x_loop_end && {d_teleport_dialog_open && {alive player}}} do {
		if (!d_x_loop_end && {alive player}) then {[0] call d_fnc_teleupdate_dlg};
		sleep 1.012;
	};
	if (!alive player && {d_teleport_dialog_open}) then {closeDialog 0};
};
