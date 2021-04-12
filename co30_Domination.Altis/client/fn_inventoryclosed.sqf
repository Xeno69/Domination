// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_inventoryclosed.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

d_inventory_open = nil;
if (d_without_nvg != 1 || {d_without_ti != 1}) then {
	call d_fnc_rem_ti_nvg_items;
};