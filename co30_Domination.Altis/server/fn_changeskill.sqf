// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_changeskill.sqf"
#include "..\x_setup.sqf"

// _mode
// 0 normal vision
// 1 night, fog, rain

params ["_u", "_mode", ["_init", false]];

if (!_init && {isNil {_u getVariable "d_spotDistance"}}) exitWith {};

// save initial values
if (_init) then {
	_u setVariable ["d_spotDistance", _u skill "spotDistance"];
	_u setVariable ["d_spotTime", _u skill "spotTime"];
	_u setVariable ["d_aimingSpeed", _u skill "aimingSpeed"];
};

if (_mode == 0) then {
	_u setSkill ["spotDistance", _u getVariable "d_spotDistance"];
	_u setSkill ["spotTime", _u getVariable "d_spotTime"];
	_u setSkill ["aimingSpeed", _u getVariable "d_aimingSpeed"];
} else {
	_u setSkill ["spotDistance", 0.18];
	_u setSkill ["spotTime", 0.18];
	_u setSkill ["aimingSpeed", 0.18];
};

// TODO calculate better?
// add random value?
// if unit has nv goggles raise value in the night?

//Novice < 0.25
//Rookie >= 0.25 and <= 0.45
//Recruit > 0.45 and <= 0.65
//Veteran > 0.65 and <= 0.85
//Expert > 0.85