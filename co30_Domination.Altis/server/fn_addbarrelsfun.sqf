// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _list = _this;

__TRACE_1("","_list")

if (_list isEqualTo []) then {
	_list = vehicles select {typeOf _x in ["Barrel1", "cwa_Barrel_Red", "Barrel4", "Barrel5", "Barrel6"] && {isNil {_x getVariable "d_has_b_fun"}}};
};

__TRACE_1("2","_list")

{
	_x setVariable ["d_has_b_fun", true];
	_x addeventhandler ["killed", {(_this # 0) spawn d_fnc_bfunexp}];
} forEach _list;
