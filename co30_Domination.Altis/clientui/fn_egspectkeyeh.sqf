// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_egspectkeyeh.sqf"
#include "..\x_setup.sqf"
#include "\A3\ui_f\hpp\defineDIKCodes.inc"

if (_this # 1 == DIK_X) then {
	xr_phd_invulnerable = false;
	(["GetDisplay"] call BIS_fnc_EGSpectator) displayRemoveEventHandler ["KeyDown" ,d_spect_disp_handler];
	["Terminate"] call BIS_fnc_EGSpectator;
	d_commandingMenuIniting = false;
	d_rscspect_on = false;
	if (!isNil "d_spect_viewdistance") then {
		if (d_spect_viewdistance != viewDistance) then {
			setViewDistance d_spect_viewdistance;
		};
		d_spect_viewdistance = nil;
	};
	"d_adminspecttxt" cutText ["", "PLAIN"];
	true
} else {
	false
};