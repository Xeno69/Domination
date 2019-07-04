// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getinmaneh.sqf"
#include "..\..\x_setup.sqf"

d_player_in_base = false;
d_vec_role_pl = assignedVehicleRole player;
if (alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}) then {
	d_player_in_vec = true;
	_this call d_fnc_vehicleScripts;
} else {
	d_player_in_vec = false;
};

