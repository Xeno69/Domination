// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_triggerrun.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_trig"];

__TRACE_1("","triggerInterval _trig")

private "_e";

{
	__TRACE_1("1","_x")
	_e = _trig getVariable _x;
	if (!isNil "_e") then {
		call _e;
		__TRACE_1("","_e")
	};
} forEach (allVariables _trig);
