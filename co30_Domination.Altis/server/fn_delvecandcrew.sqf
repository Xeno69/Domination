// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

// A3_206 deleteVehicleCrew _this;
{_this deleteVehicleCrew _x} forEach (crew _this);
deleteVehicle _this;
