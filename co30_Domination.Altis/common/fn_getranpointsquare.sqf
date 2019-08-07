// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getranpointsquare.sqf"
#include "..\x_setup.sqf"

// get a random point inside a square
// parameters:
// center position, a and b (like in triggers), angle
// example: _random_point  = [position trigger2, 200, 300, 30] call d_fnc_GetRanPointSquare;
params ["_pos", "_a", "_b", "_angle"];

if (_pos isEqualTo []) exitWith {
	diag_log ["getranpointsquare, pos is an empty array", _this];
	[]
};

_pos params ["_centerx", "_centery"];
private _ret_val = [];
for "_co" from 0 to 150 do {
	private _px1 = (_centerx - _a) + random (2 * _a);
	private _py1 = (_centery - _b) + random (2 * _b);
	private _radius = _pos distance2D [_px1, _py1];
	private _atan = (_centerx - _px1) atan2 (_centery - _py1);
	private _isFlat = [_centerx - (_radius * sin (_atan + _angle)), _centery - (_radius * cos (_atan + _angle)), 0] isFlatEmpty [
		2,	//--- Minimal distance from another object
		-1,	//--- If 0, just check position. If >0, select new one // 0
		0.7,//--- Max gradient
		4,	//--- Gradient area
		0,	//--- 0 for restricted water, 2 for required water,
		false,//--- True if some water can be in 25m radius
		objNull//--- Ignored object
	];
	if !(_isFlat isEqualTo []) exitWith {
		_ret_val = ASLToATL _isFlat;
	};
};
if (_ret_val isEqualTo []) then {_ret_val = _pos};
_ret_val