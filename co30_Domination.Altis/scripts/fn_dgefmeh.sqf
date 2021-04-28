//#define __DEBUG__
#include "..\x_setup.sqf"
#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"

__TRACE("Running")

if (!isNull (uiNamespace getVariable ["d_dynamicGroups_display", displayNull])) then {
	["Update", [false]] call d_fnc_rscdisplaydynamicgroups;
};
