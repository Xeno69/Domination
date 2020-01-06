// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointcircle.sqf"
#include "..\x_setup.sqf"

// get a random point inside a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircle;
__TRACE_1("","_this")
params ["_rcenter", "_rradius", ["_mindist", 2], ["_maxgrad", 0.7], ["_gradar", 4]];

if (_mindist == 0) then {_mindist = 1};

if (_rcenter isEqualTo []) exitWith {
	diag_log ["getranpointcircle, _rcenter is empty", _this];
	[]
};

__TRACE_2("","_rcenter","_rradius")
private _ret_val = [_rcenter, 0, _rradius, _mindist, 0, _maxgrad] call d_fnc_findSafePos;
/*private _ret_val = [];
for "_co" from 0 to 99 do {
	//private _isFlat = ([[[_rcenter, _rradius]]] call BIS_fnc_randomPos) isFlatEmpty [
	private _isFlat = (_rcenter getPos [_rradius * sqrt random 1, random 360]) isFlatEmpty [
		_mindist,	//--- Minimal distance from another object
		-1,			//--- If 0, just check position. If >0, select new one // 0
		_maxgrad,	//--- Max gradient
		_gradar,	//--- Gradient area
		0,			//--- 0 for restricted water, 2 for required water,
		false,		//--- True if some water can be in 25m radius
		objNull		//--- Ignored object
	];
	__TRACE_1("","_isFlat")
	if !(_isFlat isEqualTo []) exitWith {
		_ret_val = ASLToATL _isFlat;
	};
};
*/
if (_ret_val isEqualTo []) then {_ret_val = _rcenter};
__TRACE_1("","_ret_val")
_ret_val