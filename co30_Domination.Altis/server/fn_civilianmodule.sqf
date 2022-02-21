//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_trg_center", "_radius"];

private _civModuleSetVars = {
	_this setVariable ["#capacity",5];
	_this setVariable ["#usebuilding",true];
	_this setVariable ["#terminal",false];
	//_m1 setVariable ["#type",5];
};

if (isNil "d_cur_tgt_civ_modules_presencesafespot") then {
	d_cur_tgt_civ_modules_presencesafespot = [];
};

if (isNil "d_cur_tgt_civ_modules_presenceunit") then {
	d_cur_tgt_civ_modules_presenceunit = [];
};

if (isNil "d_cur_tgt_civ_units") then {
	d_cur_tgt_civ_units = [];
};
if (isNil "d_cur_tgt_civ_modules_presence") then {
	d_cur_tgt_civ_modules_presence = [];
};

private _civ_units_count_max = 100; // default (recalculated if adaptive settings are selected)

private _buildings_unfiltered = [_trg_center, _radius] call d_fnc_getbldgswithpositions;

private _buildings = _buildings_unfiltered select { !(getModelInfo _x # 0 in d_object_spawn_civ_blacklist) };

diag_log [format ["total possible buildings to spawn civs: %1", count (_buildings)]];

private _total_civs_count_created = 0;

//create a cluster of civilians (does not use civilian module)
private _placeCivilianCluster = {
	diag_log ["attempting to place a civilian cluster..."];
	if (count _buildings < 1) exitWith {
		diag_log ["unable to place civilian cluster, no buildings in array"];
	};
	if (_total_civs_count_created > _civ_units_count_max) exitWith {
		diag_log [format ["unable to place civilian cluster, %1 civs created and the max is %2", _total_civs_count_created, _civ_units_count_max]];
	};
	_grp = _this # 0;
	_bldg = selectRandom _buildings;
	_buildings deleteAt (_buildings find _bldg);
	// check if selected building is a mission objective
	if ([_bldg] call d_fnc_ismissionobjective) exitWith {
		diag_log ["unable to place civilian cluster, randomly chose a building that is a mission objective"];
	};
	// do not create the civ cluster if any buildings within a 75m radius are also mission objectives
	private _mustExit = false;
	{
		if ([_x] call d_fnc_ismissionobjective) exitWith {
			_mustExit = true;
		};
	} forEach ([_bldg, 75] call d_fnc_getbldgswithpositions);
	if (_mustExit == true) exitWith {
		diag_log ["unable to place civilian cluster, randomly chose a building that is too close to a mission objective"];
	};
	_posArray = (_bldg buildingPos -1) - d_cur_tgt_building_positions_occupied; // remove positions already used
	_unit_count = 2 max floor(random (count _posArray));
	if (count _posArray > 5 && {1 > random 13}) then {
		// small chance for larger buildings (more than 5 positions) to have many civs
		diag_log ["randomly chose to spawn a large civilian group"];
		_unit_count = count _posArray - 1;
	};
	for "_i" from 0 to _unit_count do {
		if (_posArray isEqualTo []) exitWith {};
		_randomPos = selectRandom _posArray;
		d_cur_tgt_building_positions_occupied pushBack _posArray;
		_posArray deleteAt (_posArray find _randomPos);
		_randomPosTerrain = [_randomPos # 0, _randomPos # 1, (_randomPos # 2) + (getTerrainHeightASL _randomPos)];
		_civAgent = createAgent [selectRandomWeighted d_civArray, _randomPosTerrain, [], 0, "NONE"];
		_total_civs_count_created = _total_civs_count_created + 1;
		if (random 2 <= 1) then {
			if (random 2 <= 1) then {
				[_civAgent, "SIT_LOW"] call BIS_fnc_ambientAnim;
			} else {
				_civAgent setUnitPos "MIDDLE";
			};
		};
		_civAgent addEventHandler ["FiredNear", {
			params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
			if (_distance < 30) then {
				if (((animationState _unit) find "sit") > 0) then {
					_unit call BIS_fnc_ambientAnim__terminate;
				};
				if (_distance < 10) then {
					_unit setUnitPos "DOWN";
				} else {
					_unit setUnitPos "MIDDLE";
				};
				_unit setVariable ["civ_last_firednear_or_threatened", time];
			};
		}];
		d_cur_tgt_civ_units pushBack _civAgent;
		if (d_ai_persistent_corpses == 0) then {
			// civ corpses are removed when civ module is deleted
			removeFromRemainsCollector [_this];
		};
		_civAgent addEventHandler ["Killed", {
			call d_fnc_civmodulekilleh;
		}];
		[_civAgent, selectRandom d_civ_faces] remoteExec ["setIdentity", 0, _civAgent];
	};
	diag_log ["civilian cluster successfully created"];
};

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "placing civilians"];

_target_name = d_target_names select d_current_target_index;
_marker_name = format ["d_target_%1", d_current_target_index];
#endif

__TRACE_1("","_this")
__TRACE_1("","d_current_target_index")
__TRACE_1("","_target_name")
__TRACE_1("","_marker_name")

private _civ_grp_count = d_civ_groupcount;
private _civ_spawn_factor = 0; // determines number of static civs in houses
if (d_civ_groupcount < 0) then {
	if (d_civ_groupcount == -1) then {
		_civ_spawn_factor = 0.15;  // adaptive (low)
	};
	if (d_civ_groupcount == -2) then {
		_civ_spawn_factor = 0.25;  // adaptive (normal)
	};
	if (d_civ_groupcount == -3) then {
		_civ_spawn_factor = 0.40;  // adaptive (high)
	};
	if (d_civ_groupcount == -4) then {
		_civ_spawn_factor = 0.65;  // adaptive (very high)
	};
	if (d_civ_groupcount == -5) then {
		_civ_spawn_factor = 0.90;  // adaptive (extreme)
	};
	private _bldg_count = count ([_trg_center, _radius] call d_fnc_getbldgswithpositions);
	private _civ_grp_count_max = floor(_civ_spawn_factor * 100); // sanity check, avoid spawning too many civ groups
	private _civ_units_count_max = floor(_civ_grp_count_max * 3.5); // sanity check, avoid spawning too many civ units 
	_civ_grp_count = floor (_bldg_count * _civ_spawn_factor) min _civ_grp_count_max;
	diag_log [format ["civilian bldg_count: %1, civ_grp_count: %2", _bldg_count, _civ_grp_count]];
};

// create civilians with createAgent (not the civilian module)
// these civilians do not run around, they stand/sit/kneel and when firedNear is triggered they lay down
for "_i" from 0 to _civ_grp_count do {
#ifdef __DEBUG__
	diag_log [diag_frameno, diag_ticktime, time, format ["civilian for loop, group count _i: %1", _i]];
#endif
	_randomPos = [[[_trg_center, 200]],[]] call BIS_fnc_randomPos;
	_grp = createGroup [civilian, true];

	__TRACE("Placing a civilian cluster...")
	[_grp] call _placeCivilianCluster;
};

diag_log [format ["total static civs created: %1", _total_civs_count_created]];

// create civilian module and use the module to spawn moving civilians (walking/running)
// only create one module and a few civilians, too many moving civilians are distracting
_grp_civmodule = createGroup [civilian, true];

_ms1 = _grp_civmodule createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,_radius] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
_ms1 call _civModuleSetVars;
d_cur_tgt_civ_modules_presencesafespot pushBack _ms1;
__TRACE_1("","_ms1")

_ms2 = _grp_civmodule createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,_radius] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
_ms2 call _civModuleSetVars;
d_cur_tgt_civ_modules_presencesafespot pushBack _ms2;
__TRACE_1("","_ms2")

_ms3 = _grp_civmodule createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,_radius] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
_ms3 call _civModuleSetVars;
d_cur_tgt_civ_modules_presencesafespot pushBack _ms3;
__TRACE_1("","_ms3")

_mu1 = _grp_civmodule createUnit ["ModuleCivilianPresenceUnit_F", position nearestBuilding ([[[_trg_center, [0,_radius] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
d_cur_tgt_civ_modules_presenceunit pushBack _mu1;
__TRACE_1("","_mu1")

_mu2 = _grp_civmodule createUnit ["ModuleCivilianPresenceUnit_F", position nearestBuilding ([[[_trg_center, [0,_radius] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
d_cur_tgt_civ_modules_presenceunit pushBack _mu2;
__TRACE_1("","_mu2")

private _m = _grp_civmodule createUnit ["ModuleCivilianPresence_F", [0,0,0], [], 0, "NONE"];

d_cur_tgt_civ_modules_presence pushBack _m;

//_m setVariable ["#debug", true]; // Debug mode on

_m setVariable ["#area", [_trg_center, 1000, 1000, 0, true, -1]];  // Fixed! this gets passed to https://community.bistudio.com/wiki/inAreaArray
_m setVariable ["#useagents", true];
_m setVariable ["#usepanicmode", false];
_m setVariable ["#unitcount", d_civ_unitcount];
_m setVariable ["#onCreated", {
	d_cur_tgt_civ_units pushBack _this;
	if (d_ai_persistent_corpses == 0) then {
		// civ corpses are removed when civ module is deleted
		removeFromRemainsCollector [_this];
	};
	_this addEventHandler ["Killed", {
		call d_fnc_civmodulekilleh;
	}];
	_this setVariable ["civ_is_walking", true];
	_this addEventHandler ["FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		if (_distance < 35) then {
			_unit setVariable ["civ_last_firednear_or_threatened", time];
			_unit forceSpeed 0;
			if (_distance < 15) then {
				_unit setUnitPos "DOWN";
			};
		};
	}];
	[_this, selectRandom d_civ_faces] remoteExec ["setIdentity", 0, _this];
	_this setUnitLoadout selectRandomWeighted d_civArray;
}];
