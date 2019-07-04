// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tallservice.sqf"
#include "..\..\x_setup.sqf"

if ("LandVehicle" countType _this == 0 && {"Plane" countType _this == 0 && {"Helicopter" countType _this == 0}}) exitWith {
	__TRACE("No vehicle inside trigger")
	false
};
if (!isTouchingGround (_this select 0)) exitWith {
	__TRACE("Vec is not touching ground")
	false
};

if !((_this select 0) isKindOf "Plane") then {
	true
} else {
	(speed (_this select 0) < 10)
};
