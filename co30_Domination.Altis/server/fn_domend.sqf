// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_domend.sqf"
#include "..\x_setup.sqf"

sleep 5;
0 remoteExecCall ["d_fnc_the_end", [0, -2] select isDedicated];
sleep 38;
1 remoteExecCall ["d_fnc_the_end", [0, -2] select isDedicated];
endMission "END1";
forceEnd;