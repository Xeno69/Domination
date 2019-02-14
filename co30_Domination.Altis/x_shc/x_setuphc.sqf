// by Xeno
#define THIS_FILE "x_setuphc.sqf"
#include "..\x_setup.sqf"

__TRACE("Running HC setup")

player removeAllEventHandlers "handleDamage";
player removeAllEventHandlers "respawn";
player addEventHandler ["handleDamage", {0}];
player allowDamage false;
//player setPos [-10000,10000,0.3];
//[player, false] remoteExecCall ["enableSimulationGlobal", 2];
//player remoteExecCall ["hideObjectGlobal", 2];
if (!hasInterface && {!isDedicated}) then {
	0 spawn {
		scriptName "spawn setuphc";
		waitUntil {time > 0};
		enableEnvironment [false, false];
	};
};
player addEventHandler ["respawn", {
	player removeAllEventHandlers "handleDamage";
	player addEventHandler ["handleDamage", {0}];
	player allowDamage false;
	//player setPos [-10000,10000,0.3];
	//player remoteExecCall ["hideObjectGlobal", 2];
	//[player, false] remoteExecCall ["enableSimulationGlobal", 2];
}];

[missionNamespace, ["d_HC_CLIENT_READY", true]] remoteExecCall ["setVariable", 2];

__TRACE("HC setup done")