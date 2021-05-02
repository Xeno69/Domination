//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("Running")

if (!isNull (uiNamespace getVariable ["d_dynamicGroups_display", displayNull])) then {
	["Update", [false]] call d_fnc_rscdisplaydynamicgroups;
};
