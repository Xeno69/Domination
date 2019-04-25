// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_seltarrec.sqf"
#include "..\..\x_setup.sqf"

params ["_obj", "_val"];

_obj setVariable ["d_selectionsmt", (_obj getVariable ["d_selectionsmt", 0]) + _val];

private _ma = _obj getVariable "d_sel_mar";
if (!isNil "_ma") then {
	_ma setMarkerText (str (_obj getVariable ["d_selectionsmt", 0]));
};