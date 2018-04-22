// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_create_boxnet.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

__TRACE_1("","_this")

#ifndef __TT__
params ["_pos", "_unit"];
#else
params ["_pos", "_unit", "_bside"];
#endif
__TRACE_2("","_pos","_unit")
private _box = d_the_box createVehicleLocal [0,0,0];
_box setPos _pos;
__TRACE_2("","_box","_pos")
player reveal _box;
_box allowDamage false;
private _boxcargo = _unit getVariable "d_boxcargo";
if (isNil "_boxcargo") then {
#ifndef __TT__
	[_box] call d_fnc_weaponcargo;
#else
	[_box, _bside] call d_fnc_weaponcargo;
#endif
} else {
	__TRACE_1("","_boxcargo")
#ifndef __TT__
	[_box, _boxcargo] call d_fnc_fillDropedBox;
#else
	[_box, _boxcargo, _bside] call d_fnc_fillDropedBox;
#endif
	_unit setVariable ["d_boxcargo", nil];
};