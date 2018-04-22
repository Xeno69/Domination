// by Xeno
#define THIS_FILE "x_reservedslot2.sqf"
#include "..\x_setup.sqf"

if (isDedicated) exitWith {};

sleep 1;

for "_i" from 1 to 3 do {
	hint (localize "STR_DOM_MISSIONSTRING_1426");
	sleep 5;
};

hint (localize "STR_DOM_MISSIONSTRING_338");
sleep 1;
[player, d_name_pl, -1] remoteExecCall ["d_fnc_KickPlayerBS", 2];