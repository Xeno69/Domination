// by Xeno
#define THIS_FILE "fn_newflagclient.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _flag = _this;

player reveal _flag;

if (d_jumpflag_vec == "") then {
	_flag setVariable ["d_jf_id", _flag addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 1]];
} else {
	_flag setVariable ["d_jf_id", _flag addAction [format ["<t color='#AAD9EF'>%1</t>", format [localize "STR_DOM_MISSIONSTRING_297", [d_jumpflag_vec, "CfgVehicles"] call d_fnc_GetDisplayName], {_this spawn d_fnc_bike}, [d_jumpflag_vec,1]]]];
};
