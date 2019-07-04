// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointcirclebig.sqf"
#include "..\..\x_setup.sqf"

// get a random point inside a circle for bigger objects
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircleBig;

params ["_center", "_radius", ["_mindist", 4], ["_checkpos", -1], ["_maxgradient", 0.5], ["_gradientar", 13], ["_water", 0], ["_waterin25", false], ["_ignoreobj", objNull]];
private _ret_val = [];
for "_co" from 0 to 99 do {
	private _isFlat = (_center getPos [_radius * sqrt random 1, random 360]) isFlatEmpty [
		_mindist,	//--- Minimal distance from another object was 9 before
		_checkpos,				//--- If 0, just check position. If >0, select new one // 0
		_maxgradient,				//--- Max gradient
		_gradientar,	//--- Gradient area
		_water,				//--- 0 for restricted water, 2 for required water,
		_waterin25,				//--- True if some water can be in 25m radius
		_ignoreobj			//--- Ignored object
	];
	//if (!(_isFlat isEqualTo []) && {!isOnRoad _isFlat && {count (_isFlat nearRoads 20) > 0}}) exitWith {
	if (!(_isFlat isEqualTo []) && {!isOnRoad _isFlat}) exitWith {
		_ret_val = ASLToATL _isFlat;
	};
	if (_co == 99) exitWith {
		_ret_val = [];
	};
};
__TRACE_1("","_ret_val")
_ret_val
