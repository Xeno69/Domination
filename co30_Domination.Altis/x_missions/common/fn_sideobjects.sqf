// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideobjects.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if !(call d_fnc_checkSHC) exitWith {};

params ["_poss", "_types", ["_dovup", true], ["_dolock", false], ["_createarmor", false], ["_createinf", false]];

private _vecs = [];
{
	private _nnextpos = _poss findEmptyPosition [30, 70, _x];
	if !(_nnextpos isEqualTo []) then {_poss = _nnextpos};
	private _vec = createVehicle [_x, _poss, [], 0, "NONE"];
	_vec setDir (random 360);
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
	sleep 1;
} forEach _types;

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
