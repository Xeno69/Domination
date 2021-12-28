// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _lg = player getVariable "d_layoutgear";
if (!isNil "_lg") then {
	player setUnitLoadout [_lg, true];
};