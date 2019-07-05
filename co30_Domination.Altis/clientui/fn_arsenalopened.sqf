// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_arsenalopened.sqf"
#include "..\x_setup.sqf"

d_arsenal_opened = true;

__TRACE_1("","d_arsenal_opened")

disableSerialization;
if (sunOrMoon < 0.9) then {
	d_arsenal_nvg_used = true;
	camUseNVG true;
};
params ["_disp"];
if (!d_with_ace) then {
	(_disp displayCtrl 44150) ctrlEnable false; // random
	(_disp displayCtrl 44148) ctrlEnable false; // export
	(_disp displayCtrl 44149) ctrlEnable false; // import
	(_disp displayCtrl 44151) ctrlEnable false; // hide
#ifdef __IFA3LITE__
	(_disp displayCtrl 44147) ctrlEnable false; // Load
	(_disp displayCtrl 44146) ctrlEnable false; // Save
#endif
	_disp displayAddEventHandler ["KeyDown", {(_this # 1) in [19, 29]}];
} else {
	(_disp displayCtrl 1004) ctrlEnable false;
	(_disp displayCtrl 1005) ctrlEnable false;
};
if (d_with_ranked) then {
	if (!d_with_ace) then {
		(_disp displayCtrl 44147) ctrlEnable false; // Load
		(_disp displayCtrl 44146) ctrlEnable false; // Save
		_disp displayAddEventHandler ["KeyDown", {
			_this # 3 && {_this # 1 == DIK_O}
		}];
	} else {
		(_disp displayCtrl 1003) ctrlEnable false;
	};
};
player setVariable ["d_currentvisionmode", currentVisionMode player];