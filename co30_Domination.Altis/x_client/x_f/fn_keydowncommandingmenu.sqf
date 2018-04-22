// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_keydowncommandingmenu.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

if (dialog) exitWith {
	showCommandingMenu "";
};

params ["_type"];
__TRACE_1("","_type")

#ifdef __DEBUG__
_cmdm = commandingMenu;
__TRACE_1("","_cmdm")
#endif

if (_type == 0 && {!d_DomCommandingMenuBlocked && {!d_commandingMenuIniting}}) exitWith {
	d_DomCommandingMenuBlocked = true;
	if (commandingMenu != "#USER:d_DomUserMenu") then {
		call d_fnc_CreateDomUserMenu;
		showCommandingMenu "#USER:d_DomUserMenu";
	};
};
if (_type == 1) then {
	d_DomUserMenu = [];
	if (d_DomCommandingMenuBlocked && {!d_commandingMenuIniting}) exitWith {
		d_DomCommandingMenuBlocked = false;
		if (commandingMenu == "#USER:d_DomUserMenu") then {
			showCommandingMenu "";
		};
	};
};