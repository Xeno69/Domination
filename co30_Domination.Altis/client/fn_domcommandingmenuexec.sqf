// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")

if (!alive player || {player getVariable ["d_isinaction", false] || {player getVariable ["d_isinaction", false]}}) exitWith {	
	showCommandingMenu "";
	d_DomCommandingMenuBlocked = false;
	d_commandingMenuIniting = false;
};
d_commandingMenuIniting = true;
showCommandingMenu "";
call {
	if (_this == 0) exitWith {d_commandingMenuCode = {call d_fnc_showstatus}};
	if (_this == 1) exitWith {d_commandingMenuCode = {call d_fnc_artillery}};
	if (_this == 2) exitWith {d_commandingMenuCode = {0 spawn d_fnc_calldrop}};
	if (_this == 5) exitWith {d_commandingMenuCode = {0 spawn d_fnc_spawn_mash}};
	if (_this == 6) exitWith {d_commandingMenuCode = {0 spawn d_fnc_spawn_farp}};
	if (_this == 7) exitWith {d_commandingMenuCode = {call d_fnc_adminspectate}};
	if (_this == 15) exitWith {d_commandingMenuCode = {"Chemlight_green" call d_fnc_attachchemlight}};
	if (_this == 16) exitWith {d_commandingMenuCode = {"Chemlight_red" call d_fnc_attachchemlight}};
	if (_this == 17) exitWith {d_commandingMenuCode = {"Chemlight_yellow" call d_fnc_attachchemlight}};
	if (_this == 18) exitWith {d_commandingMenuCode = {"Chemlight_blue" call d_fnc_attachchemlight}};
	if (_this == 20) exitWith {d_commandingMenuCode = {call d_fnc_detachchemlight}};
	if (_this == 30) exitWith {d_commandingMenuCode = {call d_fnc_airtaxi;d_commandingMenuIniting = false}};
	if (_this == 31) exitWith {d_commandingMenuCode = {call d_fnc_changeairtaxidest;d_commandingMenuIniting = false}};
	if (_this == 40) exitWith {
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
	if (_this == 50) exitWith {
		d_commandingMenuCode = {
#ifndef __TT__
			missionNamespace setVariable ["d_arty_stopp", true, true];
#else
			if (d_player_side == opfor) then {
				missionNamespace setVariable ["d_arty_stopp_e", true, true];
			} else {
				missionNamespace setVariable ["d_arty_stopp_w", true, true];
			};
#endif
			d_commandingMenuIniting = false;
		};
	};
	if (_this == 60) exitWith {d_commandingMenuCode = {call d_fnc_makeuav;d_commandingMenuIniting = false}};
	if (_this == 70) exitWith {d_commandingMenuCode = {call d_fnc_makeuav_combat;d_commandingMenuIniting = false}};
	if (_this == 99) exitWith {
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