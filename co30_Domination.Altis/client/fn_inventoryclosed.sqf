// by Xeno
#define THIS_FILE "fn_inventoryclosed.sqf"
#include "..\x_setup.sqf"

d_inventory_open = nil;
if (d_without_nvg == 0 || {d_without_vec_ti == 0}) then {
	call d_fnc_rem_ti_nvg_items;
};