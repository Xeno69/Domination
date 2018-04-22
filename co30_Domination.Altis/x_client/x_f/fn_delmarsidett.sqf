// by Xeno
#define THIS_FILE "fn_delmarsidett.sqf"
#include "..\..\x_setup.sqf"

if (param [1] != d_player_side) then {
	deleteMarkerLocal (param [0]);
};