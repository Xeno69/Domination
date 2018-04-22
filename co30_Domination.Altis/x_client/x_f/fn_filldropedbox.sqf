// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_filldropedbox.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_box", "_boxcargo"];

_box setVariable ["d_player_ammobox", true];

clearMagazineCargo _box;
clearWeaponCargo _box;
clearItemCargo _box;
clearBackpackCargo _box;

[_box, _boxcargo # 0, false, false] call BIS_fnc_addVirtualWeaponCargo;
[_box, _boxcargo # 1, false, false] call BIS_fnc_addVirtualMagazineCargo;
[_box, _boxcargo # 2, false, false] call BIS_fnc_addVirtualItemCargo;
[_box, _boxcargo # 3, false, false] call BIS_fnc_addVirtualBackpackCargo;

#ifdef __TT__
private _p2 = param [2];
if (isNil "_p2" || {d_player_side == _p2}) then {
#endif
d_all_p_a_boxes pushBack [_box, [1,1,0,0], localize "STR_DOM_MISSIONSTRING_1585"]; // yellow, Text "Virtual Arsenal"
__TRACE_1("","d_all_p_a_boxes")
#ifdef __TT__
};
#endif