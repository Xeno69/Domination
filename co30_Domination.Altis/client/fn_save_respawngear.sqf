// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_save_respawngear.sqf"
#include "..\x_setup.sqf"

// TODO FOR TI HELMETS, maybe also for TI Goggles

if (!hasInterface) exitWith {};

if (d_without_nvg == 0 || {d_without_vec_ti == 0}) then {
	call d_fnc_rem_ti_nvg_items;
};

private _ar =+ getUnitLoadout player;
player setVariable ["d_respawngear", _ar];