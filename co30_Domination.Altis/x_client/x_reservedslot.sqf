// by Xeno
#define THIS_FILE "x_reservedslot.sqf"
#include "..\x_setup.sqf"

if (isDedicated) exitWith {};

sleep 5;

if (d_pisadminp) exitWith {};

for "_i" from 1 to 3 do {
	hint (localize "STR_DOM_MISSIONSTRING_335");
	sleep 5;
};

if (d_pisadminp) exitWith {
	hint format [localize "STR_DOM_MISSIONSTRING_336", d_name_pl];
};

hint (localize "STR_DOM_MISSIONSTRING_337");

sleep 5;

if (d_pisadminp) exitWith {
	hint format [localize "STR_DOM_MISSIONSTRING_336", d_name_pl];
};

hint (localize "STR_DOM_MISSIONSTRING_338");
sleep 1;
[player, d_name_pl, 2] remoteExecCall ["d_fnc_KickPlayerBS", 2];