// by Xeno
#define THIS_FILE "fn_bikekilled.sqf"
#include "..\x_setup.sqf"

params ["_vec"];

sleep 20.123;
deleteVehicle _vec;
d_flag_vec = objNull;