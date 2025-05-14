//#define __DEBUG__
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

#ifndef __IFA3__
//--- Detect gun
private _weaponTypes = call {
	if (_wtype == 0) exitWith {["machinegun"]};
	if (_wtype == 1) exitWith {["rocketlauncher"]};
	if (_wtype == 2) exitWith {["machinegun", "rocketlauncher"]};
	[]
};
#else
private _weaponTypes = call {
	if (_wtype == 0) exitWith {["machinegun"]};
	if (_wtype == 1) exitWith {["vehicleweapon"]};
	if (_wtype == 2) exitWith {["vehicleweapon"]};
	[]
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
		if (_tweap isNotEqualTo "") then {
			_pylweaps pushBackUnique _tweap;
		};
	};
};

private _weapons = [];
{
	__TRACE_2("","_x","_x call bis_fnc_itemType")
	if (toLowerANSI ((_x call bis_fnc_itemType) # 1) in _weaponTypes) then {
		private _modes = getArray (configFile>>"cfgweapons">>_x>>"modes");
		__TRACE_1("","_modes")
		if (_modes isNotEqualTo []) then {
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

if (isNil "_callero" || {isNull _callero}) then {_callero = _logic};
if (d_force_isstreamfriendlyui == 1) then {
	_logic1 kbTell [_callero, _topicside, "CASOnTheWayNoText", _channel];
} else {
	_logic1 kbTell [_callero, _topicside, "CASOnTheWay", _channel];
};

sleep 1;

if (d_force_isstreamfriendlyui == 1) then {
	_logic1 kbTell [_logic, _topicside, "CASUnavailableNoText", _channel];
} else {
	_logic1 kbTell [_logic, _topicside, "CASUnavailable", _channel];
};

private _callerpos = getPos _callero;

private _logico = d_HeliHEmpty createVehicle [10,10,10];
_logico setPos _lpos;
__TRACE_1("","_logico")

private _posATL = getPosAtl _logico;
private _pos = +_posATL;
_pos set [2, (_pos # 2) + getTerrainheightasl _pos];
private _dir = _callerpos getDir _logico;

private _dis = 2500;
private _alt = 1200;
private _pitch = atan (_alt / _dis);
private _speed = 400 / 3.6;
private _duration = ([0,0] distance [_dis, _alt]) / _speed;

//--- Create plane
//private _planePos = [_pos, _dis, _dir + 180] call bis_fnc_relpos;
private _planePos = _pos getPos [_dis, [_dir + 90, _dir - 90] select (random 100 > 50)];
_planePos set [2, (_pos # 2) + _alt];
([_planePos, _dir, _planeClass, (getNumber (_planeCfg>>"side")) call bis_fnc_sideType] call d_fnc_spawnVehicle) params ["_plane", "_crew", "_group"];
_plane setPosasl _planePos;
if (d_with_dynsim == 0) then {
	_plane setVariable ["d_nodyn", true];
};
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableAi "move";
_plane disableAi "target";
_plane disableAi "autotarget";
_plane setCombatMode "blue";

private _vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
private _velocity = _vectorDir vectorMultiply _speed;
_plane setVectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
private _vectorUp = vectorUp _plane;

//--- Remove all other weapons
private _wpcmls = _weaponTypes + ["countermeasureslauncher"];
private _currentWeapons = weapons _plane;
{
	if !(toLowerANSI ((_x call bis_fnc_itemType) # 1) in _wpcmls) then {
		_plane removeWeapon _x;
	};
} forEach _currentWeapons;

_plane setVariable ["d_who_fired", _caller];
_plane addEventhandler ["fired", {call d_fnc_casfired}];

//--- Approach
private _fire = [] spawn {
	scriptName "spawn_modulcas";
	waitUntil {false}
};
private _fireNull = true;
private _time = time;
private _offset = [0, 20] select (_weaponTypes findIf {_x == "missilelauncher"} > -1);

d_cas_metadata = [_plane, _planePos, _pos, _offset, _velocity, _vectorDir, _vectorUp, _time, _duration];
//publicVariable "d_cas_metadata";

// use eachframe for a smooth approach
["dom_cas_setvelocitytransform", {call d_fnc_moduleCAS_eachframe}] call d_fnc_eachframeadd;

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
		_velocity = _vectorDir vectorMultiply _speed;
		_plane setVectordir _vectorDir;
		//[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
		_vectorUp = vectorUp _plane;

		_plane move ([_pos,_dis, _dir] call bis_fnc_relpos);
		
		// update global variable
		d_cas_metadata = [_plane, _planePos, _pos, _offset, _velocity, _vectorDir, _vectorUp, _time, _duration];

	};

	//--- Fire!
	if (_fireNull && {(getPosAsl _plane) distance _pos < 1200}) then {
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
			["dom_cas_setvelocitytransform"] call d_fnc_eachframeremove;
		};
	};

	sleep 0.01;
	(scriptDone _fire || {isNull _logico || {isNull _plane || {!canMove _plane}}})
};
_plane setVelocity velocity _plane;
_plane flyinHeight _alt * 2;
if (!scriptDone _fire) then {
	terminate _fire;
};

if (canMove _plane && {alive driver _plane}) then {
	for "_i" from 0 to 5 do {
		driver _plane forceWeaponfire ["CMFlareLauncher", "Burst"];
		_time = time + 1.1;
		waitUntil {time > _time || {isNull _logico || {!alive _plane}}};
		if (!alive _plane || {!alive driver _plane}) exitwith {};
	};
};

if !(isNull _logico) then {
	sleep 1;
	deleteVehicle _logico;
	waitUntil {_plane distance _pos > _dis || {isNull _plane || {!canMove _plane}}};
};

//--- Delete plane
if (canMove _plane) then {
	deleteVehicle _plane;
	deleteVehicle _crew;
	deleteGroup _group;
} else {
	[_plane, _crew, _group] spawn {
		scriptName "spawn_modulcas3";
		params ["_plane", "_crew", "_group"];
		sleep 30;
		deleteVehicle _plane;
		deleteVehicle _crew;
		deleteGroup _group;
	};
};

[_side, _logic1, _logic, _topicside, _channel] spawn {
	scriptName "spawn_cas_available";
	params ["_side", "_logic1", "_logic", "_topicside", "_channel"];
	switch (d_arty_unlimited) do {
		case 1: {
			sleep (3);
		};
		case 2: {
			sleep (d_cas_available_time_low);
		};
		default {
			sleep d_cas_available_time;
		};
	};	
	
	d_cas_metadata = [];
	//publicVariable "d_cas_metadata";

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
	if (d_force_isstreamfriendlyui == 1) then {
		_logic1 kbTell [_logic, _topicside, "CASAvailableNoText", _channel];
	} else {
		_logic1 kbTell [_logic, _topicside, "CASAvailable", _channel];
	};
};
