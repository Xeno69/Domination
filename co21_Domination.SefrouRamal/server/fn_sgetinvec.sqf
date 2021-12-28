// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _ma = (_this # 0) getVariable "d_abandoned_ma";
if (!isNil "_ma") then {
	deleteMarker _ma;
	(_this # 0) setVariable ["d_abandoned_ma", nil];
};
