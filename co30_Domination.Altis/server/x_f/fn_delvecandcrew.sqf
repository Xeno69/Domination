// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_delvecandcrew.sqf"
#include "..\..\x_setup.sqf"

{_this deleteVehicleCrew _x} forEach (crew _this);
deleteVehicle _this;
