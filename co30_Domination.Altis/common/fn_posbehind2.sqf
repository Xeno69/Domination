// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_posbehind2.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_p1", "_p2"];
private _dir = _p1 getDir _p2;
private _dist = (random 2000) max 1400;
[_p2 getPos [_dist, _dir], _dir, _dist]
