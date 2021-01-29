// by Xeno
#define THIS_FILE "fn_delmarsidett.sqf"
#include "..\x_setup.sqf"

if (_this # 1 != d_player_side) then {
	deleteMarkerLocal (_this # 0);
};