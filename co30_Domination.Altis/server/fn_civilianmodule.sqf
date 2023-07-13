//#define __DEBUG__
//#define __GROUPDEBUG__
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

if (d_civ_type > 0) then {
	if (d_civ_type == 1) then {
		d_civArray_current =+ d_africanCivs;
	};
	if (d_civ_type == 2) then {
		d_civArray_current =+ d_asianCivs;
	};
	if (d_civ_type == 3) then {
		d_civArray_current =+ d_euroCivs;
	};
	if (d_civ_type == 4) then {
		d_civArray_current =+ d_civ_faction_tanoa;
	};
	if (d_civ_type == 5) then {
		d_civArray_current =+ d_civ_faction_cup_chernarus;
	};
	if (d_civ_type == 6) then {
		d_civArray_current =+ d_civ_faction_cfp_chernarus_winter;
	};
	if (d_civ_type == 7) then {
		d_civArray_current =+ d_civ_faction_cfp_afghanistan;
	};
	if (d_civ_type == 8) then {
		d_civArray_current =+ d_civ_faction_cfp_african_christian;
	};
	if (d_civ_type == 9) then {
		d_civArray_current =+ d_civ_faction_cfp_african_islamic;
	};
	if (d_civ_type == 10) then {
		d_civArray_current =+ d_civ_faction_cfp_asian;
	};
	if (d_civ_type == 11) then {
		d_civArray_current =+ d_civ_faction_cfp_malden;
	};
	if (d_civ_type == 12) then {
		d_civArray_current =+ d_civ_faction_cfp_middle_east;
	};
	if (d_civ_type == 13) then {
		d_civArray_current =+ d_cupCivsTakistan;
	};
	// TODO - IFA civs
} else {
	d_civArray_current =+ d_civArray;
};


if (d_enable_women_civs == 1) then {
	d_civArray_current = (d_civArray_current + d_civ_women_common);
#ifdef __CUP_TAKISTAN__
	d_civArray_current = (d_civArray_current + d_civ_women_takistan);
#endif
};

private _civ_units_count_max = 500; // default (recalculated if adaptive settings are selected)

private _buildings_unfiltered = [_trg_center, _radius, d_side_enemy] call d_fnc_getbuildings;

private _buildings = _buildings_unfiltered select { !(getModelInfo _x # 0 in d_object_spawn_blacklist_civs) };

diag_log [format ["total possible buildings to spawn civs: %1", count (_buildings)]];

//create a cluster of civilians (does not use civilian module)
private _placeCivilianCluster = {
	diag_log [format ["attempting to place a civilian cluster... count _buildings array is: %1", count _buildings]];
	if (count _buildings < 1) exitWith {
		diag_log ["unable to place civilian cluster, no buildings in array"];
	};
	if (count d_cur_tgt_civ_units > _civ_units_count_max) exitWith {
		diag_log [format ["unable to place civilian cluster, %1 civs created and the max is %2", count d_cur_tgt_civ_units, _civ_units_count_max]];
	};
	_grp = _this # 0;
	_bldg = selectRandom _buildings;
	_buildings deleteAt (_buildings find _bldg);
	// check if selected building is a mission objective
	if ([_bldg] call d_fnc_ismissionobjective) exitWith {
		diag_log ["unable to place civilian cluster, randomly chose a building that is a mission objective"];
	};
	// do not create the civ cluster if any buildings within a 30m radius are also mission objectives
	private _mustExit = false;
	{
		if ([_x] call d_fnc_ismissionobjective) exitWith {
			_mustExit = true;
		};
	} forEach ([_bldg, 30] call d_fnc_getbldgswithpositions);
	if (_mustExit == true) exitWith {
		diag_log ["unable to place civilian cluster, randomly chose a building that is too close to a mission objective"];
	};
	_posArray = _bldg buildingPos -1;
	_unit_count = 6 max floor(random 12);
	if (count _posArray > 5 && {1 > random 10}) then {
		// small chance for larger buildings (more than 5 positions) to have many civs
		diag_log ["randomly chose to spawn a large civilian group"];
		_unit_count = 11 max floor(random 17);
	};
	private _units_civ_cluster = [];
	private _civ_group = createGroup civilian;
	_civ_group deleteGroupWhenEmpty true;
	for "_i" from 0 to _unit_count do {
		_civAgent = createAgent [selectRandomWeighted d_civArray_current, [0,0,0], [], 0, "NONE"];
		if (random 2 <= 1) then {
			_civAgent setUnitPos "MIDDLE";
		};
		_civAgent disableAI "FSM";
        _civAgent setBehaviour "CARELESS";
		_civAgent addEventHandler ["FiredNear", {
			params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
			private _last_dangerclose_ts = (agent teamMember _unit) getVariable ["civ_last_dangerclose", 0];
			if (_distance < 30) then {
				//if (((animationState _unit) find "sit") > 0) then {
				//	_unit call BIS_fnc_ambientAnim__terminate;
				//};
				if (_distance < 10 && {_distance > 3}) then {
					_unit setUnitPos "DOWN";
				};
				if (_distance < 3 && {(time - _last_dangerclose_ts) > 1.5}) then {
					// _firer is close enough to be dangerclose, set the dangerclose ts, _unit should be scared and move away from _firer
					_unit setVariable ["civ_last_dangerclose", time];
					_unit forceSpeed -1;
					// calculate a position to retreat
					private _newx = (getPos _firer # 0) - (getPos _unit # 0);
					private _newy = (getPos _firer # 1) - (getPos _unit # 1);
					private _newpos = [(getPos _unit # 0) - (1.5 * _newx), (getPos _unit # 1) - (1.5 * _newy)];
					_unit moveTo _newpos;
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
			private _check_punish = true;
			{
				if ((_x distance2D (getPos (_this # 0))) < 25) then {
					_check_punish = false; // civ was too close to a mission objective.  collateral damage, no punishment.
					d_kb_logic1 kbTell [
						d_kb_logic2,
						d_kb_topic_side,
						"PenaltyKilledCivilianNoTextFreeToEngage",
						d_kbtel_chan
					];
				};
			} forEach d_mtmissionobjs;
			if (_check_punish) then {
				call d_fnc_civmodulekilleh;
			};
		}];
		// do not change the assigned face if "woman" is in the typeOf (avoid putting male faces on women)
		if !(["woman", str typeOf _civAgent] call BIS_fnc_inString) then {
			// select random face
			[_civAgent, selectRandom d_civ_faces] remoteExec ["setIdentity", 0, _civAgent];
		};
		_units_civ_cluster pushBack _civAgent;
	};
	
	[
    	getPos _bldg,											// Params: 1. Array, the building(s) nearest this position is used
    	_units_civ_cluster,									//         2. Array of objects, the units that will garrison the building(s)
    	199,										//  (opt.) 3. Scalar, radius in which to fill building(s)
    	false,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
    	false,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
    	false,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
    	false,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
    	0,   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
    	true,								//  (opt.) 9. Boolean, true to force position selection such that the unit has a roof overhead
    	false,                           //  (opt.) 10. _isAllowSpawnNearEnemy Boolean, true to allow the selected position to be near an enemy (default: false)
    	false,                       //  (opt.) 11. _isDryRun Boolean, true to dry run, for testing only no units are moved, still returns array of units that could not be garrisoned at given pos (default: false)
    	99,                           //  (opt.) 12. _distanceFromBuildingCenter Scalar, distance a unit may be placed from the center of a building (usually safer) or -1 for any (default: -1)
    	_bldg							//  (opt.) 13. _targetBuilding Object, target building may be passed
    ] call d_fnc_Zen_OccupyHouse;

#ifdef __GROUPDEBUG__
	{
		private _civ_string_tmp = format ["civ-%1-%2", getModelInfo _bldg # 0, str (random 99999)]; // useful for identifying bad buildings to add to the civ blacklist
		[_civ_string_tmp, position _x, "ICON", "ColorBlack", [0.5, 0.5], _civ_string_tmp, 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
	} forEach _units_civ_cluster;
	{
		["X", position _x, "ICON", "ColorBlack", [0.5, 0.5], "X", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
	} forEach d_cur_tgt_civ_modules_presencesafespot;
#endif
	
	{
		if (getPos _x # 0 < 75 && getPos _x # 1 < 75) then {
			diag_log ["found a civilian unit placed near [0,0,0] unit will be deleted now."];
			d_cur_tgt_civ_units deleteAt (d_cur_tgt_civ_units find _x);
			deleteVehicle _x;
		};
	} forEach _units_civ_cluster;
	
	diag_log [format ["civilian cluster successfully created %1 civ units", count _units_civ_cluster]];
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
	private _bldg_count = count ([_trg_center, _radius, d_side_enemy] call d_fnc_getbuildings);
	private _civ_grp_count_max = floor(_civ_spawn_factor * 100); // sanity check, avoid spawning too many civ groups
	private _civ_units_count_max = floor(_civ_grp_count_max * 3.5); // sanity check, avoid spawning too many civ units 
	_civ_grp_count = floor (_bldg_count * _civ_spawn_factor) min _civ_grp_count_max;
	diag_log [format ["civilian bldg_count: %1, civ_grp_count: %2", _bldg_count, _civ_grp_count]];
};
diag_log [format ["civilian civ_grp_count: %1", _civ_grp_count]];

// create civilians with createAgent (not the civilian module)
// these civilians do not run around, they stand/sit/kneel and when firedNear is triggered they lay down
for "_i" from 0 to _civ_grp_count do {
#ifdef __DEBUG__
	diag_log [diag_frameno, diag_ticktime, time, format ["civilian for loop, group count _i: %1", _i]];
#endif
	_grp = createGroup [civilian, true];

	__TRACE("Placing a civilian cluster...")
	[_grp] call _placeCivilianCluster;
};

diag_log [format ["total static civs created: %1", count d_cur_tgt_civ_units]];

// create civilian module and use the module to spawn moving civilians (walking/running)
// only create one module and a few civilians, too many moving civilians are distracting
_grp_civmodule = createGroup [civilian, true];

// try to find safespot locations - some safe buildings by string match
private _safe_building_strings = ["church", "chapel"]; // later can add more known safe places here
{
	private _y = _x;
	private _is_safe = false;
	{
		if ([toLowerANSI _x, toLowerANSI (getModelInfo _y # 0)] call BIS_fnc_inString) then {
			_is_safe = true;
		};
	} forEach _safe_building_strings;
	if (_is_safe && {count d_cur_tgt_civ_modules_presencesafespot < 5}) then {
		private _msmatch = _grp_civmodule createUnit ["ModuleCivilianPresenceSafeSpot_F", position _y, [], 0, "NONE"];
		_msmatch call _civModuleSetVars;
		d_cur_tgt_civ_modules_presencesafespot pushBack _msmatch;
		__TRACE_1("","_msmatch")
	};
} forEach (_buildings_unfiltered select { !(getModelInfo _x # 0 in d_object_spawn_blacklist_civs) });

// find additional safespot locations (up to five total) that are not within 10m of a mission objective
private _tries_remaining = 99;
while {_tries_remaining > 0 && {count d_cur_tgt_civ_modules_presencesafespot < 5}} do {
	_tries_remaining = _tries_remaining - 1;
	{
		if !([_x] call d_fnc_ismissionobjective) then {
			private _ms = _grp_civmodule createUnit ["ModuleCivilianPresenceSafeSpot_F", position _x, [], 0, "NONE"];
			_ms call _civModuleSetVars;
			d_cur_tgt_civ_modules_presencesafespot pushBack _ms;
			__TRACE_1("","_ms")
	
		};
	} forEach _buildings;

};

if (count d_cur_tgt_civ_modules_presencesafespot > 0 && { d_civ_unitcount > 0}) then {
	// we found at least one civilian location so we can create and configure the module PresenceUnit and Presence
	private _mu1_pos = position (selectRandom d_cur_tgt_civ_modules_presencesafespot);
	private _mu1 = _grp_civmodule createUnit ["ModuleCivilianPresenceUnit_F", _mu1_pos, [], 0, "NONE"];
	d_cur_tgt_civ_modules_presenceunit pushBack _mu1;
	__TRACE_1("","_mu1")
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
    	[_this, selectRandomWeighted d_civArray_current] remoteExec ["setIdentity", 0, _this];
    	_this setUnitLoadout selectRandomWeighted d_civArray_current;
    }];
};
