// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_v", "_d"];

if !(_v getVariable ["d_drowned", false]) exitWith {};

if (!alive _v) exitWith {
	_v setVariable ["d_drowned", false];
};

#ifdef __214__
if (_d && {waterDamaged _v}) then {
	_v setVariable ["d_drowned", false];
	_v setDamage [1, false];
};
#endif
