// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hddelu.sqf"
#include "..\x_setup.sqf"

params ["_unit"];
sleep 10;
if (isNull objectParent _unit) then {
	deleteVehicle _unit;
} else {
	(vehicle _unit) deleteVehicleCrew _unit;
};