// by Xeno
#include "..\x_setup.sqf"

sleep 60;

while {true} do {
	sleep (300 + random 240);
	private _har = allMissionObjects "#crater";
	{
		deleteVehicle _x;
		sleep 0.212;
	} forEach _har;
};
