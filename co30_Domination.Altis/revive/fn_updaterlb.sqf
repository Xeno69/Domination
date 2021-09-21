// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

d_x_loop_end = false;

disableSerialization;
if (xr_respawn_available) then {
	private _disp = uiNamespace getVariable "XR_SpectDlg";
	if (!isNil "_disp" && {!isNull _disp} && {lbCurSel (_disp displayCtrl 1500) == 0}) then {
		private _ctrl = _disp displayCtrl 100102;
		if (!ctrlEnabled _ctrl && {isNil "xr_pl_no_lifes" || {!xr_pl_no_lifes}}) then {
			_ctrl ctrlEnable true;
		};
	};
};

0 spawn {
	scriptName "spawn_updaterlb";
	sleep 0.1;
	while {!d_x_loop_end} do {
		if (!d_x_loop_end) then {[1] call d_fnc_teleupdate_dlg};
		sleep 1.012;
	};
	
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
