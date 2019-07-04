// by Xeno
#define THIS_FILE "x_setuphc.sqf"
#include "x_setup.sqf"

__TRACE("Running HC setup")
0 spawn {
	scriptName "spawn setuphc";
	waitUntil {time > 0};
	enableEnvironment [false, false];
};

0 spawn d_fnc_ai_loop;

d_is_hc = true;

addMissionEventHandler ["EntityKilled", {_this call d_fnc_entitykilled}];

__TRACE("HC setup done")