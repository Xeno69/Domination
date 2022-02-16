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
_target = _this select 0;
_startPos = _this select 1;
_missileType = _this select 2;
_missileHeight = _this select 3;

//defining parameters
//the faster the target, the more checks it will need 100 is good for fast moving targets such as aircrafts
_perSecondsChecks = 100;
//actual speed of a AIM-54 Phoenix AA missile
_missileSpeed = 6174;
_pos = [0,0,0];

//if no target is found -> exit
if (isNull _target) exitWith {hintSilent "No Target Found!"};


//create missile and setting pos
_pos = [_startPos select 0, _startPos select 1, _missileHeight];

//creating missile
_missile = _missileType createVehicle _pos;

// todo - orient the missile to point toward the target?

//ajusting missile pos while flying
while {alive _missile && {_missile distance2D _target > 1}} do {
	//if (_missile distance _target > (_missileSpeed / 10)) then {
	if (_missile distance _target > 5) then {
		_dirHor = [_missile, _target] call BIS_fnc_DirTo;
		_missile setDir _dirHor;
		
		_dirVer = asin ((((getPosASL _missile) select 2) - ((getPosASL _target) select 2)) / (_target distance _missile));
		_dirVer = (_dirVer * -1);
		[_missile, _dirVer, 0] call BIS_fnc_setPitchBank;
		
		_flyingTime = (_target distance _missile) / _missileSpeed;
		_velocityX = (((getPosASL _target) select 0) - ((getPosASL _missile) select 0)) / _flyingTime;
		_velocityY = (((getPosASL _target) select 1) - ((getPosASL _missile) select 1)) / _flyingTime;
		_velocityZ = (((getPosASL _target) select 2) - ((getPosASL _missile) select 2)) / _flyingTime;
		_missile setVelocity [_velocityX, _velocityY, _velocityZ];
		
		
		sleep (1/ _perSecondsChecks);
	};
};
_missile setDamage 1;
