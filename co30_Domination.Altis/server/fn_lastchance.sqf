// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_lastchance.sqf"
#include "..\x_setup.sqf"

sleep 3;

private _etime = time + 60;

__TRACE_1("","_etime")

while {true} do {
	(round (_etime - time)) remoteExecCall ["d_fnc_lastchanceclient", [0, -2] select isDedicated];
	if (d_recapturedcamp) exitWith {
		d_recapturedcamp = false;
		d_lastchancerunning = false;
	};
	if (time >= _etime) exitWith {
		d_lastchanceover = true;
	};
	sleep 1;
};

if (!d_lastchanceover) then {
	d_lastchancerunning = false;
};

__TRACE_2("over","d_lastchancerunning","d_lastchanceover")

-1 remoteExecCall ["d_fnc_lastchanceclient", [0, -2] select isDedicated];