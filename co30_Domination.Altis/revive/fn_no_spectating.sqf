// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_no_spectating.sqf"
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

if (player getVariable "xr_lives" == -1) exitWith {
	[false] spawn xr_fnc_spectating;
};

__TRACE("start")
disableSerialization;
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
"xr_revtxt" cutText ["", "BLACK IN", 3];
xr_camnvgon = false;
d_x_loop_end = false;
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

showCinemaBorder false;
private _nposvis = ASLToATL (visiblePositionASL (vehicle player));
xr_no_spect_campos = [(_nposvis # 0) - 1 + random 2, (_nposvis # 1) - 1 + random 2, 3];
xr_spectcam = "camera" camCreate xr_no_spect_campos;
xr_spectcamtarget = player;
xr_spectcamtargetstr = getPlayerUID player;
xr_spectcam cameraEffect ["Internal", "Back"];
xr_spectcam camSetTarget xr_spectcamtarget;
xr_spectcam camCommit 0;
xr_x_withresp = _withresp;
__dspctrl(1010) ctrlSetText xr_name_player;
xr_x_loc_922 = localize "STR_DOM_MISSIONSTRING_922";
__TRACE("main no spectating one frame loop starts")
["dom_xr_no_spect_of", {
	if (!xr_stopspect) then {
		call xr_fnc_no_spect_oneframe;
	} else {
		["dom_xr_no_spect_of"] call d_fnc_eachframeremove;
		d_x_loop_end = true;
		closeDialog 0;
		player switchCamera "INTERNAL";
		xr_spectcam cameraEffect ["Terminate", "Back"];
		camDestroy xr_spectcam;
		enableRadio true;
		xr_x_withresp = nil;
		xr_no_spect_campos = nil;
		__TRACE("no spectating ended, one frame removed")
	};
}, 0.01] call d_fnc_eachframeadd;
