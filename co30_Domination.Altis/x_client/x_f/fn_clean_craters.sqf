// by Xeno
#define THIS_FILE "fn_clean_craters.sqf"
#include "..\..\x_setup.sqf"

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
	sleep 0.1;
	if (!isNil "d_airboxes" && {!(d_airboxes isEqualTo [])}) then {
		{
			deleteVehicle _x;
		} forEach (d_airboxes select {time > _x getVariable ["d_airboxtime", -1]});
		d_airboxes = d_airboxes - [objNull];
	};
};
