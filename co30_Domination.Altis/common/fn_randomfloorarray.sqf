// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

// get a random number, floored, from count array
// parameters: array
// example: _randomarrayint = _myarray call d_fnc_RandomFloorArray;
floor (random (count _this))