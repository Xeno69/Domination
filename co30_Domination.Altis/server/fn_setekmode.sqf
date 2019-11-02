// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_setekmode.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_obj", "_num", ["_val", 1], ["_public", false]];

private _ar = _obj getVariable "d_hkx";
if (isNil "_ar") then {
	__TRACE("_ar is nil")
	_ar = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
};
__TRACE_1("1","_ar")
_ar set [_num, _val];
__TRACE_1("2","_ar")
_obj setVariable ["d_hkx", _ar, _public];
