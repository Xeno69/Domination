// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spect_oneframe.sqf"
#include "..\x_macros.sqf"

#define __dspctrl(ctrlid) ((uiNamespace getVariable "xr_SpectDlg") displayCtrl ctrlid)
#define __spectdlg1006e ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006)

//__TRACE("start one frame")
getMousePosition params ["_mpx", "_mpy"];
xr_mouseDeltaPos set [0, xr_mouseLastX - _mpx];
xr_mouseDeltaPos set [1, xr_mouseLastY - _mpy];
xr_mouseLastX = _mpx;
xr_mouseLastY = _mpy;
if (xr_MouseScroll != 0) then {
	xr_sdistance = xr_sdistance - (xr_MouseScroll * 0.11);
	xr_MouseScroll = xr_MouseScroll * 0.75;
	if (xr_sdistance > xr_maxDistance) then {
		xr_sdistance = xr_maxDistance;
	} else {
		if (xr_sdistance < -xr_maxDistance) then {
			xr_sdistance = -xr_maxDistance;
		};
	};
	if (xr_sdistance < -0.6) then {xr_sdistance = -0.6};
};

if (xr_MouseButtons # 0) then {
	if (isNull xr_spectcamtarget) exitWith {xr_cur_world_obj = objNull};
	private _cursObj = objNull;
	private _intsecs = [_mpx, _mpy, xr_spectcamtarget, vehicle xr_spectcamtarget] call BIS_fnc_getIntersectionsUnderCursor;
	
	if !(_intsecs isEqualTo []) then {
		_cursObj = (_intsecs # 0) # 3;
	};
	if (!isNull _cursObj && {!(_cursObj isKindOf "CAManBase")}) then {
		if !(crew _cursObj isEqualTo []) then {
			(crew _cursObj) findIf {
				_ret = _x call d_fnc_isplayer;
				if (_ret) then {
					_cursObj = _x;
				};
				_ret
			};
		} else {
			_cursObj = objNull;
		};
	};
	if (!isNull _cursObj && {side (group _cursObj) getFriend xr_side_pl < 0.6}) then {
		_cursObj = objNull;
	};
	xr_cur_world_obj = _cursObj;
};

private _fnc_gpln = d_fnc_getplayername;
private _helperls = [];
if (time > xr_spect_timer) then {
	__TRACE_1("","xr_spect_timer")
	if (!xr_pl_no_lifes) then {
		if (xr_x_withresp) then {
			private _pic = getText ((configOf player)>>"icon");
			if (_pic != "") then {
				_pic = getText (configFile >>"CfgVehicleIcons">>_pic);
			};
			_helperls pushBack [-100, xr_name_player, getPlayerUID player, [_pic, "#(argb,8,8,3)color(1,1,1,0)"] select (_pic == ""), [0, 1, 0, 0.9]];
		};
		
		private _vecp = vehicle player;
		private ["_dist", "_pic"];
		{
			_dist = (vehicle _x) distance2D _vecp;
			_pic = getText ((configOf _x)>>"icon");
			if (_pic != "") then {
				_pic = getText (configFile >>"CfgVehicleIcons">>_pic);
			};
			_helperls pushBack [_dist, format ["%3 (%1 m) %2", round _dist, ["", " (Uncon)"] select (_x getVariable ["xr_pluncon", false]), _x call _fnc_gpln], getPlayerUID _x, [_pic, "#(argb,8,8,3)color(1,1,1,0)"] select (_pic == ""), [[1, 1, 1, 0.8], [0, 1, 0, 0.9]] select (group _x == group player)];
		} forEach (d_allplayers select {_x != player});
	} else {
		private _sfm = markerPos "xr_playerparkmarker";
		private ["_distup", "_pic"];
		{
			_distup = _x distance2D _sfm;
			if (_distup > 100) then {
				_pic = getText ((configOf _x)>>"icon");
				if (_pic != "") then {
					_pic = getText (configFile >>"CfgVehicleIcons">>_pic);
				};
				_helperls pushBack [_distup, _x call _fnc_gpln, getPlayerUID _x, [_pic, "#(argb,8,8,3)color(1,1,1,0)"] select (_pic == ""), [1, 1, 1, 0.8]];
			};
		} forEach (d_allplayers select {_x != player});
	};
	xr_x_updatelb = true;
	xr_spect_timer = time + 10;
};

if (xr_x_updatelb && {!isNil {uiNamespace getVariable "xr_SpectDlg"}}) then {
	__TRACE_1("","xr_x_updatelb")
	xr_x_updatelb = false;
	private _lbctr = (uiNamespace getVariable "xr_SpectDlg") displayCtrl 1000;
	lbClear _lbctr;
	private ["_idx"];
	{
		_idx = _lbctr lbAdd (_x # 1);
		_lbctr lbSetData [_idx, _x # 2];
		_lbctr lbSetValue [_idx, _x # 0];
		_lbctr lbSetPicture [_idx, _x # 3];
		_lbctr lbSetColor [_idx, _x # 4];
	} forEach _helperls;
	__TRACE_1("","_helperls")
	private _setidx = -1;
	if !(_helperls isEqualTo []) then {
		lbSortByValue _lbctr;
		_setidx = 0;
		private _spectcamtargetstr = xr_spectcamtargetstr;
		for "_i" from 0 to (lbSize _lbctr) -1 do {
			if (_spectcamtargetstr == _lbctr lbData _i) exitWith {
				_setidx = _i;
			};
		};
	};
	__TRACE_1("","_setidx")
	if (_setidx != -1) then {_lbctr lbSetCurSel _setidx};
};
_helperls = nil;

if (!isNull xr_cur_world_obj && {xr_MouseButtons # 0 && {xr_cur_world_obj != xr_spectcamtarget}}) then {
	private _lbctr = (uiNamespace getVariable "xr_SpectDlg") displayCtrl 1000;
	private _str = getPlayerUID xr_cur_world_obj;
	for "_i" from 0 to (lbSize _lbctr) - 1 do {
		if (_str == _lbctr lbData _i) exitWith {
			[_lbctr, _i] call xr_fnc_targetsslbchange;
		};
	};
};

// user pressed ESC
private _spectdisp = uiNamespace getVariable "xr_SpectDlg";
if ((isNil "_spectdisp" || {!ctrlShown (_spectdisp displayCtrl 1002)}) && {!xr_stopspect && {player getVariable "xr_pluncon"}}) then {
	__TRACE("ctrl not shown anymore, black out")
	"xr_revtxt" cutText ["","BLACK OUT", 1];
	__TRACE("creating new dialog")
	createDialog "xr_SpectDlg";
	private _disp = uiNamespace getVariable "xr_SpectDlg";
	__dspctrl(1000) ctrlShow false;
	__dspctrl(3000) ctrlShow false;
	if (!xr_x_withresp) then {
		__dspctrl(1020) ctrlShow false;
		__dspctrl(1021) ctrlShow false;
		__dspctrl(1005) ctrlShow false;
		__dspctrl(1006) ctrlShow false;
	} else {
		if (xr_respawn_available) then {
			__spectdlg1006e ctrlSetText xr_x_loc_922;
			__spectdlg1006e ctrlSetTextColor [1,1,0,1];
			__spectdlg1006e ctrlCommit 0;
		};
	};
	if (!xr_pl_no_lifes) then {
		xr_spectcamtarget = player;
		xr_spectcamtargetstr = getPlayerUID player;
		xr_spectcam cameraEffect ["INTERNAL", "Back"];
		xr_spectcam camCommit 0;
		cameraEffectEnableHUD true;
		__dspctrl(1010) ctrlSetText xr_name_player;
	} else {
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
		private _campos = [(_nposvis # 0) - 1 + random 2, (_nposvis # 1) - 1 + random 2, 2];
		xr_spectcam = "camera" camCreate _campos;
		xr_spectcamtarget = _visobj;
		xr_spectcamtargetstr = getPlayerUID _visobj;
		xr_spectcam cameraEffect ["INTERNAL", "Back"];
		xr_spectcam camCommit 0;
		cameraEffectEnableHUD true;
		__dspctrl(1010) ctrlSetText (_visobj call _fnc_gpln);
	};
	xr_spect_timer = -1;
	__TRACE("ctrl not shown anymore, black in")
	"xr_revtxt" cutText ["","BLACK IN", 1];
	if (xr_pl_no_lifes) then {
		endMission "KILLED";
	};
};
if (isNull xr_spectcamtarget) then { // player disconnect !?!
	//private _nposvis = ASLToATL (visiblePositionASL (vehicle player));
	//private _campos = [(_nposvis # 0) - 1 + random 2, (_nposvis # 1) - 1 + random 2, 2];
	xr_spectcamtarget = player;
	xr_spectcamtargetstr = getPlayerUID player;
	xr_spectcam cameraEffect ["INTERNAL", "Back"];
	xr_spectcam camCommit 0;
	cameraEffectEnableHUD true;
	__dspctrl(1010) ctrlSetText xr_name_player;
};

private _bb = boundingBoxreal vehicle xr_spectcamtarget;
private _l = ((_bb # 1) # 1) - ((_bb # 0) # 1);
#define __hstr 0.15
if (isNil "xr_hhx") then {xr_hhx = 2};
xr_hhx = ((((_bb # 1) # 2) - ((_bb # 0) # 2)) * __hstr) + (xr_hhx * (1 - __hstr));

private _vpmtw = ASLToATL (visiblePositionASL (vehicle xr_spectcamtarget));
xr_spectcam camSetTarget (_vpmtw vectorAdd [0, 0, xr_hhx * 0.6]);
xr_spectcam camSetFov xr_szoom;

private _lsdist = _l * (0.3 max xr_sdistance);
private _d = -_lsdist;
private _co = cos xr_fangleY;
xr_spectcam camSetRelPos [(sin xr_fangle * _d) * _co, (cos xr_fangle * _d) * _co, sin xr_fangleY * _lsdist];
xr_spectcam camCommit 0;
cameraEffectEnableHUD true;
//__TRACE("end one frame")