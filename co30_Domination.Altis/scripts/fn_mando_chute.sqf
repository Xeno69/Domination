//#define __DEBUG__
#define THIS_FILE "mando_chute.sqf"
#include "..\x_setup.sqf"
/*
   mando_chute.sqf v1.1
   by Mandoble

   Moves a chute to the landing position
*/

params ["_man", "_target_pos", "_rad", "_bla", "_chuto", "_is_ammo"];

__TRACE_1("","_this")

if (count _target_pos == 2) then {_target_pos pushBack 0};
private _ang = random 360;
if (_rad > 0) then {
	_target_pos = _targetPos getPos [_rad, random 360];
};
_target_pos set [2, 0];

__TRACE_1("","_target_pos")

private _deg_sec = 30;
private _max_spd = 4;
private _hspd = _max_spd;
private _acc = 2;
private _vh = 0;
private _vz = -3;

if (!isNull _man) then {_man allowDamage false};

private _timeold = time;
private _dir = getDir _chuto;
_chuto setDir _dir;
_chuto setPos (_man modelToWorld [0,0,2]);
private _posc = getPosASL _chuto;
__TRACE_1("","_posc")

//private _cone = "RoadCone_F" createVehicle [0,0,0];
//private _cone = "Land_ClutterCutter_small_F" createVehicle [0,0,0];
private _cone = "ArrowDesk_L_F" createVehicle [0,0,0];

hideObjectGlobal _cone;
__TRACE_1("","_cone")
_cone setDir _dir;
_cone setPosASL [_posc # 0, _posc # 1, (_posc # 2) - 2];
__TRACE_1("2","_posc")
private _detached = false;
__TRACE_1("","getPos _chuto select 2")
__TRACE_1("","getPos _man select 2")
while {alive _chuto && {((ASLtoATL getPosASL _chuto) # 2) > 5}} do {
	private _deltatime = (time - _timeold) max 0.001;
	__TRACE_1("","_deltatime")
	_timeold = time;

	_posc = getPosASL _cone;
	_ang = _posc getDir _target_pos;
	__TRACE_1("","_ang")
	if ((_target_pos distance [_posc # 0, _posc # 1, 0]) > ((ASLtoATL getPosASL _cone) # 2)) then {
		if ((_vz + 0.5 * _deltatime) < -1.5) then {_vz = _vz + 0.5 * _deltatime};
	} else {
		if ((_vz - 0.5 * _deltatime) > -3) then {_vz = _vz - 0.5 * _deltatime};
	};

	private _dif = _ang - _dir;
	if (_dif < 0) then {_dif = 360 + _dif};
	if (_dif > 180) then {_dif = _dif - 360};
	private _difabs = abs _dif;

	private _turn = if (_difabs > 0.01) then {_dif / _difabs} else {0};
	__TRACE_1("","_turn")

	_dir = _dir + (_turn * ((_deg_sec * _deltatime) min _difabs));

	if (_vh < _hspd) then {
		_vh = _vh + (_acc * _deltatime);
	} else {
		if (_vh > _hspd) then {_vh = _vh - (_acc * _deltatime)};
	};

	_hspd = if (_difabs > 45) then {_max_spd / 3} else {_max_spd};
	_cone setDir _dir;
	_cone setVelocity [(sin _dir) * _vh, (cos _dir) * _vh, _vz];
	if (!isNull _man) then {_man setDir _dir};
	_chuto setPos (_cone modelToWorld [0 ,0, 2]);
	_chuto setDir _dir;

	if (!_is_ammo && {!_detached && {(ASLtoATL getPosASL _man) select 2 <= 4}}) then {
		detach _man;
		_detached = true;
		private _pos_man = ASLtoATL getPosASL _man;
		private _helper1 = d_HeliHEmpty createVehicle [0, 0, 0];
		_helper1 setPos [_pos_man # 0, _pos_man # 1, 0];
		_man setPos [_pos_man # 0, _pos_man # 1, 0];
		_man setVectorUp (vectorUp  _helper1);
		deleteVehicle _helper1;
	};
	sleep 0.01;
	__TRACE_1("","getPos _cone select 2")
	__TRACE_1("","getPos _chuto select 2")
};
__TRACE("Loop over")
private _pos_conex = getPos _cone;
deleteVehicle _cone;
if (_is_ammo) then {
	private _box = createVehicle [d_the_box, [0, 0, 0], [], 0, "NONE"];
	_box setPos _target_pos;
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackpackCargoGlobal _box;
	clearItemCargoGlobal _box;
	[_box] remoteExecCall ["d_fnc_air_box", [0, -2] select isDedicated];
	if (isNil "d_airboxes") then {
		d_airboxes = [];
	};
	_box setVariable ["d_airboxtime", time + 1800];
	d_airboxes pushBack _box;
	_box enableRopeAttach false;
	_box enableSimulationGlobal false;
	_box addEventHandler ["killed",{
		deleteVehicle (_this select 0);
	}];
#ifndef __TT__
	private _mname = format ["d_ab_%1", _box];
	[_mname, _box, "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_523", 0, d_dropped_box_marker] call d_fnc_CreateMarkerGlobal;
	_box setVariable ["d_mname", _mname];
#endif
} else {
	if (position _man # 2 <= -1) then {
		private _pos_man = getPos _man;
		_pos_man set [2, 0];
		private _helper1 = d_HeliHEmpty createVehicle _pos_man;
		_helper1 setPos _pos_man;
		_man setPos _pos_man;
		_man setVectorUp (vectorUp  _helper1);
		deleteVehicle _helper1;
	};
};
if (!isNull _man) then {
	sleep 2;
	_man allowDamage true;
};
