// by Xeno
#define THIS_FILE "fn_ccreateboxfarp.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_flag", "_box"];

player reveal _box;
[_box] call d_fnc_weaponcargo;
_box enableRopeAttach false;
_box allowDamage false;
[format ["d_pab_%1", _box], _box, "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_523", 0, d_dropped_box_marker] call d_fnc_CreateMarkerLocal;

if (isNull _flag) exitWith {};

d_additional_respawn_points_orig pushBack [format ["d_add_farp_%1", _flag], str _flag, _flag getVariable "d_name", blufor, d_vec_at_farp == 0, getPosASL _flag];

call d_fnc_buildaddrespoints;
