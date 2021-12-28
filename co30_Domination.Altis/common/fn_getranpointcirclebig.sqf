// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

// get a random point inside a circle for bigger objects
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircleBig;

params ["_center", "_radius", ["_mindist", 4], ["_maxgradient", 0.5], ["_water", 0], ["_waterin25", false], ["_checkroad", false]];

if (_center isEqualTo []) exitWith {
	diag_log ["getranpointcirclebig, _center is empty", _this];
	[]
};

private _ret_val = [_center, -1, _radius, _mindist, _water, _maxgradient, [0, 1] select _waterin25, [], [], _checkroad] call d_fnc_findSafePos;
if (_ret_val isEqualTo []) then {_ret_val = _center};
//__TRACE_1("","_ret_val")
_ret_val
