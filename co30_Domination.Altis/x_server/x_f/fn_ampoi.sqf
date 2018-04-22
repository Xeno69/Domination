// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ampoi.sqf"
#include "..\..\x_setup.sqf"

private _ow = (param [0]) getVariable "d_owner";
if (!isNil "_ow") then {
	_ow addScore (param [2]);
	if (isMultiplayer) then {
		[[playerSide, "HQ"], format [localize "STR_DOM_MISSIONSTRING_287", [param [2], param [1]]]] remoteExecCall ["sideChat", _ow];
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_287", [param [2], param [1]]];
	};
};
