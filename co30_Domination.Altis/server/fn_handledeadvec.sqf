// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_v"];
// A3_206 deleteVehicleCrew _v;
{_v deleteVehicleCrew _x} forEach (crew _v);
if (d_del_crew_always == 0) then {
	((_v getVariable ["d_crew", []]) select {alive _x}) apply {_x setDamage 1};
};
[_v, 5] spawn d_fnc_disglobalsim;
