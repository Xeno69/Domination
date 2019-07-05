// by Xeno
#define THIS_FILE "fn_dodelintelu.sqf"
#include "..\x_setup.sqf"

if (!isNull d_intel_unit) then {
	deleteVehicle d_intel_unit;
	d_intel_unit = objNull;
};