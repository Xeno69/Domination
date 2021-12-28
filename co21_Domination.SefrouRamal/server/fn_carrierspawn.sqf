// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];

__TRACE_1("","_vec")
__TRACE_1("","getPosASL _vec")

_vec setVariable ["d_posasl", getPosASL _vec];

_vec allowDamage false;
[_vec] spawn {
	scriptname "spawn carrierspawn";
	params ["_vec"];
	sleep 1;
	_vec setPosASL (_vec getVariable "d_posasl");
	_vec setDamage 0;
	sleep 2;
	_vec allowDamage true;
};
