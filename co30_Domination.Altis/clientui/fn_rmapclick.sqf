// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

private _pos = _this # 1;

__TRACE_1("","_this")

private _idx = -1;
private _min = 100000000;
private "_dist";
{
	private _dist = _x distance2D _pos;
	if (_dist < 200 && {_dist < _min}) then {
		_idx = _forEachIndex;
		_min = _dist;
	};
} forEach d_respawn_posis;

__TRACE_1("","_idx")

private _same = true;
if (_idx != -1) then {
	private _disp = [uiNamespace getVariable "XR_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (d_rmapclick_type == 0);
	private _ctrl = _disp displayCtrl 1500;
	private _cursel = lbCurSel _ctrl;
	if (_cursel != _idx) then {
		private _dochange = true;
		if ((d_respawn_ismhq # _cursel) && {_pos inArea [d_respawn_posis # _cursel, 40, 40, 0, false]}) then {
			_dochange = false;
		};
		if (_dochange) then {
			_ctrl lbSetCurSel _idx;
			_same = false;
		};
	};
};

if (_same && {!isNil "d_cur_map_endpos" && {_pos inArea [d_cur_map_endpos, 40, 40, 0, false]}}) then {
	__TRACE("Is in")
	if !(_this # 2) then {
		"d_exactpos_sel_mar" setMarkerPosLocal _pos;
		d_alt_map_pos = _pos;
	} else {
		"d_exactpos_sel_mar" setMarkerPosLocal d_cur_map_endpos;
		d_alt_map_pos = nil;
	};
};
