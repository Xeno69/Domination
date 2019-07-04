// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_doquake.sqf"
#include "..\x_setup.sqf"

private _next = time + 25 + random 25;
while {!d_sm_resolved} do {
	sleep 1;
	if (d_sm_resolved) exitWith {};
	__TRACE_1("","_next")
	if (time > _next) then {
		(ceil random 4) remoteExecCall ["d_fnc_cdoquake", [0, -2] select isDedicated];
		 _next = time + 25 + random 25;
	};
};