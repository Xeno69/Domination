#define THIS_FILE "mando_chute.sqf"
#include "..\x_setup.sqf"
/*
   mando_chute.sqf v1.1
   by Mandoble

   Moves a chute to the landing position
*/

params ["_man", "_target_pos", "_rad", "_bla", "_chuto", "_is_ammo"];

if (count _target_pos == 2) then {_target_pos pushBack 0};
private _ang = random 360;
_target_pos = [[(_target_pos # 0) + (sin _ang) * _rad, (_target_pos # 1) + (cos _ang) * _rad, 0], [_target_pos # 0, _target_pos # 1, 0]] select (_rad == 0);

private _deg_sec = 30;
private _max_spd = 4;
private _hspd = _max_spd;
private _acc = 2;
private _vh = 0;
private _vz = -3;

private _timeold = time;
private _dir = getDir _chuto;
_chuto setDir _dir;
private _posc = getPosASL _chuto;

//_cone = "RoadCone_F" createVehicleLocal [10,10,10];//Sign_F
private _cone = "Land_ClutterCutter_small_F" createVehicleLocal [10,10,10];
_cone setDir _dir;
_cone setPosASL [_posc # 0, _posc # 1, (_posc # 2) - 2];
_posc = getPosASL _cone;
private _detached = false;
while {alive _chuto && {(getPos _chuto # 2) > 5}} do {
	private _deltatime = (time - _timeold) max 0.001;
	_timeold = time;
   
	_posc = getPosASL _cone;
	_ang = _posc getDir _target_pos;
	if (([_target_pos # 0, _target_pos # 1, 0] distance [_posc # 0, _posc # 1, 0]) > (getPos _cone # 2)) then {
		if ((_vz + 0.5 * _deltatime) < -1.5) then {_vz = _vz + 0.5 * _deltatime};
	} else {
		if ((_vz - 0.5 * _deltatime) > -3) then {_vz = _vz - 0.5 * _deltatime};
	};

	private _dif = _ang - _dir;
	if (_dif < 0) then {_dif = 360 + _dif};
	if (_dif > 180) then {_dif = _dif - 360};
	private _difabs = abs _dif;
  
	//private _turn = [0, _dif / _difabs] select (_difabs > 0.01);
	private _turn = if (_difabs > 0.01) then {_dif / _difabs} else {0};

	_dir = _dir + (_turn * ((_deg_sec * _deltatime) min _difabs));

	if (_vh < _hspd) then {
		_vh = _vh + (_acc * _deltatime);
	} else {
		if (_vh > _hspd) then {_vh = _vh - (_acc * _deltatime)};
	};

	_hspd = [_max_spd, _max_spd / 3] select (_difabs > 45);
	_cone setDir _dir;
	_cone setVelocity [(sin _dir) * _vh, (cos _dir) * _vh, _vz];
	if (!isNull _man) then {_man setDir _dir};
	_chuto setPos (_cone modelToWorld [0,0,2]);
	_chuto setDir _dir;
	
	if (!_is_ammo && {!_detached && {position _man # 2 <= 4}}) then {
		detach _man;
		_detached = true;
		private _pos_man = position _man;
		private _helper1 = d_HeliHEmpty createVehicleLocal [0, 0, 0];
		_helper1 setPos [_pos_man # 0, _pos_man # 1, 0];
		_man setPos [_pos_man # 0, _pos_man # 1, 0];
		_man setVectorUp (vectorUp  _helper1);
		deleteVehicle _helper1;
	};
	sleep 0.01;
};
private _pos_conex = getPos _cone;
deleteVehicle _cone;
if (_is_ammo) then {
	_pos_conex remoteExecCall ["d_fnc_air_box", [0, -2] select isDedicated];
} else {
	if (position _man # 2 <= -1) then {
		private _pos_man = getPos _man;
		_pos_man set [2, 0];
		private _helper1 = d_HeliHEmpty createVehicleLocal _pos_man;
		_helper1 setPos _pos_man;
		_man setPos _pos_man;
		_man setVectorUp (vectorUp  _helper1);
		deleteVehicle _helper1;
	};
};
