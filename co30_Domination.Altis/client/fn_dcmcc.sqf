// by Xeno
#include "..\x_setup.sqf"

while {true} do {
	sleep 0.2;
	if (!isNil "d_commandingMenuCode") then {
		call d_fnc_command_menu;
	};
};