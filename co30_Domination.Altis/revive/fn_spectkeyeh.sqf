// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

#include "\A3\ui_f\hpp\defineDIKCodes.inc"

//__TRACE_1("","_this")

private _res = false;
private _disp = uiNamespace getVariable "xr_SpectDlg";
if ((_this # 1) == DIK_N) then {
	if (!xr_camnvgon) then {
		camUseNVG true;
		xr_camnvgon = true;
		(_disp displayCtrl 1004) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1335a");
	} else {
		camUseNVG false;
		xr_camnvgon = false;
		(_disp displayCtrl 1004) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1335");
	};
	_res = true;
} else {
	if ((_this # 1) == DIK_M) then {
		//__TRACE("DIK M")
		if (ctrlShown (_disp displayCtrl 1000)) then {
			//__TRACE("1000 shown")
			ctrlShow [1000, false];
			(_disp displayCtrl 1003) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1334");
		};
		if (ctrlShown (_disp displayCtrl 3000)) then {
			//__TRACE("3000 shown")
			ctrlShow [3000, false];
			(_disp displayCtrl 1002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1333");
			d_x_loop_end = true;
		} else {
			//__TRACE("3000 NOT shown")
			ctrlShow [3000, true];
			(_disp displayCtrl 1002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1333a");
			call xr_fnc_updaterlb;
		};
		_res = true;
	} else {
		if ((_this # 1) == DIK_P) then {
			//__TRACE("DIK P")
			if (ctrlShown (_disp displayCtrl 3000)) then {
				ctrlShow [3000, false];
				(_disp displayCtrl 1002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1333");
				d_x_loop_end = true;
			};
			if (ctrlShown (_disp displayCtrl 1000)) then {
				ctrlShow [1000, false];
				(_disp displayCtrl 1003) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1334");
			} else {
				ctrlShow [1000, true];
				(_disp displayCtrl 1003) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1334a");
			};
			_res = true;
		} else {
			if ((_this # 1) == DIK_X && {xr_max_lives != -1 && {player getVariable ["xr_lives", 0] == -1}}) then {
				xr_stopspect = true;
				endMission "LOSER";
				forceEnd;
			};
		};
	};
};
//__TRACE_1("","_res")
_res