// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_killedsmtarget500.sqf"
#include "..\x_setup.sqf"

d_sm_winner = -500;
d_sm_resolved = true;
(param [0]) removeAllEventHandlers "killed";
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};