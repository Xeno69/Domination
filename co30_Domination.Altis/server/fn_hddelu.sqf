// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_unit"];
sleep 10;
if (isNull objectParent _unit) then {
	deleteVehicle _unit;
} else {
	(vehicle _unit) deleteVehicleCrew _unit;
};