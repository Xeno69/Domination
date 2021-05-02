//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

uiNamespace setVariable ["BIS_dynamicGroups_keyDownTime", nil];

if (!(_this # 3) && {(_this # 0) in d_ak_teamswitch && {isNil {uiNamespace getVariable "BIS_dynamicGroups_ignoreInterfaceOpening"}}}) exitWith {
	if (isNull (findDisplay 60490) && {missionNamespace getVariable ["BIS_dynamicGroups_allowInterface", true]}) then {
		([] call BIS_fnc_displayMission) createDisplay "d_RscDisplayDynamicGroups";
	} else {
		if (isNil {uiNamespace getVariable "BIS_dynamicGroups_hasFocus"}) then {
			(["GetDisplay"] call d_fnc_rscdisplaydynamicgroups) closeDisplay 2;
		};
	};
	true
};
false
