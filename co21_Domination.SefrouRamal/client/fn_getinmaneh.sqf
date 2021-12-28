// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_player_in_base = false;
d_vec_role_pl = assignedVehicleRole player;
if (d_player_canu) then {
	d_player_in_vec = true;
	call d_fnc_vehicleScripts;
} else {
	d_player_in_vec = false;
};

