//#define __DEBUG__
#include "..\x_setup.sqf"

// guide a bomb with just one guidance "push" ie-- no guidance after being launched
// see also fn_moduleCAS_guidedmissile.sqf for a continuously guided bomb

//initializing parameters
params ["_target", "_startPos", "_missileType", ["_missileHeight", 500], "_instigator", ["_missileSpeed", 1300], ["_perSecondsChecks", 100], ["_minimalGuidance", false]];
__TRACE_1("","_this")

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
private _startTime = time;
private _initialDistanceToTarget = _missile distance _targetPos;
private _distanceSelfDetonate = 700;
private _shouldExit = false;
private _maxFlightTime = 7; // in seconds
__TRACE_3("","_missile","getPos _missile","_missile distance _targetPos")

__TRACE_1("","alive _missile")

_missile setDir (_missile getDir _targetPos);
private _dirVer = asin ((((getPosASL _missile) # 2) - (_targetPos # 2)) / (_targetPos distance _missile));
if (_dirVer isEqualType 0) then {// asin can return something like -1.#IND if the value isn't correct (asin 2 for example)
    _dirVer = _dirVer * -1;
    __TRACE_2("","_missile","_dirVer")
    [_missile, _dirVer, 0] call BIS_fnc_setPitchBank;
};
__TRACE_1("","_dirVer")
_flyingTime = (_targetPos distance _missile) / _missileSpeed;
private _velocityX = ((_targetPos select 0) - ((getPosASL _missile) select 0)) / _flyingTime;
private _velocityY = ((_targetPos select 1) - ((getPosASL _missile) select 1)) / _flyingTime;
private _velocityZ = ((_targetPos select 2) - ((getPosASL _missile) select 2)) / _flyingTime;
_missile setVelocity [_velocityX, _velocityY, _velocityZ];

sleep 7;

if (alive _missile) then {
    // self detonate
    _missile setDamage 1;
};
