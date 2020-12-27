// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getadminarray.sqf"
#include "..\x_setup.sqf"

[missionNamespace, ["d_u_r_inf", [_this # 0, d_player_hash getOrDefault [_this # 1, []]]]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
