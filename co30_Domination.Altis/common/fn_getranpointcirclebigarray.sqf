// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointcirclebigarray.sqf"
#include "..\x_setup.sqf"

// get an array of random points inside a circle for bigger objects
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircleBigArray;

params ["_center", "_radius", ["_mindist", 4], ["_maxgradient", 0.5], ["_water", 0], ["_waterin25", false], ["_checkroad", false]];

if (_center isEqualTo []) exitWith {
	diag_log ["getranpointcirclebigarray, _center is empty", _this];
	[]
};

private _ret_val = [];
#ifdef __DEBUG__
private _co = 0;
#endif
private _timeend = time + 10;
while {count _ret_val < 50} do {
	private _npos = [_center, -1, _radius, _mindist, _water, _maxgradient, [0, 1] select _waterin25, [], [], _checkroad] call d_fnc_findSafePos;
	if (!(_npos isEqualTo []) && {!isOnRoad _npos}) then {
		_ret_val pushBack _npos;
#ifdef __DEBUG__
		_co = _co + 1;
		if (isNil "d_mmmcoui") then {
			d_mmmcoui = 0;
		};
		[format ["d_grpcba_%1", _co + d_mmmcoui], _npos, "ICON", "ColorBlack", [0.5, 0.5], str (_co + d_mmmcoui), 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
	};
	if (time > _timeend) exitWith {};
};
#ifdef __DEBUG
d_mmmcoui = d_mmmcoui + 50;
#endif
__TRACE_2("","count _ret_val","_ret_val")
_ret_val
