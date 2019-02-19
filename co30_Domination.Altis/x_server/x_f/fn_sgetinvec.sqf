// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sgetinvec.sqf"
#include "..\..\x_setup.sqf"

private _ma = (_this select 0) getVariable "d_abandoned_ma";
if (!isNil "_ma") then {
	deleteMarker _ma;
	(_this select 0) setVariable ["d_abandoned_ma", nil];
};