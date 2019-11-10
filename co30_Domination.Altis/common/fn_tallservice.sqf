// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tallservice.sqf"
#include "..\x_setup.sqf"

params ["_list", "_trig"];

if (_list isEqualTo []) then {
	_list = _trig nearEntities ["UAV_01_base_F", 8];
	if (_list isEqualTo []) then {
		_list = _trig nearEntities ["UGV_01_base_F", 8];
		if (_list isEqualTo []) then {
			_list = _trig nearEntities ["UAV", 16];
		};
	};
};

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
