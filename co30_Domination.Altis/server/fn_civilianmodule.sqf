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

d_civArray = [
	"C_man_1",
	"C_man_polo_1_F",
	"C_man_polo_2_F",
	"C_man_polo_3_F",
	"C_man_polo_4_F",
	"C_man_polo_5_F",
	"C_man_polo_6_F",
	"C_man_p_fugitive_F",
	"C_Man_casual_1_F",
	"C_Man_casual_2_F",
	"C_Man_casual_3_F",
	"C_Man_casual_4_F",
	"C_Man_casual_5_F",
	"C_Man_casual_6_F",
	"C_Story_Mechanic_01_F"
];

#ifdef __CUP_CHERNARUS__
	d_civArray = [
		"CUP_C_C_Citizen_01",
		"CUP_C_C_Citizen_02",
		"CUP_C_C_Citizen_03",
		"CUP_C_C_Citizen_04",
		"CUP_C_C_Worker_01",
		"CUP_C_C_Worker_02",
		"CUP_C_C_Worker_03",
		"CUP_C_C_Worker_04",
		"CUP_C_C_Profiteer_01",
		"CUP_C_C_Profiteer_01",
		"CUP_C_C_Profiteer_02",
		"CUP_C_C_Profiteer_03",
		"CUP_C_C_Profiteer_04",
		"CUP_C_C_Woodlander_01",
		"CUP_C_C_Woodlander_02",
		"CUP_C_C_Woodlander_03",
		"CUP_C_C_Woodlander_04",
		"CUP_C_C_Villager_01",
		"CUP_C_C_Villager_02",
		"CUP_C_C_Villager_03",	
		"CUP_C_C_Villager_04",
		"CUP_C_C_Priest_01"
	];
#endif
#ifdef __CUP_TAKISTAN__
	d_civArray = [
		"CUP_C_TK_Man_05_Waist",
		"CUP_C_TK_Man_06_Waist",
		"CUP_C_TK_Man_01_Coat",
		"CUP_C_TK_Man_08_Waist",
		"CUP_C_TK_Man_03_Coat",
		"CUP_C_TK_Man_01_Jack",
		"CUP_C_TK_Man_06_Jack",
		"CUP_C_TK_Man_03_Jack",
		"CUP_C_TK_Man_03_Jack"
	];
#endif
#ifdef __CUP_ZARGABAD__
	d_civArray = [
		"CUP_C_TK_Man_05_Waist",
		"CUP_C_TK_Man_06_Waist",
		"CUP_C_TK_Man_01_Coat",
		"CUP_C_TK_Man_08_Waist",
		"CUP_C_TK_Man_03_Coat",
		"CUP_C_TK_Man_01_Jack",
		"CUP_C_TK_Man_06_Jack",
		"CUP_C_TK_Man_03_Jack",
		"CUP_C_TK_Man_03_Jack"
	];
#endif
#ifdef __TANOA__
	d_civArray = [
		"C_Man_casual_1_F_tanoan",
		"C_Man_casual_2_F_tanoan",
		"C_Man_casual_3_F_tanoan",
		"C_Man_casual_4_F_tanoan",
		"C_Man_casual_5_F_tanoan",
		"C_Man_casual_6_F_tanoan"
	];
#endif
#ifdef __LIVONIA__
	d_civArray = [
		"C_Man_1_enoch_F",
		"C_Man_2_enoch_F",
		"C_Man_3_enoch_F",
		"C_Man_4_enoch_F",
		"C_Man_5_enoch_F",
		"C_Man_6_enoch_F",
		"C_Farmer_01_enoch_F"
	];
#endif
#ifdef __VN__
	d_civArray = [
		"vn_c_men_01",
		"vn_c_men_02",
		"vn_c_men_03",
		"vn_c_men_04",
		"vn_c_men_05",
		"vn_c_men_06",
		"vn_c_men_07",
		"vn_c_men_08",
		"vn_c_men_09",
		"vn_c_men_10",
		"vn_c_men_11",
		"vn_c_men_12",
		"vn_c_men_13",
		"vn_c_men_14",
		"vn_c_men_15",
		"vn_c_men_16",
		"vn_c_men_17",
		"vn_c_men_18",
		"vn_c_men_19",
		"vn_c_men_20",
		"vn_c_men_21",
		"vn_c_men_22",
		"vn_c_men_23",
		"vn_c_men_24",
		"vn_c_men_25",
		"vn_c_men_26",
		"vn_c_men_27",
		"vn_c_men_28",
		"vn_c_men_29",
		"vn_c_men_30",
		"vn_c_men_31",
		"vn_c_men_32"
	];
#endif
#ifdef __WS__
	d_civArray = [
		"C_Djella_01_lxWS",
		"C_Djella_02_lxWS",
		"C_Djella_03_lxWS",
		"C_Djella_04_lxWS",
		"C_Djella_05_lxWS",
		"C_Tak_01_A_lxWS",
		"C_Tak_01_B_lxWS",
		"C_Tak_01_C_lxWS",
		"C_Tak_02_A_lxWS",
		"C_Tak_02_B_lxWS",
		"C_Tak_02_C_lxWS",
		"C_Tak_03_A_lxWS",
		"C_Tak_03_B_lxWS",
		"C_Tak_03_C_lxWS"
	];
#endif

private _civ_units_count_max = 100;

private _buildings_unfiltered = [_trg_center, _radius] call d_fnc_getbldgswithpositions;

private _buildings = _buildings_unfiltered select { !(getModelInfo _x # 0 in d_object_spawn_civ_blacklist) };

diag_log [format ["total possible buildings to spawn civs: %1", count (_buildings)]];

private _total_civs_count_created = 0;

//create a cluster of civilians (does not use civilian module)
private _placeCivilianCluster = {
	if (count _buildings < 1 || {_total_civs_count_created > _civ_units_count_max}) exitWith {};
	_grp = _this # 0;
	_bldg = selectRandom _buildings;
	_buildings deleteAt (_buildings find _bldg);
	if (typeOf _bldg == d_barracks_building || {typeOf _bldg == d_vehicle_building}) exitWith {
		// oops, we randomly chose a vehicle or infantry HQ, do not place the civilian cluster just skip
	};
	_posArray = _bldg buildingPos -1;
	_unit_count = 2 max floor(random (count _posArray));
	if (count _posArray > 5 && {1 > random 13}) then {
		// small chance for larger buildings (more than 5 positions) to have many civs
		_unit_count = count _posArray - 1;
	};
	for "_i" from 0 to _unit_count do {
		if (_posArray isEqualTo []) exitWith {};
		diag_log [_i];
		_randomPos = selectRandom _posArray;
		_posArray deleteAt (_posArray find _randomPos);
		_civAgent = createAgent [selectRandom d_civArray, _randomPos, [], 0, "NONE"];
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
		[_civAgent] spawn d_fnc_afterfirednear; 
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
	[_this] spawn d_fnc_afterfirednear;
	[_this, selectRandom d_civ_faces] remoteExec ["setIdentity", 0, _this];
	_this setUnitLoadout selectRandom d_civArray;
}];
