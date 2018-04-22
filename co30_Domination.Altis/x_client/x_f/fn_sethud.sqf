// by Xeno
#define THIS_FILE "fn_sethud.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_vec"];

switch (param [3]) do {
	case 0: {
		d_chophud_on = false;
		_vec removeAction (player getVariable "d_hud_id");
		player setVariable ["d_hud_id", _vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_177"], {_this call d_fnc_sethud}, 1, -1, false]];
	};
	case 1: {
		d_chophud_on = true;
		_vec removeAction (player getVariable "d_hud_id");
		player setVariable ["d_hud_id", _vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_176"], {_this call d_fnc_sethud}, 0, -1, false]];
	};
};