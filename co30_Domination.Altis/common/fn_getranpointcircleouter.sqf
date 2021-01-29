// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointcircleouter.sqf"
#include "..\x_setup.sqf"

// get a random point at the borders of a circle
// parameters:
// center position, radius of the circle
// example: _random_point = [position trigger1, 200] call d_fnc_GetRanPointCircleOuter;
params ["_center", "_radius"];

if (_center isEqualTo []) exitWith {
	diag_log ["getranpointcircleouter, _center is empty", _this];
	[]
};

private _ret_val = [_center, _radius - 5, _radius, 2, 0, 0.7] call d_fnc_findSafePos;
/*private _ret_val = [];
for "_co" from 0 to 99 do {
	private _isFlat = (_center getPos [_radius, random 360]) isFlatEmpty [
		2,	//--- Minimal distance from another object
		-1,				//--- If 0, just check position. If >0, select new one // 0
		0.7,				//--- Max gradient
		4,	//--- Gradient area
		0,				//--- 0 for restricted water, 2 for required water,
		false,				//--- True if some water can be in 25m radius
		objNull			//--- Ignored object
	];
	if (_isFlat isNotEqualTo []) exitWith {
		_ret_val = ASLToATL _isFlat;
	};
};*/
_ret_val