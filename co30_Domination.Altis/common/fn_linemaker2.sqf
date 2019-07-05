// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_linemaker2.sqf"
#include "..\x_setup.sqf"

// _p1 and _p2 = positions, _mname = marker name
params ["_p1", "_p2", "_mname", ["_ls", 0.9]];
private _radius = (_p1 distance2D _p2) / 2;
private _dir = _p1 getDir _p2;
private _mpos = _p1 getPos [_radius, _dir];
__TRACE_3("","_mname","_mpos", "_radius")
__TRACE_1("","_dir")
if (markerPos _mname isEqualTo [0,0,0]) then {
	[_mname, _mpos, "RECTANGLE", "ColorBlack", [_radius, _ls], "", _dir + 90] call d_fnc_CreateMarkerLocal;
} else {
	_mname setMarkerPosLocal _mpos;
	_mname setMarkerSizeLocal [_radius, _ls];
	_mname setMarkerDirLocal _dir + 90;
};