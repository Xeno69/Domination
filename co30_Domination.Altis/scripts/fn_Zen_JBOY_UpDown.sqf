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

#define THIS_FILE "fn_Zen_JBOY_UpDown.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

//  Parameters:

params ["_dude", "_stances"];

private _dudeOriginalStance = unitPos _dude;
_dude removeAllEventHandlers "FiredNear";
private _iterations = 0;

while {alive _dude && {_iterations < 12}} do {
	if (unitpos _dude == _stances select 0) then {
		_dude setUnitPos (_stances select 1);
	} else {
		_dude setUnitPos (_stances select 0);
	};

	sleep (1.5 + (random 6));

	if (!alive _dude) exitWith {};

	if (isNull (_dude findNearestEnemy _dude)) then { // If no known enemies then increment iterations so that guys stop popping up and down
		//systemchat "no known enemies found";
		_iterations = _iterations + 1;
	};
	sleep 0.1;
};
if (alive _dude) then {
	_dude setUnitPos _dudeOriginalStance;
	_dude addeventhandler ["FiredNear", {[_this # 0, ["DOWN", "MIDDLE"]] spawn d_fnc_Zen_JBOY_UpDown}];
};