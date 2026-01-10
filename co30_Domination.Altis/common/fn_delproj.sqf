// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (isNil "_this" || {isNull _this}) exitWith {};

params ["_proj"];

private _pclass = typeOf _proj;

if (_pclass isKindOf ["MissileCore", configFile >> "CfgAmmo"] || {_pclass isKindOf ["RocketCore", configFile >> "CfgAmmo"]}) then {
	deleteVehicle _proj;
};
