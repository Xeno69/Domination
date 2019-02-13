// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_domcommandingmenuexec.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")

if (!alive player || {player getVariable ["d_isinaction", false] || {player getVariable ["d_isinaction", false]}}) exitWith {	
	showCommandingMenu "";
	d_DomCommandingMenuBlocked = false;
	d_commandingMenuIniting = false;
};
d_commandingMenuIniting = true;
showCommandingMenu "";
switch (_this) do {
	case 0: {d_commandingMenuCode = {call d_fnc_showstatus}};
	case 1: {d_commandingMenuCode = {call d_fnc_artillery}};
	case 2: {d_commandingMenuCode = {0 spawn d_fnc_calldrop}};
	case 5: {d_commandingMenuCode = {0 spawn d_fnc_spawn_mash}};
	case 6: {d_commandingMenuCode = {0 spawn d_fnc_spawn_farp}};
	case 7: {d_commandingMenuCode = {call d_fnc_adminspectate}};
	case 15: {d_commandingMenuCode = {"Chemlight_green" call d_fnc_attachchemlight}};
	case 16: {d_commandingMenuCode = {"Chemlight_red" call d_fnc_attachchemlight}};
	case 17: {d_commandingMenuCode = {"Chemlight_yellow" call d_fnc_attachchemlight}};
	case 18: {d_commandingMenuCode = {"Chemlight_blue" call d_fnc_attachchemlight}};
	case 20: {d_commandingMenuCode = {call d_fnc_detachchemlight}};
	case 30: {d_commandingMenuCode = {call d_fnc_airtaxi;d_commandingMenuIniting = false}};
	case 31: {d_commandingMenuCode = {call d_fnc_changeairtaxidest;d_commandingMenuIniting = false}};
	case 40: {
		d_commandingMenuCode = {
			if (d_earplugs_fitted) then {
				d_earplugs_fitted = false;
				2 fadeSound 1;
				"d_earplugs" cutText ["<t color='#FF3333' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1870" + "</t>", "PLAIN DOWN", -1, true, true];
			} else {
				d_earplugs_fitted = true;
				2 fadeSound 0.2;
				"d_earplugs" cutText ["<t color='#339933' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1869" + "</t>", "PLAIN DOWN", -1, true, true];
			};
			d_commandingMenuIniting = false;
		};
	};
	case 50: {
		d_commandingMenuCode = {
#ifndef __TT__
			d_arty_stopp = true;
			publicVariable "d_arty_stopp";
#else
			if (d_player_side == opfor) then {
				d_arty_stopp_e = true;
				publicVariable "d_arty_stopp_e";
			} else {
				d_arty_stopp_w = true;
				publicVariable "d_arty_stopp_w";
			};
#endif
			d_commandingMenuIniting = false;
		};
	};
	case 99: {
		d_commandingMenuCode = {
			0 spawn {
				scriptName "spawn_transferscoredialog";
				createDialog "d_TransferScoreDialog";
			};
			d_commandingMenuIniting = false;
		};
	};
};
d_DomCommandingMenuBlocked = false;