// by Xeno
#define THIS_FILE "fn_bikekilled.sqf"
#include "..\x_setup.sqf"

params ["_vec"];
sleep 10.123;
while {true} do {
	if (isNull _vec || {(crew _vec) findIf {alive _x} == -1}) exitWith {deleteVehicle _vec};
	sleep 15.123;
};
d_flag_vec = objNull;