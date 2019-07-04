// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sidetransferdata.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_poss", ["_dir", 0], ["_dovup", true], ["_createarmor", false], ["_createinf", false]];

private _smvec = createVehicle ["Land_DataTerminal_01_F", _poss, [], 0, "NONE"];
_smvec allowDamage false;
_smvec setDir _dir;
_smvec setPos _poss;
if (_dovup) then {
	_smvec setVectorUp [0,0,1];
};

d_data_was_send = false;
publicVariable "d_data_was_send";
_smvec remoteExecCall ["d_fnc_addactionstd", [0, -2] select isDedicated, _smvec];

d_x_sm_vec_rem_ar pushBack _smvec;

if (_createarmor) then {
sleep 2.22;
	__TRACE("Creating armor")
	[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 1;
	["stat_mg", 1, "stat_gl", 1, "", 0, _poss, 1, 100, false] spawn d_fnc_CreateArmor;
};

if (_createinf) then {
	sleep 2.123;
	__TRACE("Creating inf")
	["specops", 2, "allmen", (floor (random 4)) min 2, _poss, 300, true] spawn d_fnc_CreateInf;
};

while {!d_data_was_send && {alive _smvec && {!d_sm_resolved}}} do {
	sleep 2.5;
};

if (!alive _smvec) then {
	d_sm_winner = -1000;
} else {
	d_sm_winner = 2;
};

d_sm_resolved = true;
