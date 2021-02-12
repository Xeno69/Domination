// by Xeno
#define THIS_FILE "fn_delmaloc.sqf"
#include "..\x_setup.sqf"

if (d_player_side != (_this # 1)) then {
	deleteMarkerLocal (_this # 0);
};
