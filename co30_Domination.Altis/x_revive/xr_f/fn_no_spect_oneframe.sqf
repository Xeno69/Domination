// by Xeno
#define THIS_FILE "fn_no_spect_oneframe.sqf"
#include "..\..\x_macros.sqf"

#define __dspctrl(ctrlid) (_disp displayCtrl ctrlid)
#define __spectdlg1006e ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006)

__TRACE("start one frame")

// user pressed ESC
private _spectdisp = uiNamespace getVariable "xr_SpectDlg";
if ((isNil "_spectdisp" || {!ctrlShown (_spectdisp displayCtrl 1002)}) && {!xr_stopspect} && {player getVariable "xr_pluncon"}) then {
	__TRACE("ctrl not shown anymore, black out")
	"xr_revtxt" cutText ["", "BLACK OUT", 1];
	__TRACE("creating new dialog")
	createDialog "xr_SpectDlg";
	private _disp = uiNamespace getVariable "xr_SpectDlg";
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
	xr_spectcamtarget = player;
	xr_spectcamtargetstr = xr_strpl;
	xr_spectcam camSetPos xr_no_spect_campos;
	xr_spectcam cameraEffect ["Internal", "Back"];
	xr_spectcam camSetTarget xr_spectcamtarget;
	xr_spectcam camCommit 0;
	__dspctrl(1010) ctrlSetText xr_name_player;
	__TRACE("ctrl not shown anymore, black in")
	"xr_revtxt" cutText ["","BLACK IN", 1];
};
__TRACE("end one frame")