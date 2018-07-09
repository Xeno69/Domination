// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideobjects.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if !(call d_fnc_checkSHC) exitWith {};

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
// TODO better position finding 
// _poss = _vec modeltoWorld [18, 0, 0];
// _poss set [2,0];
{
	private _nnextpos = _poss findEmptyPosition [30, 70, _x];
	if !(_nnextpos isEqualTo []) then {_poss = _nnextpos};
	private _vec = createVehicle [_x, _poss, [], 0, "NONE"];
	_vec allowDamage false;
    _vec spawn {sleep 5; _this allowDamage true};
	_vec setDir _dir;
	_vec setPos _poss;
	if (_dovup) then {
		_vec setVectorUp [0,0,1];
	};
	if (_dolock) then {
		_vec lock true;
	};
	_vecs pushBack _vec;
	_vec addEventHandler ["handleDamage", {_this call d_fnc_CheckSMShotHD}];
	d_x_sm_vec_rem_ar pushBack _vec;
	if (_camo) then {
		sleep 0.25;
		_camov = createVehicle [d_sm_camo_net, getPos _vec, [], 0, "NONE"];
		_camov allowDamage false;
		_camov setDir (direction _vec) + 180;
		_camov setPos (getPos _vec);
		_camov spawn {sleep 5; _this allowDamage true};
		d_x_sm_vec_rem_ar pushBack _camo;
		_camov addEventhandler ["killed", {deleteVehicle (param [0])}];
	};
	sleep 1;
} forEach _usevecs;

if (_createarmor) then {
	__TRACE("Creating armor")
	sleep 2.22;
	[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 1;
	["stat_mg", 1, "stat_gl", 1, "", 0, _poss, 1, 100, false] spawn d_fnc_CreateArmor;
};
if (_createinf) then {
	sleep 2.123;
	__TRACE("Creating inf")
	["specops", 2, "allmen", (floor (random 4)) min 2, _poss, 300, true] spawn d_fnc_CreateInf;
};

sleep 2;

while {{alive _x} count _vecs > 0} do {
	sleep 3;
};

d_sm_winner = 2;

d_sm_resolved = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};
