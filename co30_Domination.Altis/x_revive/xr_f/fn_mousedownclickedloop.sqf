// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mousedownclickedloop.sqf"
#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

__TRACE("on")
xr_mousecheckon = true;
while {xr_MouseButtons # 1 || {xr_MouseButtons # 0 || {!isNil "xr_mouse_end"}}} do {
	if (!(xr_MouseButtons # 0) && {xr_MouseButtons # 1}) then {
		xr_fangle = xr_fangle - ((xr_mouseDeltaPos # 0) * 360);
		xr_fangleY = xr_fangleY + ((xr_mouseDeltaPos # 1) * 180);
		if (xr_fangleY > 89) then {
			xr_fangleY = 89;
		} else {
			if (xr_fangleY < -89) then {
				xr_fangleY = -89;
			};
		};
	} else {
		if ((xr_MouseButtons # 0) && {!(xr_MouseButtons # 1)}) then {
			xr_sdistance = xr_sdistance - ((xr_mouseDeltaPos # 1) * 10);
			if (xr_sdistance > xr_maxDistance) then {
				xr_sdistance = xr_maxDistance;
			} else {
				if (xr_sdistance < -xr_maxDistance) then {
					xr_sdistance = -xr_maxDistance;
				};
			};
			if (xr_sdistance < -0.6) then {xr_sdistance = -0.6};
		} else {
			if (xr_MouseButtons # 0 && {xr_MouseButtons # 1}) then {
				xr_szoom = xr_szoom - ((xr_mouseDeltaPos # 1) * 3);
				if (xr_szoom > 2) then {
					xr_szoom = 2;
				} else {
					if (xr_szoom < 0.05) then {
						xr_szoom = 0.05;
					};
				};
			};
		};
	};
	sleep 0.0034;
};
xr_mousecheckon = false;
xr_mouse_end = nil;
__TRACE("off")