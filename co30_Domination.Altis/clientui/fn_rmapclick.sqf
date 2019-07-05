// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rmapclick.sqf"
#include "..\x_setup.sqf"

disableSerialization;

private _pos = _this select 1;

__TRACE_1("","_pos")

private _idx = d_respawn_posis findIf {
	__TRACE_3("","_x","_pos","_x distance2D _pos")
	_x distance2D _pos < 200
};

__TRACE_1("","_idx")

if (_idx != -1) then {
	private _disp = [uiNamespace getVariable "XR_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (d_rmapclick_type == 0);
	private _ctrl = _disp displayCtrl 1500;
	
	if (lbCurSel _ctrl != _idx) then {
		_ctrl lbSetCurSel _idx;
	};
};