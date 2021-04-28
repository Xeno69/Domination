// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_trig"];

__TRACE_1("","triggerInterval _trig")

{
	__TRACE_2("","_x","_y")
	call _y;
} forEach (_trig getVariable "d_trig_hm");
