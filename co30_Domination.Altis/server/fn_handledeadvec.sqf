// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handledeadvec.sqf"
#include "..\x_setup.sqf"

params ["_v"];
{_v deleteVehicleCrew _x} forEach (crew _v);
[_v, 5] spawn d_fnc_disglobalsim;
