// by Xeno
#define THIS_FILE "fn_heli_action.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_vec", "_unit"];

if (_unit == driver _vec) then {
	_vec removeAction (param [2]);
	_vec setVariable ["d_vec_attached", true];
};