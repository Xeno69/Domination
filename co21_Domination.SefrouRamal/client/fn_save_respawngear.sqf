// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_without_nvg != 1 || {d_without_ti != 1}) then {
	call d_fnc_rem_ti_nvg_items;
};

private _ar =+ getUnitLoadout player;
player setVariable ["d_respawngear", _ar];
