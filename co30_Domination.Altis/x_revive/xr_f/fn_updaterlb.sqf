// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_updaterlb.sqf"
#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

d_x_loop_end = false;

disableSerialization;
if (xr_respawn_available) then {
	private _disp = uiNamespace getVariable "XR_SpectDlg";
	if (!isNil "_disp" && {!isNull _disp} && {lbCurSel (_disp displayCtrl 1500) == 0}) then {
		private _ctrl = _disp displayCtrl 100102;
		if (!ctrlEnabled _ctrl) then {
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
};
