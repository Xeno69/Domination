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
params ["_target", "_startPos", "_missileType", "_missileHeight", "_instigator", ["_missileSpeed", 1300], ["_perSecondsChecks", 100], ["_minimalGuidance", false]];
__TRACE_1("","_this")

//defining parameters
//the faster the target, the more checks it will need 100 is good for fast moving targets such as aircrafts
//private _perSecondsChecks = 100;
//actual speed of a AIM-54 Phoenix AA missile // Hmmm I don't think so, appears to be ~4680 km/h which is ~1300 m/s  -Longtime
//private _missileSpeed = 6174;
//_minimalGuidance - launch along target vector but do not guide, self detonate if missile goes too far past the target or at 920m or at 3 seconds of flight

private _guideTheShot = {
	_shotHasBeenGuided = true;
	_missile setDir (_missile getDir _targetPos);
	if (_dirVer isEqualType 0) then {// asin can return something like -1.#IND if the value isn't correct (asin 2 for example)
		_dirVer = _dirVer * -1;
		__TRACE_2("","_missile","_dirVer")
		[_missile, _dirVer, 0] call BIS_fnc_setPitchBank;
	};
	_missile setVelocity [_velocityX, _velocityY, _velocityZ];
};

private _targetPos = [];
if (_target isEqualType []) then {
	_targetPos = _target;
} else {
	_targetPos = getPosASL _target;
};

//if no target is found -> exit
if (_targetPos isEqualTo []) exitWith {hintSilent "No Target Found!"};

if (_missileHeight > 0) then {
	//create missile and setting pos
	_startPos set [2, _missileHeight];
};

//creating missile
private _missile = _missileType createVehicle _startPos;
_missile setShotParents [_instigator, _instigator];
private _shotHasBeenGuided = false;
private _startTime = time;
private _initialDistanceToTarget = _missile distance _targetPos;
private _distanceSelfDetonate = 700;
__TRACE_3("","_missile","getPos _missile","_missile distance _targetPos")


while { alive _missile && { _targetPos distance _missile > 9 }} do {
	private _dirVer = asin ((((getPosASL _missile) # 2) - (_targetPos # 2)) / (_targetPos distance _missile));
	__TRACE_1("","_dirVer")
	_flyingTime = (_targetPos distance _missile) / _missileSpeed;
	private "_velocityX";
	private "_velocityY";
	private "_velocityZ";
	_velocityX = ((_targetPos select 0) - ((getPosASL _missile) select 0)) / _flyingTime;
	_velocityY = ((_targetPos select 1) - ((getPosASL _missile) select 1)) / _flyingTime;
	_velocityZ = ((_targetPos select 2) - ((getPosASL _missile) select 2)) / _flyingTime;
	if (_minimalGuidance) then {
		if (!_shotHasBeenGuided) then {
			// minimal guidance, only guide once
			[] call _guideTheShot;
		};
		if (_missile distance _startPos > _distanceSelfDetonate || { time - _startTime > 3 }) then {
			// self detonate
			_missile setDamage 1;
		};
	} else {
		[] call _guideTheShot;
	};
	
	sleep (1/ _perSecondsChecks);
};
__TRACE_1("","alive _missile")
if (!alive _missile) then {
	_missile setDamage 1;
};
