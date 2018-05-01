// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_admindialog.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;

if (isMultiplayer && {!d_pisadminp}) exitWith {
	[player, d_name_pl, 3] remoteExecCall ["d_fnc_KickPlayerBS", 2];
};

xr_phd_invulnerable = true;

createDialog "d_AdminDialog";
private _ctrl = (uiNamespace getVariable "d_AdminDialog") displayCtrl 1001;

lbClear _ctrl;
{
	private _index = _ctrl lbAdd (_x call d_fnc_getplayername);
	_ctrl lbSetData [_index, str _x];
	false
} count ((allPlayers - entities "HeadlessClient_F") select {!isNull _x});

_ctrl lbSetCurSel 0;
ctrlSetFocus ((uiNamespace getVariable "d_AdminDialog") displayCtrl 1212);

0 spawn {
	scriptName "spawn_d_fnc_admindialog_kicker";
	disableSerialization;
	d_a_d_p_kicked = nil;
	private _ctrl = (uiNamespace getVariable "d_AdminDialog") displayCtrl 1001;
	while {alive player && {d_admin_dialog_open}} do {
		if (!isNil "d_a_d_p_kicked") then {
			d_a_d_p_kicked = nil;
			lbClear _ctrl;
			{
				private _index = _ctrl lbAdd (_x call d_fnc_getplayername);
				_ctrl lbSetData [_index, str _x];
				false
			} count ((allPlayers - entities "HeadlessClient_F") select {!isNull _x});
			_ctrl lbSetCurSel 0;
		};
		sleep 0.2;
	};
	if (d_admin_dialog_open) then {
		closeDialog 0;
	};
	xr_phd_invulnerable = false;
	sleep 0.5;
	deleteMarkerLocal "d_admin_marker";
};