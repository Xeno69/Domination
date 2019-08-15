// by Xeno
#define THIS_FILE "fn_heli_release.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_vec", "_caller"];

//if (_caller == driver _vec) then {
if (_caller == currentPilot _vec) then {
	_vec removeAction (_this select 2);
	_vec setVariable ["d_vec_released", true, true];
};