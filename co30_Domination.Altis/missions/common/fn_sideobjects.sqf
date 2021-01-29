// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideobjects.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if !(isServer) exitWith {};

params ["_poss", ["_dir", 0], "_types", ["_dovup", true], ["_dolock", false], ["_createarmor", false], ["_createinf", false], ["_random", false], ["_camo", false]];

private _vecs = [];
private _usevecs = [];
if (!_random) then {
	_usevecs = _types;
} else {
	for "_i" from 1 to count _types do {
		_usevecs pushBack selectRandom _types;
	};
};

private _vec = objNull;
{
	if (isNull _vec) then {
		private _nnextpos = _poss findEmptyPosition [0, 70, _x];
		__TRACE_1("null vec","_nnextpos")
		if (_nnextpos isNotEqualTo []) then {_poss = _nnextpos};
	} else {
		private _nnextpos = [];
		private _maxdist = 100;
		private _counter = 0;
		while {_nnextpos isEqualTo [] && {_counter < 100}} do {
			_nnextpos = (getPos _vec) findEmptyPosition [20, _maxdist, _x];
			_maxdist = _maxdist + 20;
			_counter = _counter + 1;
			sleep 0.1;
		};
		__TRACE_1("vec ok","_nnextpos")
		if (_nnextpos isNotEqualTo []) then {_poss = _nnextpos};
	};
	_vec = createVehicle [_x, _poss, [], 0, "NONE"];
	_vec allowDamage false;
    _vec spawn {
		scriptName "spawn_sideobjects1";
		sleep 5; _this allowDamage true;
	};
	_vec setDir _dir;
	_vec setPos _poss;
	if (_dovup) then {
		_vec setVectorUp [0,0,1];
	};
	if (_dolock) then {
		_vec lock true;
	};
	_vecs pushBack _vec;
	d_x_sm_vec_rem_ar pushBack _vec;
	_vec addEventHandler ["handleDamage", {call d_fnc_CheckSMShotHD}];
	d_x_sm_vec_rem_ar pushBack _vec;
	if (_camo) then {
		sleep 0.25;
		private _camonet = createVehicle [d_sm_camo_net, getPos _vec, [], 0, "NONE"];
		_camonet allowDamage false;
		_camonet setDir (direction _vec) + 180;
		_camonet setPos (getPos _vec);
		_camonet spawn {
			scriptName "spawn_sideobjects2";
			sleep 5; _this allowDamage true;
		};
		d_x_sm_vec_rem_ar pushBack _camonet;
		_camonet addEventhandler ["killed", {deleteVehicle (_this # 0)}];
	};
	sleep 1;
} forEach _usevecs;

if (_createarmor) then {
	__TRACE("Creating armor")
	sleep 2.22;
	[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 1, selectRandom ["jeep_mg", "jeep_gl"], 2, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 1;
	["stat_mg", 1, "stat_gl", 1, "", 0, _poss, 1, 100, false] spawn d_fnc_CreateArmor;
};
if (_createinf) then {
	sleep 2.123;
	__TRACE("Creating inf")
	["specops", 2, "allmen", (floor (random 3)) min 1, _poss, 300, true] spawn d_fnc_CreateInf;
};

sleep 2;

while {!d_sm_resolved && {{alive _x} count _vecs > 0}} do {
	sleep 3;
};

d_sm_winner = 2;

d_sm_resolved = true;
