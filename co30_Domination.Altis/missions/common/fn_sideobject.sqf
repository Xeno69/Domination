// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideobject.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if !(isServer) exitWith {};

params ["_poss", "_type", ["_dir", 0], ["_dovup", true], ["_dolock", false], ["_killnormal", false], ["_createarmor", false], ["_createinf", false]];

private _vec = createVehicle [_type, _poss, [], 0, "NONE"];
_vec setDir _dir;
//_vec setPos _poss;
_vec setVehiclePosition [getPosWorld _vec, [], 0, "CAN_COLLIDE"];
if (_dovup) then {
	_vec setVectorUp [0,0,1];
};
if (_dolock) then {
	_vec lock true;
};
if (_killnormal) then {
	_vec call d_fnc_addkillednormal;
} else {
	_vec call d_fnc_addKilledEHSM;
};
d_x_sm_vec_rem_ar pushBack _vec;
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

if (_type == "Land_Device_assembled_F") then {
	_poss spawn d_fnc_doquake;
};
