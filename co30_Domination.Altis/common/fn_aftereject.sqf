// by Xeno
#define THIS_FILE "fn_aftereject.sqf"
#include "..\x_setup.sqf"

params ["_vec"];

if (!isNil {_vec getVariable "d_eject_check"}) exitWith {};

_vec setVariable ["d_eject_check", true];

sleep 20;

if (!alive _vec) exitWith {};

if (_vec animationPhase (getText (configFile >> "CfgVehicles" >> typeOf _vec >> "EjectionSystem" >> "CanopyHideAnim")) > 0.01) then {
	_vec setDamage 1;
} else {
	_vec setVariable ["d_eject_check", nil];
};
