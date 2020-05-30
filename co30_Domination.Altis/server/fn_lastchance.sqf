// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_lastchance.sqf"
#include "..\x_setup.sqf"

private _etime = time + 60;

while {true} do {
	(round (time - _etime)) remoteExecCall ["d_fnc_lastchanceclient", [0, -2] select isDedicated];
	if (d_recapturedcamp) exitWith {
		d_recapturedcamp = false;
		d_lastchancerunning = false;
	};
	if (time >= _etime) exitWith {
		d_lastchanceover = true;
	};
	sleep 1;
};

-1 remoteExecCall ["d_fnc_lastchanceclient", [0, -2] select isDedicated];