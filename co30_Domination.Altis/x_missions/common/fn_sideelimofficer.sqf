// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sideelimofficer.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if !(call d_fnc_checkSHC) exitWith {};

params ["_poss", "_dir", "_type", ["_issniper", false], ["_createarmor", false], ["_createinf", false]];

private ["_fortress"];
if (!_issniper) then {
	_fortress = createVehicle [d_sm_fortress, _poss, [], 0, "NONE"];
	_fortress setDir _dir;
	_fortress setPos _poss;
	d_x_sm_vec_rem_ar pushBack _fortress;
	sleep 2.123;
} else {
	_poss = [_poss, 150] call d_fnc_GetRanPointCircle;
};
private _ogroup = [d_side_enemy] call d_fnc_creategroup;
private _sm_vec = _ogroup createUnit [_type, _poss, [], 0, "NONE"];
[_sm_vec] joinSilent _ogroup;
_ogroup deleteGroupWhenEmpty true;
_sm_vec call d_fnc_removenvgoggles_fak;
_sm_vec call d_fnc_addkillednormal;
d_x_sm_rem_ar pushBack _sm_vec;
sleep 2.123;
if (!_issniper) then {
	private _bpos = getPosATL _fortress;
	_bpos set [2, 1];
	_sm_vec setFormDir ((direction _fortress) + 90);
	_sm_vec setPos _bpos;
} else {
	_poss set [2, 0];
	[_sm_vec, _poss] call d_fnc_setposagls;
};
sleep 1;
private _leadero = leader _ogroup;
_leadero setRank "COLONEL";
_ogroup allowFleeing 0;
if (!_issniper) then {
	_ogroup setBehaviour "AWARE";
} else {
	_ogroup setBehaviour "CARELESS";
};
if (!_issniper) then {
	_leadero disableAI "PATH";
};
if (d_with_dynsim == 0) then {
	_sm_vec enableDynamicSimulation true;
};
if (_createarmor) then {
	sleep 2.123;
	[selectRandom ["aa", "tank", "tracked_apc"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, _poss, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 1;
	["stat_mg", 1, "stat_gl", 1, "", 0, _poss, 1, 100, false] spawn d_fnc_CreateArmor;
};
if (_createinf) then {
	sleep 2.123;
	["specops", 2, "allmen", (random 4) min 2, _poss, 200, true] spawn d_fnc_CreateInf;
};
