// *****************************************************
// ** JBOY_UpDown.sqf
// ** Version 1.1
// ** by JohnnyBoy
// ** AI will toggle between two stances with a delay between.  Good for defenders to duck behind walls or windows, then pop back up.
// **  Call:  null = [dude, ["Up","Middle"]] execVM "JBOY\JBOY_UpDown.sqf";
// ** To start with an eventhandler, put this in unit's init:
// this addeventhandler ["FiredNear",{ [_this select 0, ["Up","Middle"]] execVM "JBOY\JBOY_UpDown.sqf";}];
// this addeventhandler ["FiredNear",{ [_this select 0, ["Middle","Down"]] execVM "JBOY\JBOY_UpDown.sqf";}];
//
// *****************************************************
//Zen_JBOY_UpDown

//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

__TRACE_1("","_this")

//  Parameters:

params ["_dude", "_stances", "_dudeOStance", "_type"];

private _iterations = 0;

while {alive _dude && {_iterations < 12}} do {
	if (unitpos _dude == _stances # 0) then {
		_dude setUnitPos (_stances # 1);
	} else {
		_dude setUnitPos (_stances # 0);
	};

	sleep (1.5 + (random 6));

	if (!alive _dude) exitWith {};

	if (isNull (_dude findNearestEnemy _dude)) then { // If no known enemies then increment iterations so that guys stop popping up and down
		//systemchat "no known enemies found";
		_iterations = _iterations + 1;
	};
	__TRACE_1("","_iterations")
	sleep 0.12;
};
if (alive _dude) then {
	_dude setUnitPos _dudeOStance;
	if (_type == 0) then {
		_dude addeventhandler ["FiredNear", {
			[_this # 0, ["DOWN", "MIDDLE"], unitPos (_this # 0), 0] spawn d_fnc_Zen_JBOY_UpDown;
			(_this # 0) removeEventHandler ["FiredNear", _thisEventHandler];
		}];
	} else {
		_dude addeventhandler ["FiredNear", {
			[_this # 0, ["UP", "MIDDLE"], unitPos (_this # 0), 1] spawn d_fnc_Zen_JBOY_UpDown;
			(_this # 0) removeEventHandler ["FiredNear", _thisEventHandler];
		}];
	};
};