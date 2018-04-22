// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_endsidemission.sqf"
#include "..\..\x_setup.sqf"

d_sm_winner = 0;
d_sm_resolved = true;
if (!isNil "d_HC_CLIENT_OBJ_OWNER") then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", d_HC_CLIENT_OBJ_OWNER];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", d_HC_CLIENT_OBJ_OWNER];
};