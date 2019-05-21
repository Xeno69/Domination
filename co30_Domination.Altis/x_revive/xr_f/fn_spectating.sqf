// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spectating.sqf"
#include "..\..\x_macros.sqf"

if (!hasInterface) exitWith {};

__TRACE("start")
xr_MouseScroll = 0;
xr_MouseButtons = [false,false];
xr_mouseDeltaPos = [0,0];
xr_mouseLastX = 0.5;
xr_mouseLastY = 0.5;
xr_maxDistance = 50;
xr_sdistance = 1;
xr_szoom = 0.976;
xr_fangle = 0;
xr_fangleY = 15;
xr_mousecheckon = false;
disableSerialization;
hintSilent "";
if (!isNil "xr_stopspect" && {!xr_stopspect}) then  {
	waitUntil {xr_stopspect};
	sleep 0.2;
};
xr_stopspect = false;
enableRadio false;
params ["_withresp"];
__TRACE_1("","_withresp")
if (_withresp) then {
	__TRACE("_withresp, cutText")
	"xr_revtxt2" cutText [localize "STR_DOM_MISSIONSTRING_921","PLAIN", 0];
	sleep 3;
};
__TRACE("black in 3")
"xr_revtxt" cutText ["","BLACK IN", 3];
xr_pl_no_lifes = [false, player getVariable "xr_lives" == -1] select (xr_max_lives > -1);
__TRACE_1("","xr_pl_no_lifes")
xr_camnvgon = false;
d_x_loop_end = false;
xr_cur_world_pos = [0,0,0];
xr_cur_world_obj = objNull;
createDialog "xr_SpectDlg";
private _disp = uiNamespace getVariable "xr_SpectDlg";
#define __dspctrl(ctrlid) (_disp displayCtrl ctrlid)
#define __spectdlg1006e ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006)
if (!_withresp) then {
	__dspctrl(1020) ctrlShow false;
	__dspctrl(1021) ctrlShow false;
	__dspctrl(1005) ctrlShow false;
	__dspctrl(1006) ctrlShow false;
} else {
	if (xr_respawn_available) then {
		__spectdlg1006e ctrlSetText (localize "STR_DOM_MISSIONSTRING_922");
		__spectdlg1006e ctrlSetTextColor [1,1,0,1];
		__spectdlg1006e ctrlCommit 0;
	};
};

private _helperls = [];
private _fnc_gpn = d_fnc_getplayername;
if (!xr_pl_no_lifes) then {
	if (_withresp) then {
		private _pic = getText (configFile >>"CfgVehicles">>typeOf player>>"icon");
		if (_pic != "") then {
			_pic = getText (configFile >>"CfgVehicleIcons">>_pic);
		};
		_helperls pushBack [-100, xr_name_player, xr_strpl, [_pic, "#(argb,8,8,3)color(1,1,1,0)"] select (_pic == ""), d_pnhudgroupcolor];
	};
	
	private _vecpplxp = vehicle player;
	private _grppl = group player;
	private ["_dist", "_pic"];
	{
		_dist = (vehicle _x) distance2D _vecpplxp;
		_pic = getText (configFile >>"CfgVehicles">>typeOf _x>>"icon");
		if (_pic != "") then {
			_pic = getText (configFile >>"CfgVehicleIcons">>_pic);
		};
		_helperls pushBack [_dist, format [(_x call _fnc_gpn) + " (%1 m) %2", round _dist, ["", " (Uncon)"] select (_x getVariable ["xr_pluncon", false])], str _x, [_pic, "#(argb,8,8,3)color(1,1,1,0)"] select (_pic == ""), [d_pnhudothercolor, d_pnhudgroupcolor] select (group _x == _grppl)];
	} forEach (d_allplayers select {_x != player});
	
} else {
	private _sfm = markerPos "xr_playerparkmarker";
	private ["_dist", "_pic"];
	{
		_distup = (vehicle _x) distance2D _sfm;
		if (_distup > 100) then {
			_pic = getText (configFile >>"CfgVehicles">>typeOf _x>>"icon");
			if (_pic != "") then {
				_pic = getText (configFile >>"CfgVehicleIcons">>_pic);
			};
			_helperls pushBack [_distup, _x call _fnc_gpn, str _x, [_pic, "#(argb,8,8,3)color(1,1,1,0)"] select (_pic == ""), d_pnhudothercolor];
		};
	} forEach (d_allplayers select {_x != player});
};

__TRACE_1("","_helperls")
__TRACE_1("","xr_strpl")

private _lbctr = (uiNamespace getVariable "xr_SpectDlg") displayCtrl 1000;
lbClear _lbctr;
private ["_idx"];
{
	__TRACE_1("","_x")
	_idx = _lbctr lbAdd (_x # 1);
	__TRACE_1("","_idx")
	_lbctr lbSetData [_idx, _x # 2];
	_lbctr lbSetValue [_idx, _x # 0];
	_lbctr lbSetPicture [_idx, _x # 3];
	_lbctr lbSetColor [_idx, _x # 4];
} forEach _helperls;
if !(_helperls isEqualTo []) then {
	__TRACE("LB Sort By Value")
	lbSortByValue _lbctr;
	_lbctr lbSetCurSel 0;
};

_aaa = lbSize _lbctr;
__TRACE_1("","_aaa")

__TRACE_1("","xr_pl_no_lifes")
showCinemaBorder false;
if (!xr_pl_no_lifes) then {
	private _nposvis = ASLToATL (visiblePositionASL (vehicle player));
	xr_spectcam = "camera" camCreate [(_nposvis # 0) - 1 + random 2, (_nposvis # 1) - 1 + random 2, 2];
	xr_spectcamtarget = player;
	xr_spectcamtargetstr = xr_strpl;
	xr_spectcam cameraEffect ["INTERNAL", "Back"];
	xr_spectcam camCommit 0;
	cameraEffectEnableHUD true;
	__dspctrl(1010) ctrlSetText xr_name_player;
	
	call xr_fnc_nearplayercheckui
} else {
	__dspctrl(9998) ctrlEnable false;
	__dspctrl(9998) ctrlSetText "";
	__dspctrl(100102) ctrlEnable false;
	__dspctrl(100102) ctrlShow false;
	
	private _sfm = markerPos "xr_playerparkmarker";
	private _visobj = objNull;
	d_allplayers findIf {
		_ret = _x != player && {_x distance2D _sfm > 100};
		if (_ret) then {
			_visobj = _x;
		};
		_ret
	};
	if (isNull _visobj) then {_visobj = player};
	private _nposvis = ASLToATL (visiblePositionASL (vehicle _visobj));
	xr_spectcam = "camera" camCreate [(_nposvis # 0) - 1 + random 2, (_nposvis # 1) - 1 + random 2, 2];
	xr_spectcamtarget = _visobj;
	xr_spectcamtargetstr = str _visobj;
	xr_spectcam cameraEffect ["INTERNAL", "Back"];
	xr_spectcam camCommit 0;
	cameraEffectEnableHUD true;
	__dspctrl(1010) ctrlSetText (_visobj call _fnc_gpn);
};

xr_meh_draw3d = addMissionEventhandler ["Draw3D", {call xr_fnc_spectdraw3d}];

xr_x_updatelb = false;
xr_spect_timer = time + 10;
xr_x_withresp = _withresp;
xr_x_loc_922 = localize "STR_DOM_MISSIONSTRING_922";
__TRACE("main one frame loop starts")
["dom_xr_spect_of", {
	if (!xr_stopspect) then {
		call xr_fnc_spect_oneframe;
	} else {
		["dom_xr_spect_of"] call d_fnc_eachframeremove;
		removeMissionEventHandler ["Draw3D", xr_meh_draw3d];
		d_x_loop_end = true;
		closeDialog 0;
		player switchCamera "INTERNAL";
		xr_spectcam cameraEffect ["Terminate", "Back"];
		camDestroy xr_spectcam;
		enableRadio true;
		xr_x_withresp = nil;
		xr_x_updatelb = nil;
		xr_spect_timer = nil;
		xr_hhx = nil;
		xr_cur_world_pos = nil;
		xr_cur_world_obj = nil;
		__TRACE("spectating ended, one frame removed")
	};
}, 0.01] call d_fnc_eachframeadd;
