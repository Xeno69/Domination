// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_correctwname.sqf"
#include "..\x_setup.sqf"

private _ar = _this splitString "_";
__TRACE_1("_ar 1","_ar")

private "_i";
{
	_i = _ar find _x;
	if (_i > -1) then {
		_ar deleteAt _i;
	};
} forEach ["pointer", "Hamr", "bipod", "arco", "snds", "holo", "Holo", "fl", "ACO", "SOS", "RCO", "DMS", "ARCO", "MRCO", "pointg", "Nstalker", "Loaded"];

__TRACE_1("_ar 2","_ar")

(_ar joinString "_")
