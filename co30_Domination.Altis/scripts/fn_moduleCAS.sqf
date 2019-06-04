//#define __DEBUG__
#define THIS_FILE "fn_moduleCAS.sqf"
#include "..\x_setup.sqf"

params ["_lpos", "_caller", "_wtype"];

__TRACE_1("","_this")

private _callero = objectFromNetId _caller;
private _side = side (group _callero);

#ifndef __TT__
if (!isServer || {!d_cas_available}) exitWith {};
d_cas_available = false;
publicVariable "d_cas_available";
#else
if (!isServer || {_side == blufor && {!d_cas_available_w}}) exitWith {};
if (_side == opfor && {!d_cas_available_e}) exitWith {};

if (_side == blufor) then {
	d_cas_available_w = false;
	publicVariable "d_cas_available_w";
} else {
	if (_side == opfor) then {
		d_cas_available_e = false;
		publicVariable "d_cas_available_e";
	};
};
#endif

if (d_with_ranked || {d_database_found}) then {
	_callero addScore -(d_ranked_a # 22);
};

#ifndef __TT__
private _planeClass = d_cas_plane;
#else
private _planeClass = d_cas_plane select (_side == opfor);
#endif
__TRACE_1("","_planeClass")

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {
#ifndef __TT__
	d_cas_available = true;
	publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true;
		publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true;
		publicVariable "d_cas_available_w";
	};
#endif
	false
};

#ifndef __IFA3LITE__
//--- Detect gun
private _weaponTypes = switch _wtype do {
	case 0: {["machinegun"]};
	case 1: {["rocketlauncher"]};
	case 2: {["machinegun", "rocketlauncher"]};
	default {[]};
};
#else
private _weaponTypes = switch _wtype do {
	case 0: {["machinegun"]};
	case 1: {["vehicleweapon"]};
	case 2: {["vehicleweapon"]};
	default {[]};
};
#endif

__TRACE_1("","_weaponTypes")

private _pylweaps = [];
private _cfg = _planeCfg>>"Components">>"TransportPylonsComponent">>"pylons";
if (isClass _cfg) then {
	for "_i" from 0 to (count _cfg - 1) do {
		private _curpylon = _cfg select _i;
		private _tweap = getText (configFile>>"CfgMagazines">>getText (_curpylon>>"attachment")>>"pylonWeapon");
		__TRACE_1("","_tweap")
		if (_tweap != "") then {
			_pylweaps pushBackUnique _tweap;
		};
	};
};

private _weapons = [];
{
	__TRACE_2("","_x","_x call bis_fnc_itemType")
	if (toLower ((_x call bis_fnc_itemType) # 1) in _weaponTypes) then {
		private _modes = getArray (configFile>>"cfgweapons">>_x>>"modes");
		__TRACE_1("","_modes")
		if !(_modes isEqualTo []) then {
			_modes params ["_mode"];
			if (_mode == "this") then {_mode = _x;};
			_weapons pushBack [_x, _mode];
		};
	};
} forEach (getArray (_planeCfg >> "weapons") + _pylweaps);
#ifdef __DEBUG__
_mmm = getArray (_planeCfg >> "weapons");
__TRACE_1("","_mmm")
#endif
__TRACE_1("","_weapons")

if (_weapons isEqualTo []) exitwith {
#ifndef __TT__
	d_cas_available = true;
	publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true;
		publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true;
		publicVariable "d_cas_available_w";
	};
#endif
	false
};

remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];

#ifdef __TT__
private _topicside = ["HQ_W", "HQ_E"] select (_side == opfor);
private _logic = [d_hq_logic_blufor2, d_hq_logic_opfor2] select (_side == opfor);
private _logic1 = [d_hq_logic_blufor1, d_hq_logic_opfor1] select  (_side == opfor);
private _channel = "SIDE";
#else
private _topicside = d_kb_topic_side;
private _logic = d_kb_logic2;
private _logic1 = d_kb_logic1;
private _channel = d_kbtel_chan;
#endif

private _callero = objectFromNetId _caller;
if (isNil "_callero" || {isNull _callero}) then {_callero = _logic};
_logic1 kbTell [_callero, _topicside, "CASOnTheWay", _channel];
sleep 1;
_logic1 kbTell [_logic, _topicside, "CASUnavailable", _channel];

private _callerpos = getPos _callero;

private _logico = d_HeliHEmpty createVehicle [10,10,10];
_logico setPos _lpos;
__TRACE_1("","_logico")

private _posATL = getPosAtl _logico;
private _pos = +_posATL;
_pos set [2, (_pos # 2) + getTerrainheightasl _pos];
private _dir = _callerpos getDir _logico;

private _dis = 3000;
private _alt = 1000;
private _pitch = atan (_alt / _dis);
private _speed = 400 / 3.6;
private _duration = ([0,0] distance [_dis, _alt]) / _speed;

//--- Create plane
//private _planePos = [_pos, _dis, _dir + 180] call bis_fnc_relpos;
private _planePos = _pos getPos [_dis, [_dir + 90, _dir - 90] select (random 100 > 50)];
_planePos set [2, (_pos # 2) + _alt];
([_planePos, _dir, _planeClass, (getNumber (_planeCfg>>"side")) call bis_fnc_sideType] call d_fnc_spawnVehicle) params ["_plane", "_crew", "_group"];
_plane setPosasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
if (d_with_ai) then {
	_group setVariable ["d_do_not_delete", true];
};
_plane disableAi "move";
_plane disableAi "target";
_plane disableAi "autotarget";
_plane setCombatMode "blue";

private _vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
private _velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setVectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
private _vectorUp = vectorUp _plane;

//--- Remove all other weapons
private _wpcmls = _weaponTypes + ["countermeasureslauncher"];
private _currentWeapons = weapons _plane;
{
	if !(toLower ((_x call bis_fnc_itemType) # 1) in _wpcmls) then {
		_plane removeWeapon _x;
	};
} forEach _currentWeapons;

_plane setVariable ["d_who_fired", _caller];
_plane addEventhandler ["fired", {_this call d_fnc_casfired}];

//--- Approach
private _fire = [] spawn {
	scriptName "spawn_modulcas";
	waitUntil {false}
};
private _fireNull = true;
private _time = time;
private _offset = [0, 20] select (_weaponTypes findIf {_x == "missilelauncher"} > -1);
waitUntil {
	private _fireProgress = _plane getVariable ["fireProgress", 0];

	//--- Update plane position when module was moved / rotated
	if ((getPosatl _logico distance _posATL > 0 || {_callerpos getDir _logico != _dir}) && {_fireProgress == 0}) then {
		_posATL = getPosatl _logico;
		_pos = +_posATL;
		_pos set [2,(_pos # 2) + getTerrainheightasl _pos];
		_dir = _callerpos getDir _logico;

		_planePos = [_pos,_dis, _dir + 180] call bis_fnc_relpos;
		_planePos set [2, (_pos # 2) + _alt];
		_vectorDir = [_planePos, _pos] call bis_fnc_vectorFromXtoY;
		_velocity = [_vectorDir, _speed] call bis_fnc_vectorMultiply;
		_plane setVectordir _vectorDir;
		//[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
		_vectorUp = vectorUp _plane;

		_plane move ([_pos,_dis, _dir] call bis_fnc_relpos);
	};

	//--- Set the plane approach vector
	_plane setVelocityTransformation [
		_planePos, [_pos # 0, _pos # 1, (_pos # 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir, _vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_plane setVelocity velocity _plane;

	//--- Fire!
	if (_fireNull && {(getPosAsl _plane) distance _pos < 1000}) then {
		_fireNull = false;
		terminate _fire;
		_fire = [_plane,_weapons] spawn {
			scriptName "spawn_modulcas2";
			params ["_plane", "_weapons"];
			private _planeDriver = driver _plane;
			private _duration = 3;
			private _time = time + _duration;
			waitUntil {
				{
					//_plane selectweapon (_x # 0);
					_planeDriver forceWeaponfire _x;
				} forEach _weapons;
				_plane setVariable ["fireProgress", (1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				(time > _time || {isNull _plane || {!canMove _plane}})
			};
			sleep 1;
		};
	};

	sleep 0.01;
	(scriptDone _fire || {isNull _logico || {isNull _plane || {!canMove _plane}}})
};
_plane setVelocity velocity _plane;
_plane flyinHeight _alt;
if (!scriptDone _fire) then {
	terminate _fire;
};

if !(isNull _logico) then {
	sleep 1;
	deleteVehicle _logico;
	waitUntil {_plane distance _pos > _dis || {isNull _plane || {!canMove _plane}}};
};

//--- Delete plane
if (canMove _plane) then {
	deleteVehicle _plane;
	{deleteVehicle _x} forEach _crew;
	deleteGroup _group;
} else {
	[_plane, _crew, _group] spawn {
		scriptName "spawn_modulcas3";
		params ["_plane", "_crew", "_group"];
		sleep 30;
		deleteVehicle _plane;
		{deleteVehicle _x} forEach _crew;
		deleteGroup _group;
	};
};

[_side, _logic1, _logic, _topicside, _channel] spawn {
	scriptName "spawn_cas_available";
	params ["_side", "_logic1", "_logic", "_topicside", "_channel"];
	sleep d_cas_available_time;
#ifndef __TT__
	d_cas_available = true; publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true; publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true; publicVariable "d_cas_available_w";
	};
#endif
	remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];
	_logic1 kbTell [_logic, _topicside, "CASAvailable", _channel];
};
