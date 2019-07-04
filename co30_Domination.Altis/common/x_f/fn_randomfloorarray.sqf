// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_randomfloorarray.sqf"
#include "..\..\x_setup.sqf"

// get a random number, floored, from count array
// parameters: array
// example: _randomarrayint = _myarray call d_fnc_RandomFloorArray;
floor (random (count _this))