// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_prebonus.sqf"
#include "..\..\x_setup.sqf"

params ["_vec"];

if (local _vec) then {
	_vec setFuel 0;
};

if (isServer) then {
	_this call d_fnc_bonusvecfnc;
};