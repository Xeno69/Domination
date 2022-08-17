//#define __DEBUG__
#include "..\x_setup.sqf"

/*
Guided Missile script V.1.1 created by Barbuse, dec 2016
To use this script add the following code into a trigger:
nul=[target, startLocation, missileType, missileLaunchingHeight] execVM "guidedMissile.sqf"
For exemple, if the target is laser designated by the player:
nul=[laserTarget player, getPos startLocation, "M_Scalpel_AT", 500] execVM "guidedMissile.sqf"
*/

//initializing parameters
params ["_target", "_startPos", "_missileType", "_missileHeight", "_instigator"];
__TRACE_1("","_this")

//defining parameters
//the faster the target, the more checks it will need 100 is good for fast moving targets such as aircrafts
private _perSecondsChecks = 100;
//actual speed of a AIM-54 Phoenix AA missile
private _missileSpeed = 6174;

//if no target is found -> exit
if (_target isEqualTo []) exitWith {hintSilent "No Target Found!"};

//create missile and setting pos
_startPos set [2, _missileHeight];

//creating missile
private _missile = _missileType createVehicle _startPos;
_missile setShotParents [_instigator, _instigator];
__TRACE_3("","_missile","getPos _missile","_missile distance _target")

// todo - orient the missile to point toward the target?

//ajusting missile pos while flying
while {alive _missile && {_missile distance2D _target > 1}} do {
	//__TRACE_2("flying","_missile","_missile distance2D _target")
	//if (_missile distance _target > (_missileSpeed / 10)) then {
	if (_missile distance _target > 5) then {
		_missile setDir (_missile getDir _target);
		private _dirVer = if (_target isEqualType []) then {
			asin ((((getPosASL _missile) # 2) - (_target # 2)) / (_target distance _missile));
		} else {
			asin ((((getPosASL _missile) # 2) - ((getPosASL _target) # 2)) / (_target distance _missile));
		};
		__TRACE_1("","_dirVer")
		if (_dirVer isEqualType 0) then {// asin can return something like -1.#IND if the value isn't correct (asin 2 for example)
			_dirVer = _dirVer * -1;
			__TRACE_2("","_missile","_dirVer")
			[_missile, _dirVer, 0] call BIS_fnc_setPitchBank;
		};
		_flyingTime = (_target distance _missile) / _missileSpeed;
		private "_velocityX";
		private "_velocityY";
		private "_velocityZ";
		if (_target isEqualType []) then {
			_velocityX = ((_target select 0) - ((getPosASL _missile) select 0)) / _flyingTime;
			_velocityY = ((_target select 1) - ((getPosASL _missile) select 1)) / _flyingTime;
			_velocityZ = ((_target select 2) - ((getPosASL _missile) select 2)) / _flyingTime;
		} else {
			_velocityX = (((getPosASL _target) select 0) - ((getPosASL _missile) select 0)) / _flyingTime;
			_velocityY = (((getPosASL _target) select 1) - ((getPosASL _missile) select 1)) / _flyingTime;
			_velocityZ = (((getPosASL _target) select 2) - ((getPosASL _missile) select 2)) / _flyingTime;
		};
		_missile setVelocity [_velocityX, _velocityY, _velocityZ];
		
		sleep (1/ _perSecondsChecks);
	};
};
__TRACE_1("","alive _missile")
if (!alive _missile) then {
	_missile setDamage 1;
};
