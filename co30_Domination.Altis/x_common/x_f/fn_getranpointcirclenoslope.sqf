// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointcirclenoslope.sqf"
#include "..\..\x_setup.sqf"

// get a random point inside a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircleNoSlope;

params ["_center", "_radius"];
private _ret_val = [];
for "_co" from 0 to 99 do {
	_isFlat = (_center getPos [_radius * sqrt random 1, random 360]) isFlatEmpty [
		1,	//--- Minimal distance from another object
		-1,				//--- If 0, just check position. If >0, select new one // 0
		1,				//--- Max gradient
		2,	//--- Gradient area
		0,				//--- 0 for restricted water, 2 for required water,
		false,				//--- True if some water can be in 25m radius
		objNull			//--- Ignored object
	];
	if !(_isFlat isEqualTo []) exitWith {
		_ret_val = ASLToATL _isFlat;
	};
};
_ret_val