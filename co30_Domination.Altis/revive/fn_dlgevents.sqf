// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dlgevents.sqf"
#include "..\x_macros.sqf"

switch (_this select 0) do {
	case "MouseButtonDown": {
		xr_MouseButtons set [(_this select 1) select 1, true];
		if (!xr_mousecheckon) then {
			0 spawn xr_fnc_MouseDownClickedLoop;
		};
	};
	case "MouseButtonUp": {
		xr_MouseButtons set[(_this select 1) select 1, false];
	};
	case "MouseZChanged": {
		xr_MouseScroll = xr_MouseScroll + ((_this select 1) select 1);
	};
};
