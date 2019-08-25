// by Xeno
#define THIS_FILE "fn_heli_action.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_vec", "_unit"];

if (_unit == currentPilot _vec) then {
	_vec removeAction (_this select 2);
	_vec setVariable ["d_vec_attached", true, true];
};