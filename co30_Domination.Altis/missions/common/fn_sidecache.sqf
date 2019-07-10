//#define __DEBUG__
#define THIS_FILE "fn_sidecache.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_poss", ["_createarmor", false], ["_createinf", false]];

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
	["specops", 2, "allmen", (floor (random 4)) min 2, _poss, 150, true] spawn d_fnc_CreateInf;
};

private _houseArray = (nearestTerrainObjects [_poss, ["House"], 150, false, true]) select {getDammage _x < 0.4};
private _created = false;
private _cache = objNull;

while {!_created} do {
    private _idx = floor random count _houseArray;
	private _house = _houseArray select _idx;
	private	_pos = [_house] call bis_fnc_buildingPositions;
	_houseArray deleteAt _idx;
	__TRACE_1("","_pos")
	if !(_pos isEqualTo []) then {
		_pos = _pos select floor random count _pos;
		_pos set [2, (_pos select 2) + 0.2];
		__TRACE_1("","_pos")
		_cache = createVehicle [selectRandom d_sm_cache, _pos, [], 0, "NONE"];
		_cache setPos _pos;
		_cache setDir ceil random 360;
		__TRACE_1("","_cache")
		if (!isNull _cache) then {
			_cache call d_fnc_addKilledEHSM;
			_created = true;
#ifdef __DEBUG__
			[format["cache_%1",_cache], _pos,"ICON","ColorBlack",[0.5,0.5],"Cache",0,"n_Ordnance"] call d_fnc_CreateMarkerGlobal;
#endif
			clearWeaponCargoGlobal _cache;
		};
	};
	sleep 1;
};

private _num_mines = (floor (random 15)) max 10;

for "_i" from 0 to (_num_mines - 1) do {
	private _idx = floor random count _houseArray;
	private _house = _houseArray select _idx;
	private	_pos_b = [_house] call bis_fnc_buildingPositions;
	_houseArray deleteAt _idx;
	if !(_pos_b isEqualTo []) then {
		_pos_b = _pos_b select floor random count _pos_b;
		_pos_b set [2,(_pos_b select 2) + 0.01];
		private _mine = createMine [selectRandom ["APERSBoundingMine","APERSTripMine","APERSMine"], _pos_b, [], 0];
		d_side_enemy revealMine _mine;
		d_x_sm_vec_rem_ar pushBack _mine;
#ifdef __DEBUG__
		[format["mines_%1",_mine], _mine,"ICON","ColorWhite",[0.5,0.5],"Mine",0,"Minefield"] call d_fnc_CreateMarkerGlobal;
#endif
	};
};

private _cache_dest = false;
private _endtime = time + 2000;

while {true} do {
	if (isMultiplayer && {(call d_fnc_PlayersNumber) == 0}) then {
		_endtime = _endtime - time;
		waitUntil {sleep (1.012 + random 1); (call d_fnc_PlayersNumber) > 0};
		_endtime = time + _endtime;
	};
	sleep 0.1;
	if (time > _endtime) exitWith {
		_cache_dest = true;
		if (!isNull _cache) then {
			_cache removeAllEventHandlers "killed";
			_cache removeAllEventHandlers "handleDamage";
			deleteVehicle _cache;
		};
	};
	sleep 5.123;
	if (d_sm_resolved) exitWith {};
};

if (!d_sm_resolved) then {
	if (_cache_dest) then {
		d_sm_winner = -2;
	};
	d_sm_resolved = true;
};
