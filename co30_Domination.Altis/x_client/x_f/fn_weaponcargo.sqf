// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_weaponcargo.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

__TRACE_1("","_this")

params ["_vec"];
clearMagazineCargo _vec;
clearWeaponCargo _vec;
clearItemCargo _vec;
clearBackpackCargo _vec;

_vec setVariable ["d_player_ammobox", true];

#ifdef __TT__
private _p2 = _this select 1;
if (isNil "_p2" || {d_player_side == _p2}) then {
#endif
d_all_p_a_boxes pushBack [_vec, [1,1,0,0], localize "STR_DOM_MISSIONSTRING_1585"]; // yellow, Text "Virtual Arsenal"
__TRACE_1("","d_all_p_a_boxes")
#ifdef __TT__
};
#endif

__TRACE_1("","_vec")

if (d_with_ranked) then {
	[_vec] spawn d_fnc_weaponcargo_ranked;
};
