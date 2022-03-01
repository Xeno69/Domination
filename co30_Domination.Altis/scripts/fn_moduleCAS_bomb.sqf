//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_target", "_caller", "_wtype"];

__TRACE_1("","_this")

private _callero = [player, objectFromNetId _caller] select isMultiplayer;
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
_logic1 kbTell [_callero, _topicside, "CASOnTheWay", _channel];
sleep 1;
_logic1 kbTell [_logic, _topicside, "CASUnavailable", _channel];

private "_bomb";
private _altitude = 500;
if (_wtype == 0) then {
	_bomb = "Bomb_04_F";
	sleep (2 max random 5);
};
if (_wtype == 1) then {
	_bomb = "M_Scalpel_AT"; // todo
	sleep 1;
};

#ifdef __VN__
// default bomb type for SOG
if (_wtype == 0) then {
	_bomb = "vn_bomb_500_mk82_he_ammo";
	sleep (2 max random 5);
};
if (_wtype == 2) then {
	// napalm
	_bomb = "vn_bomb_500_blu1b_fb_ammo";
	sleep (2 max random 5);
};
if (_wtype == 3) then { 
	_bomb = "vn_bomb_15000_blu82_dc_ammo"; // todo
	sleep (2 max random 5);
};
#endif

private _callerpos = getPos _callero;

private _logico = d_HeliHEmpty createVehicle [10,10,10];
_logico setPos _target;
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
private _wpcmls = ["countermeasureslauncher"];
private _currentWeapons = weapons _plane;
{
	if !(toLowerANSI ((_x call bis_fnc_itemType) # 1) in _wpcmls) then {
		_plane removeWeapon _x;
	};
} forEach _currentWeapons;

//--- Approach
private _fire = [] spawn {
	scriptName "spawn_modulcas";
	waitUntil {false}
};
private _fireNull = true;
private _atime = time;
private _offset = 0;

d_cas_metadata = [_plane, _planePos, _pos, _offset, _velocity, _vectorDir, _vectorUp, _atime, _duration];
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
		d_cas_metadata = [_plane, _planePos, _pos, _offset, _velocity, _vectorDir, _vectorUp, _atime, _duration];

	};

	//--- Fire!
	if (_fireNull && {(getPosAsl _plane) distance _pos < 400}) then {
		_fireNull = false;
		terminate _fire;
		private _start_pos = (getPos _plane) vectorAdd [0, 0, -2];
		__TRACE_2("","_start_pos","getPos _plane")
		[_target, _start_pos, _bomb, _altitude, _callero] spawn d_fnc_moduleCAS_guidedmissile;
		_fire = [_plane] spawn {
			scriptName "spawn_modulcas2";
			params ["_plane"];
			private _atime = time + 0.5;
			waitUntil {
				_plane setVariable ["fireProgress", 1];
				sleep 0.01;
				(time > _atime || {isNull _plane || {!canMove _plane}})
			};
			sleep 0.5;
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
	if (d_arty_unlimited == 1) then {
		sleep 3;
	} else {
		sleep d_cas_available_time;
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
	_logic1 kbTell [_logic, _topicside, "CASAvailable", _channel];
};
