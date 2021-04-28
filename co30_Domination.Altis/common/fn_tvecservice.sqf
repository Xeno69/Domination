// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_list", "_trig"];

if ("LandVehicle" countType _list == 0 && {"Ship" countType _list == 0}) exitWith {
	__TRACE("No vec inside trigger")
	false
};
if (!((_list # 0) isKindOf "Ship") && {!isTouchingGround (_list # 0)}) exitWith {
	__TRACE("Vec is not touching ground")
	false
};

_trig setVariable ["d_list", _list];

__TRACE("true")
true
