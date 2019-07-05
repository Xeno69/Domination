// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ampoi.sqf"
#include "..\x_setup.sqf"

private _ow = (_this select 0) getVariable "d_owner";
if (!isNil "_ow") then {
	_ow addScore (_this select 2);
	if (isMultiplayer) then {
		[[playerSide, "HQ"], format [localize "STR_DOM_MISSIONSTRING_287", [_this select 2, _this select 1]]] remoteExecCall ["sideChat", _ow];
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_287", [_this select 2, _this select 1]];
	};
};
