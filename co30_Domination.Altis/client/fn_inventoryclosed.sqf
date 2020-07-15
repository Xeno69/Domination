// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_inventoryclosed.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (isNil "d_has_opened_arsenal") then {
	call d_fnc_pcheck;
} else {
	d_has_opened_arsenal = nil;
};

d_inventory_open = nil;
if (d_without_nvg == 0 || {d_without_vec_ti == 0}) then {
	call d_fnc_rem_ti_nvg_items;
};