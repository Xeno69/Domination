// by Xeno
//#include "..\x_macros.sqf"

//__TRACE("start one frame")

// user pressed ESC
private _spectdisp = uiNamespace getVariable "xr_SpectDlg";
if ((isNil "_spectdisp" || {!ctrlShown (_spectdisp displayCtrl 1002)}) && {!xr_stopspect} && {player getVariable "xr_pluncon"}) then {
	//__TRACE("ctrl not shown anymore, black out")
	"xr_revtxt" cutText ["", "BLACK OUT", 1];
	//__TRACE("creating new dialog")
	createDialog "xr_SpectDlg";
	private _disp = uiNamespace getVariable "xr_SpectDlg";
	(_disp displayCtrl 3000) ctrlShow false;
	if (!xr_x_withresp) then {
		(_disp displayCtrl 1020) ctrlShow false;
		(_disp displayCtrl 1021) ctrlShow false;
		(_disp displayCtrl 1005) ctrlShow false;
		(_disp displayCtrl 1006) ctrlShow false;
	} else {
		if (xr_respawn_available) then {
			((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006) ctrlSetText xr_x_loc_922;
			((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006) ctrlSetTextColor [1,1,0,1];
			((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006) ctrlCommit 0;
		};
	};
	xr_spectcamtarget = player;
	xr_spectcamtargetstr = getPlayerUID player;
	xr_spectcam camSetPos xr_no_spect_campos;
	xr_spectcam cameraEffect ["Internal", "Back"];
	xr_spectcam camSetTarget xr_spectcamtarget;
	xr_spectcam camCommit 0;
	(_disp displayCtrl 1010) ctrlSetText xr_name_player;
	//__TRACE("ctrl not shown anymore, black in")
	"xr_revtxt" cutText ["","BLACK IN", 1];
};
//__TRACE("end one frame")