// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_buildingchanged.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_building"];

if (_building isKindOf "Ruins") exitWith {
	__TRACE_1("Building is a ruin","_building")
};

if (damage _building == 0) exitWith {
	__TRACE_1("No damage","_building")
};

if (!isNil "d_cur_tgt_pos" && {!(d_cur_tgt_pos isEqualTo []) && {_building distance2D d_cur_tgt_pos < 1000}}) then {
	d_house_objects pushBackUnique _building;
} else {
	d_house_objects2 pushBackUnique _building;
};