//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

if ((_this # 3) && {(_this # 0) in d_ak_teamswitch}) exitWith {
	if (isNil {uiNamespace getVariable "BIS_dynamicGroups_keyDownTime"}) then {
		uiNamespace setVariable ["BIS_dynamicGroups_keyDownTime", time];
		uiNamespace setVariable ["BIS_dynamicGroups_ignoreInterfaceOpening", nil];
	};

	["UpdateKeyDown"] call d_fnc_dynamicgroups;
	
	true
};
false
