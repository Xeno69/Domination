// by Xeno
#include "..\x_setup.sqf"

if (d_enemy_side_short == "E") exitWith {
	d_flag_str_opfor
};
if (d_enemy_side_short == "W") exitWith {
	d_flag_str_blufor
};
d_flag_str_independent
