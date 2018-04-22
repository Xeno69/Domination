// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_buildingchanged.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

params ["_building"];

if (_building isKindOf "Ruins") exitWith {
	__TRACE("Building is a ruin")
};

if (!isNil "d_cur_tgt_pos" && {_building distance2D d_cur_tgt_pos < 800}) then {
	d_house_objects pushBackUnique _building;
} else {
	d_house_objects2 pushBackUnique _building;
};