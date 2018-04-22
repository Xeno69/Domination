// by Xeno
#define THIS_FILE "fn_getenemyflagtex.sqf"
#include "..\..\x_setup.sqf"

switch (d_enemy_side_short) do {
	case "E": {d_flag_str_opfor};
	case "W": {d_flag_str_blufor};
	case "G": {d_flag_str_independent};
};