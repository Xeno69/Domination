// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spectdlginit.sqf"
#include "..\..\x_macros.sqf"

disableSerialization;

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

params ["_disp"];

_disp displayAddEventHandler ["KeyDown", {
	private _res = false;
	if (_this select 1 == DIK_N) then {
		if (!xr_camnvgon) then {
			camUseNVG true;
			xr_camnvgon = true;
			((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1004) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1335a");
		} else {
			camUseNVG false;
			xr_camnvgon = false;
			((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1004) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1335");
		};
		_res = true;
	} else {
		if (_this select 1 == DIK_M) then {
			if (ctrlShown ((uiNamespace getVariable "'XR_SpectDlg") displayCtrl 1000)) then {
				ctrlShow [1000, false];
				((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1003) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1334");
			};
			if (ctrlShown ((uiNamespace getVariable "XR_SpectDlg") displayCtrl 3000)) then {
				ctrlShow [3000, false];
				((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1333");
				d_x_loop_end = true;
			} else {
				ctrlShow [3000, true];
				((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1333a");
				call xr_fnc_updaterlb;
			};
			_res = true;
		} else {
			if (_this select 1 == DIK_P) then {
				if (ctrlShown ((uiNamespace getVariable "XR_SpectDlg") displayCtrl 3000)) then {
					ctrlShow [3000, false];
					((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1333");
				};
				if (ctrlShown ((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1000)) then {
					ctrlShow [1000, false];
					((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1003) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1334");
				} else {
					ctrlShow [1000, true];
					((uiNamespace getVariable "XR_SpectDlg") displayCtrl 1003) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1334a");
				};
				_res = true;
			};
		};
	};
	_res
}];

false
