// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
#define __announce \
d_para_available = true; publicVariable "d_para_available"; \
remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated]; \
deleteVehicleCrew _chopper; \
deleteVehicle _chopper; \
{deleteVehicle _x} forEach (_crew select {!isNull _x}); \
deleteMarker #d_drop_marker

#define __del \
deleteVehicle _chopper; \
{deleteVehicle _x} forEach (_crew select {!isNull _x}); \
deleteMarker #d_drop_marker

#define __exit if (!alive _unit || {!alive _chopper || {!canMove _chopper}}) exitWith {[_crew,_chopper] spawn _delete_chop;_may_exit = true}

if (!isServer) exitWith {};

params ["_drop_type", "_drop_pos", "_player"];

__TRACE_3("","_drop_type","_drop_pos","_player")

if (!isNil "_player" && {!isNull _player}) then {
	0 remoteExecCall ["d_fnc_dropansw", _player];
};

private _mname = "d_drop_zone_" + str _player;
[_mname, _drop_pos, "ICON", "ColorBlue", [0.8, 0.8], format [localize "STR_DOM_MISSIONSTRING_1648", name _player], 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
[_mname, "STR_DOM_MISSIONSTRING_1648", name _player] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

_mname spawn {
	scriptName "spawn createdrop";
	sleep 900;
	deleteMarker _this;
};

_drop_pos = [_drop_pos # 0, _drop_pos # 1, 80];

d_para_available = false; publicVariable "d_para_available";
remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];

private _end_pos = call d_fnc_GetRanPointOuterAir;
__TRACE_1("","_end_pos")
private _dstart_pos = call d_fnc_GetRanPointOuterAir;

private _delete_chop = {
	params ["_crew","_chopper"];
	d_para_available = true; publicVariable "d_para_available";
	remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];
	sleep 180 + random 100;
	__del;
};

private _grp = [d_drop_side] call d_fnc_creategroup;
private _spos = [_dstart_pos # 0, _dstart_pos # 1, 300];
private _veca = [_spos, _spos getDir _drop_pos, d_drop_aircraft, _grp, false, true] call d_fnc_spawnVehicle;
_grp deleteGroupWhenEmpty true;
_veca params ["_chopper"];
if (d_with_dynsim == 0) then {
	_chopper setVariable ["d_nodyn", true];
};
addToRemainsCollector [_chopper];
_chopper lock true;
removeAllWeapons _chopper;
["d_drop_marker", _chopper, "ICON", "ColorBlue", [0.5,0.5], localize "STR_DOM_MISSIONSTRING_940", 0, "hd_dot"] call d_fnc_CreateMarkerGlobal;
[_mname, "STR_DOM_MISSIONSTRING_940"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
sleep 0.1;
private _crew = _veca # 1;
{_x setCaptive true} forEach _crew;
private _unit = driver _chopper;

private _wp = _grp addWaypoint [_drop_pos, 0];
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointtype "MOVE";
_wp setWaypointTimeout [0, 0, 0];
_wp setWaypointCompletionRadius 400;
_wp setWaypointForceBehaviour true;

private _vecdist = _chopper distance2D _drop_pos;

//_chopper flyInHeight 100;
#define __dist_to_drop 300
private _may_exit = false;
sleep 12 + random 12;
if (!isNil "_player" && {!isNull _player}) then {
	1 remoteExecCall ["d_fnc_dropansw", _player];
};
private _starttime = time + 300;
private _endtime = time + (((_vecdist / 1000) * 60) + 120);
while {_chopper distance2D _drop_pos > 1000} do {
	sleep 3.512;
	"d_drop_marker" setMarkerPos (getPosWorld _chopper);
	if (time > _endtime) then {
		_chopper setDamage 1;
	};
	__exit;
	if (time > _starttime && {_chopper distance2D _dstart_pos < 500}) exitWith {__announce;_may_exit = true};
};
if (_may_exit) exitWith {
	if (!isNil "_player" && {!isNull _player}) then {
		3 remoteExecCall ["d_fnc_dropansw", _player];
	};
	__del;
};

if (!isNil "_player" && {!isNull _player}) then {
	2 remoteExecCall ["d_fnc_dropansw", _player];
};
_endtime = time + 600;
while {_chopper distance2D _drop_pos > __dist_to_drop} do {
	sleep 0.556;
	"d_drop_marker" setMarkerPos (getPosWorld _chopper);
	if (time > _endtime) then {
		_chopper setDamage 1;
	};
	__exit;
	_unit doMove _drop_pos;
};
if (_may_exit) exitWith {
	if (!isNil "_player" && {!isNull _player}) then {
		3 remoteExecCall ["d_fnc_dropansw", _player];
	};
	__del;
};

[_chopper, _drop_type, _player, _drop_pos, _mname] spawn {
	scriptName "spawn_x_createdrop_spawndrop";
	params ["_chopper", "_drop_type", "_player", "_drop_pos", "_mname"];
	
	sleep 1.512;
	private _vec = objNull;
	private _is_ammo = false;
	private _para = objNull;
	private _chopposx = getPos _chopper;
	_chopposx set [2, (_chopposx # 2) - 10];
	if (_drop_type isKindOf "ReammoBox_F") then {
		_is_ammo = true;
		_para = createVehicle [d_cargo_chute, _chopposx, [], 0, "FLY"];
		_para allowDamage false;
		_para setPos _chopposx;
		_para setVelocity (velocity _chopper);
	} else {
		_vec = createVehicle [_drop_type, _chopposx, [], 0, "NONE"];
		_vec setPos _chopposx;
		_para = createVehicle [d_cargo_chute, _chopposx, [], 0, "FLY"];
		_para allowDamage false;
		_para setPos _chopposx;
		_vec attachTo [_para, [0,0,0]];
		_para setVelocity (velocity _chopper);
		addToRemainsCollector [_vec];
	};
	[_vec, _drop_pos, d_drop_radius, _drop_type, _para, _is_ammo, _this # 3] spawn d_fnc_mando_chute;
	
	if (!isNil "_player" && {!isNull _player}) then {
		4 remoteExecCall ["d_fnc_dropansw", _player];
	};
};
sleep 30;
while {_chopper distance2D _end_pos > 600} do {
	sleep 3.14;
	"d_drop_marker" setMarkerPos (getPosWorld _chopper);
	if (time > _endtime) then {
		_chopper setDamage 1;
	};
	__exit;
	_unit doMove _end_pos;
};

_drop_pos = nil;

sleep 0.512;

_starttime = time + 300;

while {time < _starttime && {canMove _chopper && {_chopper distance2D _end_pos > 600}}} do {
	"d_drop_marker" setMarkerPos (getPosWorld _chopper);
	sleep 3.7;
};

__announce;
