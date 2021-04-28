// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifndef __DEBUG__
sleep 100;
#endif

while {true} do {
	{
		if (!isNull _x && {!isUAVConnected _x && {!isNil {_x getVariable "d_ublocked"}}}) then {
			_x setVariable ["d_ublocked", nil, true];
			_x setVariable ["d_vec", nil, true];
			_x remoteExecCall ["d_fnc_rem_uav"];
			_x setVariable ["d_vcheck", nil, true];
		};
		sleep 0.7;
	} forEach allUnitsUAV;
	sleep 60;
};