// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_trig", "_handle"];

private _vec = _trig getVariable "d_vec";

private _t = _vec getVariable "d_taketime";

if (_t < _vec getVariable "d_timetotake") then {
	terminate _handle;
	_vec setVariable ["d_taketime", 0, true];
};
