// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tchopservice.sqf"
#include "..\..\x_setup.sqf"

if ("Helicopter" countType _this == 0) exitWith {
	__TRACE("No heli inside trigger")
	false
};
if (!isTouchingGround (_this select 0)) exitWith {
	__TRACE("Heli is not touching ground")
	false
};
__TRACE("true")
true
