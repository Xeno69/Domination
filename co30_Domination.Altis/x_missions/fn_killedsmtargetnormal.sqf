// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_killedsmtargetnormal.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_dvec", "", "_killer"];
if !(_dvec isKindOf "CAManBase") then {
	addToRemainsCollector [_dvec];
};
#ifndef __TT__
if (!isNull _killer && {_killer != _dvec}) then {
	d_sm_winner = [-1, 2] select (side (group _killer) getFriend d_side_player >= 0.6);
} else {
	d_sm_winner = -1;
};
#else
if (side (group _killer) == opfor) then {
	d_sm_points_opfor = d_sm_points_opfor + 1000;
} else {
	if (side (group _killer) == blufor) then {
		d_sm_points_blufor = d_sm_points_blufor + 1000;
	};
};
d_sm_winner = if (d_sm_points_blufor > d_sm_points_opfor) then {
	2
} else {
	if (d_sm_points_opfor > d_sm_points_blufor) then {
		1
	} else {
		-1
	};
};
_dvec removeAllEventHandlers "hit";
__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")
#endif

_dvec removeAllEventHandlers "killed";
d_sm_resolved = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};
