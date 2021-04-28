// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")

#ifndef __TT__
params ["_box", "_unit"];
__TRACE_2("","_box","_unit")
#else
params ["_box", "_unit", "_bside"];
__TRACE_3("","_box","_unit","_bside")
#endif
player reveal _box;
_box enableRopeAttach false;
#ifndef __TT__
[_box] call d_fnc_weaponcargo;
#else
[_box, _bside] call d_fnc_weaponcargo;
#endif
