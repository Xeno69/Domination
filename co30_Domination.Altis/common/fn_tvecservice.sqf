// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tvecservice.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_list", "_trig"];

if ("LandVehicle" countType _list == 0) exitWith {
	__TRACE("No vec inside trigger")
	false
};
if (!isTouchingGround (_list select 0)) exitWith {
	__TRACE("Vec is not touching ground")
	false
};

_trig setVariable ["d_list", _list];

__TRACE("true")
true
