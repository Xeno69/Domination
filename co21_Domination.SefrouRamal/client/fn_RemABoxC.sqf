// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if !(hasInterface) exitWith {};

params ["_box"];

{
	if (_x # 0 == _box || {!alive (_x # 0)}) then {
		d_all_p_a_boxes set [_forEachIndex, -1];
	};
} forEach d_all_p_a_boxes;
d_all_p_a_boxes = d_all_p_a_boxes - [-1];
__TRACE_1("","d_all_p_a_boxes")
