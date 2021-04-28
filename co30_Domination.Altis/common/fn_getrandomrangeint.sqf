// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

// gets a random integer number in a specific range
// parameters: integer from, integer to (second number must be greater than first)
// example: _random_integer = [30,150] call d_fnc_GetRandomRangeInt;
params ["_num1", "_num2"];
if (_num1 > _num2) then {
	params ["_num2", "_num1"];
};
(_num1 + ((_num2 - _num1) call d_fnc_RandomFloor))
