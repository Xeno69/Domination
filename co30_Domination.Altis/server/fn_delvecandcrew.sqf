// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

{_this deleteVehicleCrew _x} forEach (crew _this);
deleteVehicle _this;
