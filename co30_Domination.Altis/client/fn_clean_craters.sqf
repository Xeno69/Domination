// by Xeno
#include "..\x_setup.sqf"

sleep 60;

while {true} do {
	sleep (300 + random 240);
	private _har =+ d_craters_array;
	d_craters_array = [];
	{
		deleteVehicle _x;
		sleep 0.212;
	} forEach _har;
};
