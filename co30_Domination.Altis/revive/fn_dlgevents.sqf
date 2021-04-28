// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (_this # 0 == "MouseButtonDown") exitWith {
	xr_MouseButtons set [(_this # 1) # 1, true];
	if (!xr_mousecheckon) then {
		0 spawn xr_fnc_MouseDownClickedLoop;
	};
};
if (_this # 0 == "MouseButtonUp") exitWith {
	xr_MouseButtons set[(_this # 1) # 1, false];
};
if (_this # 0 == "MouseZChanged") then {
	xr_MouseScroll = xr_MouseScroll + ((_this # 1) # 1);
};
