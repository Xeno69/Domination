// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handledeadvec.sqf"
#include "..\..\x_setup.sqf"

params ["_v"];
{_v deleteVehicleCrew _x} forEach (crew _v);
_v setFuel ((fuel _v) / 5);
_v spawn {
	sleep 5;
	if (!isNull _this) then {
		[_this, false] remoteExecCall ["enableSimulationGlobal", 2];
	};
};
