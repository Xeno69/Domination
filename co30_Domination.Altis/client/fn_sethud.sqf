// by Xeno
#define THIS_FILE "fn_sethud.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_vec"];

if (d_chophud_on) then {
	_vec setUserActionText [player getVariable "d_hud_id", format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_177"]];
	d_chophud_on = false;
} else {
	_vec setUserActionText [player getVariable "d_hud_id", format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_176"]];
	d_chophud_on = true;
};
