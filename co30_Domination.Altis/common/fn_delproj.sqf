// by Xeno
#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_proj"];

private _pclass = typeOf _proj;

if (_pclass isKindOf ["MissileCore", configFile >> "CfgAmmo"] || {_pclass isKindOf ["RocketCore", configFile >> "CfgAmmo"]}) then {
	deleteVehicle _proj;
};
