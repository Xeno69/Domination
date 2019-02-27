// by Xeno
#define THIS_FILE "fn_allai_recruit_objs_prep.sqf"
#include "..\..\x_setup.sqf"

private _pos_cam = positionCameraToWorld [0,0,0];
private ["_distp"];
d_allai_recruit_objs_prep = [];

private ["_distp"];
{
	_distp = _pos_cam distance _x;
	if (_distp < 150) then {
		d_allai_recruit_objs_prep pushBack ["#(argb,8,8,3)color(0,0,0,0)", [1,1,0,1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0, 0, 3 + (_distp * 0.05)]), 1, 1, 0, d_d3d_locsaire, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach d_allai_recruit_objs;

