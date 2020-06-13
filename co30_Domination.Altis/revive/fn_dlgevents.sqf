// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dlgevents.sqf"
#include "..\x_macros.sqf"

call {
	if (_this select 0 == "MouseButtonDown") exitWith {
		xr_MouseButtons set [(_this select 1) select 1, true];
		if (!xr_mousecheckon) then {
			0 spawn xr_fnc_MouseDownClickedLoop;
		};
	};
	if (_this select 0 == "MouseButtonUp") exitWith {
		xr_MouseButtons set[(_this select 1) select 1, false];
	};
	if (_this select 0 == "MouseZChanged") then {
		xr_MouseScroll = xr_MouseScroll + ((_this select 1) select 1);
	};
};
