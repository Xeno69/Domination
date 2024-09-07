// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

while {true} do {
	sleep 10;
	if (dynamicSimulationSystemEnabled && {count (allPlayers - entities "HeadlessClient_F") > 19}) then {
		enableDynamicSimulationSystem false;
	} else {
		sleep 0.1;
		if (!dynamicSimulationSystemEnabled && {count (allPlayers - entities "HeadlessClient_F") < 20}) then {
			enableDynamicSimulationSystem true;
		};
	};
};
