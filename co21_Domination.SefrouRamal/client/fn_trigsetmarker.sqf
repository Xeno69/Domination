// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _mar = (_this # 0) getVariable "d_trigmarker";

if (isNil "_mar") exitWith {
	__TRACE("isnil marker")
};

private _color = ["ColorGreen", "ColorRed"] select (_this # 1);

__TRACE_1("","_color")

_mar setMarkerColorLocal _color;
