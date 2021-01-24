//#define __DEBUG__
#define THIS_FILE "fn_civilianmodule.sqf"
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
		"CUP_U_C_Profiteer_01",
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

private _buildings = [_trg_center, _radius] call d_fnc_getbuildings;

//create a cluster of civilians (does not use civilian module)
private _placeCivilianCluster = {
	if (count _buildings < 1) exitWith {};
	_civPos = _this # 0;
	_grp = _this # 1;
	_unitCount = _this # 2;
	_bldg = selectRandom _buildings;
	_buildings deleteAt (_buildings find _bldg);
	_posArray = _bldg buildingPos -1;
	_posArrayCovered = [_posArray] call d_fnc_getcoveredpositions; 
	for "_i" from 0 to _unitCount do {
		if (_posArrayCovered isEqualTo []) exitWith {};
		_randomPos = selectRandom _posArrayCovered;
		_posArrayCovered deleteAt (_posArrayCovered find _randomPos);
		_civAgent = createAgent [selectRandom d_civArray, _randomPos, [], 1.5, "NONE"];
		if (random 2 <= 1) then {
			if (random 2 <= 1) then {
				[_civAgent, "SIT_LOW"] call BIS_fnc_ambientAnim;
			} else {
				_civAgent setUnitPos "MIDDLE";
			};
		};
		_civAgent setVariable ["civ_hide", _civAgent addEventHandler ["FiredNear", {
			params ["_unit"];
			if (((animationState _unit) find "sit") > 0) then {
				_unit call BIS_fnc_ambientAnim__terminate;
			};
			_unit setUnitPos "DOWN";
		}]];
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

// create civilians with createAgent (not the civilian module)
// these civilians do not run around, they stand/sit/kneel and when firedNear is triggered they lay down
for "_i" from 0 to d_civ_groupcount do {
#ifdef __DEBUG__
	diag_log [diag_frameno, diag_ticktime, time, format ["civilian for loop, group count _i: %1", _i]];
#endif
	_randomPos = [[[_trg_center, 200]],[]] call BIS_fnc_randomPos;
	_grp = createGroup [civilian, true];

	__TRACE("Placing a civilian cluster...")
	[_randomPos, _grp, d_civ_unitcount] call _placeCivilianCluster;
};

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
_m setVariable ["#unitcount", 10]; // not too many walking/running civs please (set to the module minimum 10)
_m setVariable ["#onCreated", {
	d_cur_tgt_civ_units pushBack _this;
	if (d_ai_persistent_corpses == 0) then {
		// civ corpses are removed when civ module is deleted
		removeFromRemainsCollector [_this];
	};
	_this addEventHandler ["Killed", {
		call d_fnc_civmodulekilleh;
	}];
	[_this, selectRandom d_civ_faces] remoteExec ["setIdentity", 0, _this];
	_this setUnitLoadout selectRandom d_civArray;
}];
