// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tchopservice.sqf"
#include "..\x_setup.sqf"

params ["_list", "_trig"];

if (_list isEqualTo []) then {
	_list = _trig nearEntities ["UAV_01_base_F", 8];
};

if ("Helicopter" countType _list == 0) exitWith {
	__TRACE("No heli inside trigger")
	false
};
if (!isTouchingGround (_list select 0)) exitWith {
	__TRACE("Heli is not touching ground")
	false
};

_trig setVariable ["d_list", _list];

__TRACE("true")
true
