// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_list", "_trig"];

if ("LandVehicle" countType _list == 0 && {"Plane" countType _list == 0 && {"Helicopter" countType _list == 0 && {"Ship" countType _list == 0}}}) exitWith {
	__TRACE("No vehicle inside trigger")
	false
};
if (!((_list # 0) isKindOf "Ship") && {!isTouchingGround (_list # 0)}) exitWith {
	__TRACE("Vec is not touching ground")
	false
};

if !((_list # 0) isKindOf "Plane") then {
	_trig setVariable ["d_list", _list];
	true
} else {
	if (speed (_list # 0) >= 10) exitWith {false};
	_trig setVariable ["d_list", _list];
	true
};
