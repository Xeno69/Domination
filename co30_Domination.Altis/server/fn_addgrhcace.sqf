// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

{
	[_x, 0] call d_fnc_setekmode;
} forEach (units _this);

_this deleteGroupWhenEmpty true;
