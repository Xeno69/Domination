// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tallservice.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_list", "_trig"];

if ("LandVehicle" countType _list == 0 && {"Plane" countType _list == 0 && {"Helicopter" countType _list == 0}}) exitWith {
	__TRACE("No vehicle inside trigger")
	false
};
if (!isTouchingGround (_list select 0)) exitWith {
	__TRACE("Vec is not touching ground")
	false
};

if !((_list select 0) isKindOf "Plane") then {
	_trig setVariable ["d_list", _list];
	true
} else {
	if (speed (_list select 0) >= 10) exitWith {false};
	_trig setVariable ["d_list", _list];
	true
};
