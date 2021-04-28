// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_sm_winner = 0;
d_sm_resolved = true;
["d_sm_task"] remoteExecCall ["BIS_fnc_deleteTask", [0, -2] select isDedicated];
