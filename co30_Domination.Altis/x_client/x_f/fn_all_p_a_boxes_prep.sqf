// by Xeno
#define THIS_FILE "fn_all_p_a_boxes_prep.sqf"
#include "..\..\x_setup.sqf"

private _pos_cam = positionCameraToWorld [0,0,0];
private ["_distp", "_col"];
d_all_p_a_boxes_prep = [];

{
	_x params ["_box"];
	_distp = _pos_cam distance _box;
	if (_distp < 80) then {
		_col = _x # 1;
		_col set [3, 1 - (_distp / 200)];
		d_all_p_a_boxes_prep pushBack ["#(argb,8,8,3)color(0,0,0,0)", _col, ASLToAGL ((getPosASL _box) vectorAdd [0, 0, 1.5 + (_distp * 0.05)]), 1, 1, 0, _x # 2, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (d_all_p_a_boxes select {!isNull (_x select 0)});