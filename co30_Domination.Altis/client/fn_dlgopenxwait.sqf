// by Xeno
#define THIS_FILE "fn_dlgopenxwait.sqf"
#include "..\x_setup.sqf"

sleep 0.1;
while {!d_x_loop_end && {d_teleport_dialog_open && {alive player}}} do {
	if (!d_x_loop_end && {alive player}) then {[0] call d_fnc_teleupdate_dlg};
	sleep 1.012;
};
if (!alive player && {d_teleport_dialog_open}) then {closeDialog 0};

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