// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_creategroup.sqf"
#include "..\..\x_setup.sqf"

params ["_side"];
__TRACE_1("","_side")
private _side_str = if (_side isEqualType sideUnknown) then {
	_side
} else {
	if (_side isEqualType "") then {
		call {
			if (_side == "E" || {_side == "EAST"}) exitWith {opfor};
			if (_side == "W" || {_side == "WEST"}) exitWith {blufor};
			if (_side == "G" || {_side == "GUER"}) exitWith {independent};
			civilian
		};
	} else {
		if (_side isEqualType objNull) then {
			side (group _side)
		} else {
			_side
		};
	};
};
__TRACE_1("","_side_str")
private _grp = createGroup [_side_str, true];
#ifdef __GROUPDEBUG__
if (isNil "d_all_marker_groups") then {
	d_all_marker_groups = [];
	0 spawn d_fnc_map_group_count_marker;
};
[_grp] spawn d_fnc_groupmarker;
#endif
__TRACE_1("creategroup","_grp")
_grp