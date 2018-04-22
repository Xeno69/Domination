// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_RemABoxC.sqf"
#include "..\..\x_setup.sqf"

private _nobjs = nearestObjects [param [0], [d_the_box], 10, false];
__TRACE_2("","_nobjs","_this")
if !(_nobjs isEqualTo []) then {
	private _box = _nobjs param [0];
	private _unit = param [1];
	if (!isNil "_unit" && {!isNull _unit}) then {
		_unit setVariable ["d_boxcargo", [_box call BIS_fnc_getVirtualWeaponCargo, _box call BIS_fnc_getVirtualMagazineCargo, _box call BIS_fnc_getVirtualItemCargo, _box call BIS_fnc_getVirtualBackpackCargo]];
	};
	{
		if (_x # 0 == _box || {isNull (_x # 0)}) then {
			d_all_p_a_boxes set [_forEachIndex, -1];
		};
	} forEach d_all_p_a_boxes;
	d_all_p_a_boxes = d_all_p_a_boxes - [-1];
	__TRACE_1("","d_all_p_a_boxes")
	deleteVehicle _box;
};