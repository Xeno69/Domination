// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handledeadvec.sqf"
#include "..\..\x_setup.sqf"

params ["_v"];
{_v deleteVehicleCrew _x} forEach (crew _v);
_v spawn {
	scriptName "spawn handledeadvec";
	sleep 5;
	if (!isNull _this) then {
		_this enableSimulationGlobal false;
	};
};
