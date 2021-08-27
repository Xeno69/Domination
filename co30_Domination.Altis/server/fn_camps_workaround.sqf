// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

deleteVehicle d_current_trigger_helper;
d_current_trigger_helper = nil;

private _endtime = time + 360;

__TRACE_1("","_endtime")

while {true} do {
	if (time > _endtime) exitWith {};
	__TRACE("running")
	sleep 1;
};

if (time > _endtime) then {
	__TRACE("time > endtime")
	d_campscaptured = d_sum_camps;
};
