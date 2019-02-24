// by Xeno
#define THIS_FILE "fn_mhq_3ddraw_prep.sqf"
#include "..\..\x_setup.sqf"

private _pos_cam = positionCameraToWorld [0,0,0];
private ["_distp"];
d_mhq_3ddraw_prep = [];

{
	_distp = _pos_cam distance _x;
	if (_distp < 150) then {
		d_mhq_3ddraw_prep pushBack ["#(argb,8,8,3)color(0,0,0,0)", [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 5 + (_distp * 0.05)]), 1, 1, 0, format ["MHQ %1", _x getVariable "d_ma_text"], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (d_mhq_3ddraw select {alive _x});