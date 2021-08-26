// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

deleteVehicle d_current_trigger_helper;
d_current_trigger_helper = nil;

private _endtime = time + 360;

while {true} do {
	if (_time > _endtime) exitWith {};
	sleep 1;
};

if (_time > _endtime) then {
	d_campscaptured = d_sum_camps;
};
