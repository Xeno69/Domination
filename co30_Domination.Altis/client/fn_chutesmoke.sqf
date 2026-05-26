// by Xeno
#include "..\x_setup.sqf"

private _smokeshell = createVehicle ["SmokeShellGreen", [0,0, getPos player # 2], [], 0, "FLY"];
_smokeshell attachTo [player, [0, 0, 0.1], "rightfoot"];
_smokeshell spawn {
	params ["_smokeshell"];
	while {true} do {
		if (!alive _smokeshell) exitWith {
			if (getPos player # 2 > 5) then {
				call d_fnc_chutesmoke;
			};
		};
		if (getPos player # 2 < 5) exitWith {
			deleteVehicle _smokeshell;
		};
		sleep 0.1;
	};
};