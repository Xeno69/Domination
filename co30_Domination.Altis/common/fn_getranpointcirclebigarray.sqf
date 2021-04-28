// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

// get an array of random points inside a circle for bigger objects
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircleBigArray;

params ["_center", "_radius", ["_mindist", 4], ["_maxgradient", 0.5], ["_water", 0], ["_waterin25", false], ["_checkroad", false], ["_blacklist", false]];

if (_center isEqualTo []) exitWith {
	diag_log ["getranpointcirclebigarray, _center is empty", _this];
	[]
};
private _blackl = [];
private _ret_val = [];
private _timeend = time + 10;
while {count _ret_val < 60} do {
	private _npos = [_center, -1, _radius, _mindist, _water, _maxgradient, [0, 1] select _waterin25, _blackl, [], _checkroad] call d_fnc_findSafePos;
	if (_npos isNotEqualTo [] && {!isOnRoad _npos}) then {
		_ret_val pushBack _npos;
		if (_blacklist) then {
			_blackl pushBack [_npos, _mindist, _mindist, 0, false];
		};
#ifdef __DEBUG__
		if (isNil "d_mmmcoui") then {
			d_mmmcoui = 0;
		};
		d_mmmcoui = d_mmmcoui + 1;
		[format ["d_grpcba_%1", d_mmmcoui], _npos, "ICON", "ColorBlack", [0.5, 0.5], str (d_mmmcoui), 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
	};
	if (time > _timeend) exitWith {};
};
__TRACE_1("","_blackl")
__TRACE_2("","count _ret_val","_ret_val")
_ret_val
