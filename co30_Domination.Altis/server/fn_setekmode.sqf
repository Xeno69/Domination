// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_setekmode.sqf"
#include "..\x_setup.sqf"

params ["_obj", "_num", ["_val", 1], ["_public", false]];

private _ar = _obj getVariable "d_hkx";
if (isNil "d_hkx") then {
	_ar = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
};

_ar set [_num, _val];
_obj setVariable ["d_hkx", _ar, _public]