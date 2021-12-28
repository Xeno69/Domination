// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_insti", "_killed"];

[name _insti, name _killed, _insti] call d_fnc_TKKickCheck;
[name _killed, name _insti] remoteExecCall ["d_fnc_unit_tk", [0, -2] select isDedicated];
