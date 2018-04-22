// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tvecservice.sqf"
#include "..\..\x_setup.sqf"

if ("LandVehicle" countType _this == 0) exitWith {
	__TRACE("No vec inside trigger")
	false
};
if (!isTouchingGround (param [0])) exitWith {
	__TRACE("Vec is not touching ground")
	false
};
__TRACE("true")
true
