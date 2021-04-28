// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("frame")
if (d_player_canu) then {
	#ifdef __DEBUG__
	_cmdm = commandingMenu;
	__TRACE_1("","_cmdm")
	#endif
	if (commandingMenu == "") then {
		call d_commandingMenuCode;
		d_commandingMenuCode = nil;
		d_DomCommandingMenuBlocked = false;
	};
} else {
	d_commandingMenuCode = nil;
	d_DomCommandingMenuBlocked = false;
	d_commandingMenuIniting = false;
};