// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sendfps.sqf"
#include "..\x_setup.sqf"

sleep 10;
while {true} do {
	sleep 3;
	diag_fps remoteExecCall ["d_fnc_dfps", [0, -2] select isDedicated];
};