// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
#define __del \
deleteVehicleCrew _vec; \
deleteVehicle _vec; \
deleteVehicle (_crew select {!isNull _x});

if (!isServer) exitWith {};

d_heli_taxi_available = false;
publicVariable "d_heli_taxi_available";

sleep 5;

params ["_callernetid", "_playerpos", "_destination", "_ttype"];

__TRACE_1("","_this")

private _player = [player , objectFromNetId _callernetid] select isMultiplayer;
__TRACE_1("","_player")
if (isNil "_player" || {isNull _player}) exitWith {
	d_heli_taxi_available = true;
	publicVariable "d_heli_taxi_available";
	-1 remoteExecCall ["d_fnc_ataxiNet", [0, -2] select isDedicated];
};

7 remoteExecCall ["d_fnc_ataxiNet", _player];

private _sidep = side (group _player);

private _dstart_pos = call d_fnc_GetRanPointOuterAir;

__TRACE_2("","_sidep","_dstart_pos")

private _grp = [_sidep] call d_fnc_creategroup;
private _spos = [_dstart_pos # 0, _dstart_pos # 1, 300];
private _veca = [_spos, _spos getDir _playerpos, _ttype, _grp, false, true] call d_fnc_spawnVehicle;
_veca params ["_vec", "_crew"];
if (d_with_dynsim == 0) then {
	_vec setVariable ["d_nodyn", true];
};
private _unit = driver _vec;
addToRemainsCollector [_vec];
_unit setSkill 1;
_vec allowDamage false;
_unit allowDamage false;

d_airtaxi_driver = _unit;
_unit setVariable ["d_type", _ttype];

_vec lockDriver true;

{_x setCaptive true} forEach _crew;

private _pospl =+ _playerpos;
_pospl set [2,0];
private _helperh = d_HeliHEmpty createVehicle [0,0,0];
_unit setVariable ["d_hempty", _helperh];
200 remoteExecCall ["d_fnc_ataxiNet", _player];
private _nendpos = _playerpos findEmptyPosition [10, 200, _ttype];
if (_nendpos isNotEqualTo []) then {_nendpos = _playerpos};
_unit doMove _nendpos;
_helperh setVehiclePosition [_nendpos, [], 0, "NONE"];
_vec flyInHeight 80;
_vec flyInHeightASL [80,80,80];
_grp setBehaviourStrong "CARELESS";

_unit action ["CollisionLightOn", _vec];
if (sunOrMoon != 1) then {_vec setPilotLight true};
_vec setCollisionLight true;

["d_airtaxi_marker", _vec, "ICON", (switch (_sidep) do {case opfor: {"ColorEAST"};case blufor: {"ColorWEST"};case independent: {"ColorGUER"};default {"ColorCIV"};}), [1,1], localize "STR_DOM_MISSIONSTRING_535", 0, (switch (_sidep) do {case blufor: {"b_air"};case opfor: {"o_air"};default {"n_air"};})] call d_fnc_CreateMarkerGlobal;
["d_airtaxi_marker", "STR_DOM_MISSIONSTRING_535"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

private _vecdist = _vec distance2D _nendpos;
__TRACE_1("","_vecdist")

sleep 10;

_player = [player , objectFromNetId _callernetid] select isMultiplayer;
if (isNil "_player" || {isNull _player}) exitWith {
	deleteMarker "d_airtaxi_marker";
	d_heli_taxi_available = true;
	publicVariable "d_heli_taxi_available";
	-1 remoteExecCall ["d_fnc_ataxiNet", [0, -2] select isDedicated];
	deleteVehicle _helperh;
	sleep 120;
	__del;
};

if (!alive _player) exitWith {
	d_heli_taxi_available = true;
	publicVariable "d_heli_taxi_available";
	deleteMarker "d_airtaxi_marker";
	1 remoteExecCall ["d_fnc_ataxiNet", _player];
	deleteVehicle _helperh;
	sleep 120;
	__del;
};

0 remoteExecCall ["d_fnc_ataxiNet", _player];

private _toldp = false;
private _endtime = time + (((_vecdist / 1000) * 60) + 120);
private _checkdist = if !(_vec isKindOf "VTOL_Base_F") then {1000} else {1500};
__TRACE_2("","time","_endtime")
private _doend = false;
while {alive _unit && {alive _vec && {canMove _vec}}} do {
	"d_airtaxi_marker" setMarkerPos (getPosWorld _vec);
	_player = [player , objectFromNetId _callernetid] select isMultiplayer;
	__TRACE_1("","_player")
	if (time > _endtime || {isNil "_player" || {isNull _player}}) exitWith {
		_doend = true;
		__TRACE("End 1")
	};
	if (!_toldp && {_vec distance2D _helperh < _checkdist && {alive _player}}) then {
		6 remoteExecCall ["d_fnc_ataxiNet", _player];
	        private _signal = if (sunOrMoon != 1) then {"NVG_TargetC"} else {"SmokeShellGreen"};
		private _smoke = _signal createVehicle _nendpos;
		_toldp = true;
	};
	if (unitReady _unit) exitWith {
		sleep 0.1;
		_vec land "LAND";
		__TRACE("End 2")
	};
	sleep 1.012;
};

if (!alive _unit || {!alive _vec || {!canMove _vec || {_doend}}}) exitWith {
	__TRACE("End 3")
	__TRACE_3("","alive _unit","alive _vec","canMove _vec")
	__TRACE_1("","_doend")
	deleteMarker "d_airtaxi_marker";
	d_heli_taxi_available = true;
	publicVariable "d_heli_taxi_available";
	_player = [player , objectFromNetId _callernetid] select isMultiplayer;
	if (!isNil "_player" && {!isNull _player}) then {
		2 remoteExecCall ["d_fnc_ataxiNet", _player];
	} else {
		-1 remoteExecCall ["d_fnc_ataxiNet", [0, -2] select isDedicated];
	};
	deleteVehicle _helperh;
	sleep 120;
	__del;
};

_endtime = time + 120;
"d_airtaxi_marker" setMarkerPos (getPosWorld _vec);
while {alive _unit && {alive _vec && {alive _player && {!(_player in crew _vec) && {canMove _vec}}}}} do {
	if (time > _endtime) exitWith {};
	sleep 1.012;
};
_doend = false;
if (alive _unit && {alive _vec && {canMove _vec}}) then {
	_player = [player , objectFromNetId _callernetid] select isMultiplayer;
	if (!isNil "_player" && {!isNull _player}) then {
		3 remoteExecCall ["d_fnc_ataxiNet", _player];
	};

	sleep 30 + random 5;
	_player = [player , objectFromNetId _callernetid] select isMultiplayer;
	if (!isNil "_player" && {!isNull _player}) then {
		5 remoteExecCall ["d_fnc_ataxiNet", _player];
	};
	_vec flyInHeight 80;
	_nendpos = _unit getVariable "d_newdest";
	if (isNil "_nendpos") then {
		_nendpos = _destination findEmptyPosition [10, 200, _ttype];
		if (_nendpos isNotEqualTo []) then {_nendpos = _destination};
	};
	_unit doMove _nendpos;
	_unit setVariable ["d_isondestway", true];
	_helperh setVehiclePosition [_nendpos, [], 0, "NONE"];
	_vec flyInHeight 80;
	_vec flyInHeightASL [80,80,80];
	_grp setBehaviourStrong "CARELESS";
	sleep 5;
	_doend = false;
	while {alive _unit && {alive _vec && {canMove _vec}}} do {
		"d_airtaxi_marker" setMarkerPos (getPosWorld _vec);
		if (unitReady _unit) exitWith {
			sleep 0.1;
			_vec land "LAND";
		};
		if (!alive _unit || {!alive _vec || {!canMove _vec}}) exitWith {
			_doend = true;
			_player = [player , objectFromNetId _callernetid] select isMultiplayer;
			if (!isNil "_player" && {!isNull _player}) then {
				2 remoteExecCall ["d_fnc_ataxiNet", _player];
			};
			deleteMarker "d_airtaxi_marker";
			d_heli_taxi_available = true;
			publicVariable "d_heli_taxi_available";
			sleep 120;
			__del;
		};
		sleep 2.012
	};
	if (_doend) exitWith {};

	_endtime = time + 820;
	while {alive _unit && {alive _vec && {alive _player && {(_player in crew _vec) && {canMove _vec}}}}} do {
		sleep 3.221;
		if (time > _endtime) exitWith {};
	};
	sleep 20 + random 5;

	if (alive _unit && {alive _vec && {canMove _vec}}) then {
		_player = [player , objectFromNetId _callernetid] select isMultiplayer;
		if (!isNil "_player" && {!isNull _player}) then {
			4 remoteExecCall ["d_fnc_ataxiNet", _player];
		};
		__TRACE("Unit moving to endpos")
		_unit doMove _dstart_pos;
		_vec flyInHeight 80;
		_grp setBehaviourStrong "CARELESS";
		_endtime = time + 720;
		while {alive _unit && {alive _vec && {canMove _vec}}} do {
			"d_airtaxi_marker" setMarkerPos (getPosWorld _vec);
			__TRACE_1("","_vec distance2D _dstart_pos")
			if (_vec distance2D _dstart_pos < 800) exitWith {};
			if (time > _endtime) exitWith {
				__TRACE("time > _endtime")
			};
			__TRACE_1("","unitReady _unit")
			if (unitReady _unit) exitWith {
				__TRACE("unit ready")
			};
			sleep 2.012
		};
		deleteMarker "d_airtaxi_marker";
		d_heli_taxi_available = true;
		publicVariable "d_heli_taxi_available";
		__del;
	} else {
		_player = [player , objectFromNetId _callernetid] select isMultiplayer;
		if (!isNil "_player" && {!isNull _player}) then {
			1 remoteExecCall ["d_fnc_ataxiNet", _player];
		};
		deleteMarker "d_airtaxi_marker";
		d_heli_taxi_available = true;
		publicVariable "d_heli_taxi_available";
		sleep 120;
		__del;
	};
} else {
	_player = [player , objectFromNetId _callernetid] select isMultiplayer;
	if (!isNil "_player" && {!isNull _player}) then {
		1 remoteExecCall ["d_fnc_ataxiNet", _player];
	};
	deleteMarker "d_airtaxi_marker";
	d_heli_taxi_available = true;
	publicVariable "d_heli_taxi_available";
	sleep 120;
	__del;
};

deleteVehicle (_crew select {!isNull _x});

deleteVehicle _helperh;

__TRACE("END")
