// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getplayername.sqf"
#include "..\..\x_setup.sqf"

params ["_u"];

private _np = _u getVariable "d_plname";
if (isNil "_np") then {
	_np = (name _u) splitString """'" joinString "";
	_u setVariable ["d_plname", _np];
};
_np
