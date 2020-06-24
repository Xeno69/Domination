// by WINSE
//#define __DEBUG__
#define THIS_FILE "fn_LowGearOn.sqf"
#include "..\x_setup.sqf"

private _direction = {
	params ["_vel", "_veh"];

	private _vdir = (_vel select 0) atan2 (_vel select 1);
	if (_vdir < 0) then {_vdir = _vdir + 360};
	private _dir = getDir _veh;
	if (_dir < 0) then {_dir = _dir + 360};

	_vdir = _vdir - _dir;

	(abs _vdir < 15)
};

private _min = 30;
private _max = 40;

RIP_LOWGEARON = true;
private _veh = vehicle player;
_veh removeAction RIP_LOWGEARACTON;
RIP_LOWGEARACTON = nil;
RIP_LOWGEARACTOFF = _veh addAction [localize "STR_DOM_MISSIONSTRING_2035", {RIP_LOWGEARON = false}, "", -1, false, false, "", "driver  _target == _this"];

while {RIP_LOWGEARON && {player != _veh && {player == driver _veh && {canMove _veh}}}} do {
	private _speed = speed _veh;
	private _vel = velocity _veh;
	if (_speed < _min) then {
		if (inputAction "MoveForward" == 1 && {_speed > 0 && {[_vel, _veh] call _direction}}) then {
			_veh setVelocity [(_vel select 0) * 1.3, (_vel select 1) * 1.3, (_vel select 2) * 1.3];
		};
	} else {
		if (_speed > _max && {[_vel, _veh] call _direction}) then {
			_veh setVelocity [(_vel select 0) * 0.7, (_vel select 1) * 0.7, (_vel select 2) * 0.7];
		};
	};
	sleep 0.1;
};

RIP_LOWGEARON = false;
_veh removeAction RIP_LOWGEARACTOFF;
RIP_LOWGEARACTOFF = nil;

__TRACE("Off")
