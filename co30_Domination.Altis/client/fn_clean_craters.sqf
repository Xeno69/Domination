// by Xeno
#include "..\x_setup.sqf"

sleep 60;

while {true} do {
	sleep (300 + random 240);
	private _har = allMissionObjects "CraterLong";
	sleep 4;
	_har append allMissionObjects "Crater";
	{
		deleteVehicle _x;
		sleep 0.212;
	} forEach _har;
};
