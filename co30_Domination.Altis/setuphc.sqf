// by Xeno
#define THIS_FILE "setuphc.sqf"
#include "x_setup.sqf"

diag_log [diag_frameno, diag_tickTime, time, "Executing Dom setuphc"];

waitUntil {!isNil "d_init_processed" && {time > 0}};

0 spawn {
	scriptName "spawn setuphc";
	waitUntil {time > 0};
	sleep 1;
	enableEnvironment [false, false];
};

0 spawn d_fnc_ai_loop;

d_is_hc = true;

if (d_with_ace) then {
	addMissionEventHandler ["EntityKilled", {_this call d_fnc_entitykilled}];
};

diag_log [diag_frameno, diag_tickTime, time, "Dom setuphc done"];
