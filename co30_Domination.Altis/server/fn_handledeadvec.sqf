// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handledeadvec.sqf"
#include "..\x_setup.sqf"

params ["_v"];
{_v deleteVehicleCrew _x} forEach (crew _v);
if (d_del_crew_always == 0) then {
	((_v getVariable ["d_crew", []]) select {alive _x}) apply {_x setDamage 1};
};
[_v, 5] spawn d_fnc_disglobalsim;
