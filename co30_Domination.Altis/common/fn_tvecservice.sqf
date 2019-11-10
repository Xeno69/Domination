// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tvecservice.sqf"
#include "..\x_setup.sqf"

params ["_list", "_trig"];

if (_list isEqualTo []) then {
	_list = _trig nearEntities ["UGV_01_base_F", 8];
};

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
