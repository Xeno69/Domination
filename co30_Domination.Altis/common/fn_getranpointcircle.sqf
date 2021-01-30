// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointcircle.sqf"
#include "..\x_setup.sqf"

// get a random point inside a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircle;
__TRACE_1("","_this")
params ["_rcenter", "_rradius", ["_mindist", 1], ["_maxgrad", 0.7], ["_water", 0], ["_waterin25", false], ["_checkroad", false], ["_blacklist", []]];

if (_mindist == 0) then {
	_mindist = 1
} else {
	if (_mindist == -1) then {
		_mindist = 0;
	};
};

if (_rcenter isEqualTo []) exitWith {
	diag_log ["getranpointcircle, _rcenter is empty", _this];
	[]
};

__TRACE_2("","_rcenter","_rradius")
private _ret_val = [_rcenter, 0, _rradius, _mindist, _water, _maxgrad, [0, 1] select _waterin25, _blacklist, [], _checkroad] call d_fnc_findSafePos;

if (_ret_val isEqualTo []) then {_ret_val = _rcenter};
__TRACE_1("","_ret_val")
_ret_val
