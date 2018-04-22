// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mpcheck.sqf"
#include "..\..\x_setup.sqf"

if (isMultiplayer) then {
	if ((call d_fnc_PlayersNumber) == 0) then {
		if (!d_all_simulation_stoped) then {
			d_all_simulation_stoped = true;
			{_x enableSimulation false;false} count allUnits;
			{_x enableSimulation false;false} count vehicles;
		};
		waitUntil {sleep (1.012 + random 1);(call d_fnc_PlayersNumber) > 0};
		if (d_all_simulation_stoped) then {
			d_all_simulation_stoped = false;
			{_x enableSimulation true;false} count vehicles;
			{_x enableSimulation true;false} count allUnits;
		};
	};
};

