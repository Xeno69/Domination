// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createmaintarget.sqf"
#include "..\x_setup.sqf"

private _garrisonUnits = {
	params ["_centerPos", "_numUnits", "_fillRadius", "_fillRoof", "_fillEvenly", "_fillTopDown", "_disableTeleport", "_unitMovementMode"];

	__TRACE("from createmaintarget garrison function")
	
	private ["_unitlist"];
	
	if (_unitMovementMode == 2) then { 
		_unitlist = ["sniper", d_enemy_side_short] call d_fnc_getunitlistm;
	} else {
		_unitlist = ["specops", d_enemy_side_short] call d_fnc_getunitlistm;
	};
	
	if (count _unitlist > _numUnits) then {
		while {count _unitlist > _numUnits} do {
			_unitlist deleteAt (ceil (random (count _unitlist - 1)));
		};
	};
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _units_to_garrison = [_trg_center, _unitlist, _newgroup, false] call d_fnc_makemgroup;
	_newgroup deleteGroupWhenEmpty true;
	sleep 1.0112;
	//_newgroup allowFleeing 0;
	//_newgroup setVariable ["d_defend", true];
	//[_newgroup, _poss] spawn d_fnc_taskDefend;
	if (d_with_dynsim == 0) then {
		_newgroup spawn {
			scriptName "spawn createmaintarget2";
			//sleep 1.5;
			_this enableDynamicSimulation true;
		};
	};

	//AI soldiers will be garrisoned in a building (window/roof)
	__TRACE("Placing units in a building...")
	//occupy a building using Zenophon script
	_unitsNotGarrisoned = [
		_centerPos,											// Params: 1. Array, the building(s) nearest this position is used
		_units_to_garrison,									//         2. Array of objects, the units that will garrison the building(s)
		_fillRadius,										//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
		_fillRoof,											//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
		_fillEvenly,										//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
		_fillTopDown,										//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
		_disableTeleport,									//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
		_unitMovementMode   								//  (opt.) 8. Scalar, 0 - unit is free to move immediately (default: 0) 1 - unit is free to move after a firedNear event is triggered 2 - unit is static, no movement allowed
	] call d_fnc_Zen_OccupyHouse;
	sleep 0.01;
	__TRACE_1("","_unitsNotGarrisoned")
	_units_to_garrison = _units_to_garrison - _unitsNotGarrisoned;
	{deleteVehicle _x} forEach _unitsNotGarrisoned;
	if (_units_to_garrison isEqualTo []) exitWith {
		deleteGroup _newgroup;
	};
	if (d_mt_respawngroups == 0) then {
		{
			[_x, 3] call d_fnc_setekmode;
		} forEach _units_to_garrison;
		_newgroup setVariable ["d_respawninfo", ["specops", [], _trg_center, 0, "patrol2", d_side_enemy, 0, 0, 1, [_trg_center, _radius], false, []]];
	};
	d_delinfsm append _units_to_garrison;
	_newgroup call d_fnc_addgrp2hc;
	__TRACE_1("","_newgroup")
	__TRACE_1("","_units_to_garrison")
};

private _selectit = {
	(ceil (random (((_this # 0) select (_this # 1)) # 1)))
};

private _selectitmen = {
	private _a_vng2 = (_this # 0) select (_this # 1);
	if (_a_vng2 # 0 > 0) then {
		private _num_ret = floor (random ((_a_vng2 # 0) + 1));
		if (_num_ret < _a_vng2 # 1) then {
			_a_vng2 # 1
		} else {
			_num_ret
		}
	} else {0}
};

private _selectitvec = {
	private _a_vng2 = ((_this # 0) select (_this # 1)) # 0;
	if (_a_vng2 # 0 > 0) then {
		private _num_ret = floor (random ((_a_vng2 # 0) + 1));
		if (_num_ret < _a_vng2 # 1) then {
			_a_vng2 # 1
		} else {
			_num_ret
		}
	} else {
		0
	};
};

private _type_list_guard = [
	["allmen", 0, [d_footunits_guard, 0] call _selectitmen],
	["specops", 0, [d_footunits_guard, 1] call _selectitmen],
	["tank", [d_vec_numbers_guard, 0] call _selectit, [d_vec_numbers_guard,0] call _selectitvec],
	["tracked_apc", [d_vec_numbers_guard, 1] call _selectit, [d_vec_numbers_guard,1] call _selectitvec],
	["wheeled_apc", [d_vec_numbers_guard, 2] call _selectit, [d_vec_numbers_guard,2] call _selectitvec],
	["jeep_mg", [d_vec_numbers_guard, 3] call _selectit, [d_vec_numbers_guard,3] call _selectitvec],
	["jeep_gl", [d_vec_numbers_guard, 4] call _selectit, [d_vec_numbers_guard,4] call _selectitvec]
];

private _type_list_guard_static = [
	["allmen", 0, [d_footunits_guard_static, 0] call _selectitmen],
	["specops",0, [d_footunits_guard_static, 1] call _selectitmen],
	["tank", [d_vec_numbers_guard_static, 0] call _selectit, [d_vec_numbers_guard_static,0] call _selectitvec],
	["tracked_apc", [d_vec_numbers_guard_static, 1] call _selectit, [d_vec_numbers_guard_static,1] call _selectitvec],
	["aa", [d_vec_numbers_guard_static, 2] call _selectit, [d_vec_numbers_guard_static,2] call _selectitvec]
];

private _type_list_patrol = [
	["allmen", 0, [d_footunits_patrol, 0] call _selectitmen],
	["specops", 0, [d_footunits_guard_static, 1] call _selectitmen],
	["tank", [d_vec_numbers_patrol, 0] call _selectit, [d_vec_numbers_patrol,0] call _selectitvec],
	["tracked_apc", [d_vec_numbers_patrol, 1] call _selectit, [d_vec_numbers_patrol,1] call _selectitvec],
	["wheeled_apc", [d_vec_numbers_patrol, 2] call _selectit, [d_vec_numbers_patrol,2] call _selectitvec],
	["jeep_mg", [d_vec_numbers_patrol, 3] call _selectit, [d_vec_numbers_patrol,3] call _selectitvec],
	["jeep_gl", [d_vec_numbers_patrol, 4] call _selectit, [d_vec_numbers_patrol,4] call _selectitvec]
];

private _type_list_guard_static2 = [
	["stat_mg", 1, ceil (random 4)],
	["stat_gl", 1, ceil (random 3)]
];

__TRACE_1("","_type_list_guard")

params ["_trgobj", "_radius"];
private _patrol_radius = _radius + 300 + random 300;
private _trg_center = if (_trgobj isEqualType objNull) then {getPosATL _trgobj} else {_trgobj};
__TRACE_1("","_trg_center")
__TRACE_3("","_trgobj","_radius","_patrol_radius")
__TRACE_1("","_this")

d_groups_respawn_time_add = 0;
//limit barracks by d_enemy_max_barracks_count, default is very high but may be lower if mission settings are non-default 
d_num_barracks_objs = ((ceil random 7) max 4) min d_enemy_max_barracks_count;
__TRACE_1("","d_num_barracks_objs")
d_mt_barracks_obj_ar = [];

private _parray = [_trg_center, d_cur_target_radius + 100, 4, 1, 0.3, sizeOf d_barracks_building, 0] call d_fnc_GetRanPointCircleBigArray;

private ["_iccount", "_ecounter", "_poss"];
private _vec = objNull;
private _allbars = [];
private _doexit = false;
d_bara_trig_ar = [];

for "_i" from 1 to d_num_barracks_objs do {
	private _idx = floor random (count _parray);
	_poss = _parray select _idx;	
	__TRACE_1("1","_poss")
	
	if !(_allbars isEqualTo []) then {
		private _fidx = _allbars findIf {_x distance2D _poss < 115};
		if (_fidx != -1) then {
			private _icounter = 0;
			while {_icounter < 50 || {_fidx != -1}} do {
				_idx = floor random (count _parray);
				_poss = _parray select _idx;
				_fidx = _allbars findIf {_x distance2D _poss < 115};
				_icounter = _icounter + 1;
			};
		};
	};
	
	_poss set [2, 0];
	_vec = createVehicle [d_barracks_building, _poss, [], 0, "NONE"];
	_vec setDir (_vec getDir _trg_center);
	_vec setVectorUp [0, 0, 1];
	_vec setVariable ["d_v_pos", getPos _vec];
	private _trig = [_vec, [40, 40, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["this", "", ""]] call d_fnc_createtriggerlocal;
	_vec setVariable ["d_bar_trig", _trig];
	d_bara_trig_ar pushBack _trig;
	[_vec, 0] call d_fnc_checkmtrespawntarget;
	d_mt_barracks_obj_ar pushBack _vec;
	sleep 0.5;
	__TRACE_1("1111","_vec")
	
	_parray deleteAt _idx;
	
	_allbars pushBack _vec;
	
	sleep 0.2;
};
d_num_barracks_objs = count d_mt_barracks_obj_ar;
__TRACE_1("","d_mt_barracks_obj_ar")
__TRACE_1("2","d_num_barracks_objs")
d_mt_barracks_down = false;
#ifdef __TT__
d_num_barracks_tt = d_num_barracks_objs;
publicVariable "d_num_barracks_tt";
#endif

#ifndef __TT__
private _idx = floor random (count _parray);
_poss = _parray select _idx;	
__TRACE_1("1","_poss")

if !(_allbars isEqualTo []) then {
	private _fidx = _allbars findIf {_x distance2D _poss < 115};
	if (_fidx != -1) then {
		private _icounter = 0;
		while {_icounter < 50 || {_fidx != -1}} do {
			_idx = floor random (count _parray);
			_poss = _parray select _idx;
			_fidx = _allbars findIf {_x distance2D _poss < 115};
			_icounter = _icounter + 1;
		};
	};
};
_poss set [2, 0];
_vec = createVehicle [d_vehicle_building, _poss, [], 0, "NONE"];
__TRACE_1("d_vehicle_building","_vec")
_vec setVectorUp [0, 0, 1];
_vec setVariable ["d_v_pos", getPos _vec];
[_vec, 1] call d_fnc_checkmtrespawntarget;
d_mt_mobile_hq_down = false;
d_mt_mobile_hq_obj = _vec;
sleep 0.1;

if (d_enable_civs == 1) then {
	[_trg_center] spawn d_fnc_civilianmodule;
};
#endif

#ifdef __DEBUG__
{
	[str _x, getPos _x, "ICON", "ColorBlack", [0.5, 0.5], "Barracks", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
} forEach d_mt_barracks_obj_ar;
if (!d_tt_ver) then {
	[str d_mt_mobile_hq_obj, getPos d_mt_mobile_hq_obj, "ICON", "ColorBlack", [0.5, 0.5], "Mobile forces HQ", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
};
#endif

private _wp_array_inf = [_trg_center, _radius, 0, 0, 0.7, 2] call d_fnc_getwparray;
private _wp_array_vecs = [_trg_center, _radius, 0, 2] call d_fnc_getwparray;
private _wp_array_pat_inf = [_trg_center, _patrol_radius, 0, 0, 0.7, 2] call d_fnc_getwparray;
private _wp_array_pat_vecs = [_trg_center, _patrol_radius, 0, 2] call d_fnc_getwparray;

sleep 0.112;

private _fnc_dospawnr = {
	if !(_this in ["tank", "tracked_apc"]) then {
		random 100 > 20
	} else {
		selectrandom [0, 1] == 1
	};
};

{
	if ((_x # 0) call _fnc_dospawnr) then {
		private _curar = [_wp_array_vecs, _wp_array_inf] select (_x # 1 == 0);
		for "_xxx" from 1 to (_x # 2) do {
			private _wp_ran = (count _curar) call d_fnc_RandomFloor;
			[_x # 0, [_curar select _wp_ran], _trg_center, _x # 1, "guard", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _radius]] call d_fnc_makegroup;
			_curar deleteAt _wp_ran;
			sleep 0.4;
		};
	};
} forEach (_type_list_guard select {_x # 2 > 0});

sleep 0.233;

{
	if ((_x # 0) call _fnc_dospawnr) then {
		private _curar = [_wp_array_vecs, _wp_array_inf] select (_x # 1 == 0);
		for "_xxx" from 1 to (_x # 2) do {
			private _wp_ran = (count _curar) call d_fnc_RandomFloor;
			[_x # 0, [_curar select _wp_ran], _trg_center, _x # 1, "guardstatic", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _radius]] call d_fnc_makegroup;
			_curar deleteAt _wp_ran;
			sleep 0.4;
		};
	};
} forEach (_type_list_guard_static select {_x # 2 > 0});

{
	for "_xxx" from 1 to (_x # 2) do {
		private _wp_ran = (count _wp_array_inf) call d_fnc_RandomFloor;
		[_x # 0, [_wp_array_inf select _wp_ran], _trg_center, _x # 1, "guardstatic2", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _radius]] call d_fnc_makegroup;
		_wp_array_inf deleteAt _wp_ran;
		sleep 0.1;
	};
} forEach (_type_list_guard_static2 select {_x # 2 > 0});

{
	if ((_x # 0) call _fnc_dospawnr) then {
		private _curar = [_wp_array_pat_vecs, _wp_array_pat_inf] select (_x # 1 == 0);
		for "_xxx" from 1 to (_x # 2) do {
			private _wp_ran = (count _curar) call d_fnc_RandomFloor;
			[_x # 0, [_curar select _wp_ran], _trg_center, _x # 1, ["patrol", "patrol2mt"] select (_x # 0 == "allmen" || {_x # 0 == "specops"}), d_enemy_side_short, 0, -1.111, 1, [_trg_center, _patrol_radius]] call d_fnc_makegroup;
			_curar deleteAt _wp_ran;
			sleep 0.4;
		};
	};
} forEach (_type_list_patrol select {_x # 2 > 0});

_type_list_guard = nil;
_type_list_guard_static = nil;
_type_list_guard_static2 = nil;
_type_list_patrol = nil;

sleep 2.124;

if (d_no_more_observers < 2) then {
	d_nr_observers = floor random 4;
	if (d_nr_observers < 2) then {d_nr_observers = 2};
	d_obs_array = [];
	d_obs_array resize d_nr_observers;
	private _unit_array = ["arti_observer", d_enemy_side_short] call d_fnc_getunitlistm;
	for "_xx" from 0 to d_nr_observers - 1 do {
		private _agrp = [d_side_enemy] call d_fnc_creategroup;
		private _xx_ran = (count _wp_array_inf) call d_fnc_RandomFloor;
		private _xpos = _wp_array_inf select _xx_ran;
		_wp_array_inf deleteAt _xx_ran;
		__TRACE("from createmaintarget 1")
		private _observer = ([_xpos, _unit_array, _agrp] call d_fnc_makemgroup) # 0;
		_agrp deleteGroupWhenEmpty true;
		[_agrp, _xpos, [_trg_center, _radius], [5, 20, 40], "", 0] spawn d_fnc_MakePatrolWPX;
		_agrp setVariable ["d_PATR", true];
		if (d_with_dynsim == 0) then {
			_agrp enableDynamicSimulation true;
		};
		_observer addEventHandler ["killed", {d_nr_observers = d_nr_observers - 1;
			if (d_nr_observers == 0) then {
#ifndef __TT__
				[3] call d_fnc_DoKBMsg;
#else
				[4] call d_fnc_DoKBMsg;
#endif
			};
			(_this select 0) removeAllEventHandlers "killed";
		}];
		d_obs_array set [_xx, _observer];
		sleep 0.4;
	};
	
	d_delinfsm append d_obs_array;
	_unit_array = nil;

#ifndef __TT__
	[6, d_nr_observers] call d_fnc_DoKBMsg;
#else
	[7, d_nr_observers] call d_fnc_DoKBMsg;
#endif
	d_handleobservers_handle = 0 spawn d_fnc_handleobservers;
	sleep 1.214;
};

#ifndef __TT__
//garrison begin`

if (d_enemy_occupy_bldgs == 1) then {
	//create garrisoned "occupy" groups of AI (free to move immediately)
	if (d_enemy_garrison_troop_occupy_count > 0) then {
		for "_xx" from 0 to (d_enemy_garrison_troop_occupy_count - 1) do {
			_numU = (ceil random 5) max 3;
			[
				[[[_trg_center, 100]],[]] call BIS_fnc_randomPos,
				_numU,			//unit count
				250,		//fillRadius
				false,		//fillRoof
				false,		//fillEvenly
				false,		//fillTopDown
				false,		//disableTeleport
				0		//unitMovementMode
			] call _garrisonUnits
		};
	};

	//create garrisoned "ambush" groups of AI (free to move after firedNear is triggered)
	if (d_enemy_garrison_troop_ambush_count > 0) then {
		for "_xx" from 0 to (d_enemy_garrison_troop_ambush_count - 1) do {
			_numUn = (ceil random 6) max 4;
			[
				[[[_trg_center, 100]],[]] call BIS_fnc_randomPos,
				_numUn,			//unit count
				250,		//fillRadius
				false,		//fillRoof
				false,		//fillEvenly
				false,		//fillTopDown
				false,		//disableTeleport
				1		//unitMovementMode
			] call _garrisonUnits
		};
	};
	
	if (d_enemy_garrison_troop_sniper_count == 0) exitWith {};

    //create garrisoned "sniper" groups of AI (static, never leave spawn position)
	//START create garrisoned groups of snipers
	//prepare to create garrisoned groups of snipers - find and sort buildings
	_buildingsArray = [];
	_buildingRadius = 425;
    _buildingsArrayRaw = nearestObjects [_trg_center, ["Building", "House"], _buildingRadius];

    _buildingsArrayUsable = [];

    {
    	//only buildings with positions for AI are usable
    	_poss = _x buildingPos -1;
		if !(_poss isEqualTo []) then {
			_buildingsArrayUsable pushBack _x;
		};
    } forEach _buildingsArrayRaw;
    
    __TRACE_1("","_buildingsArrayUsable")

    //sort by building height
    //_buildingsArraySorted = [_buildingsArrayUsable, [_trg_center], { _x modelToWorld (boundingBox _x select 1) select 2 }, "DESCEND", { 1 == 1 }] call BIS_fnc_sortBy;
    
    //sort by elevation - sort by highest position in each building
    _buildingsArraySorted = [
    	_buildingsArrayUsable,
    	[],
    	{
    		private _topElevation = 0;
    		private _currentElevation = 0;
    		private _bldg = _x;
			_posArray = _bldg buildingPos -1;
			
			{
				_currentElevation = _x select 2; //Z axis
				if (_currentElevation > _topElevation) then { _topElevation = _currentElevation };
			} forEach _posArray;
			
			_topElevation
		},
		"DESCEND"
	] call BIS_fnc_sortBy;
	
	__TRACE_1("","_buildingsArraySorted")

    //choose the Top N of sorted buildings array
	for "_i" from 0 to (d_enemy_garrison_troop_sniper_count - 1) do {
		_buildingsArray pushBack (_buildingsArraySorted select _i);
	};
    
    __TRACE_1("","_buildingsArray")

	//create garrisoned groups of snipers with Top N of sorted buildings
	private _counter = [d_enemy_garrison_troop_sniper_count, count _buildingsArray] select (d_enemy_garrison_troop_sniper_count > count _buildingsArray);
	__TRACE_3("","_counter","d_enemy_garrison_troop_sniper_count","count _buildingsArray")
	for "_xx" from 0 to (_counter - 1) do {
		_numUnits = 2;
		//create the group but do not exceed the total number of positions in the building
		private _building = _buildingsArray select _xx;
		__TRACE_1("","_building")
		__TRACE_1("","count (_building buildingPos -1)")
		[
			getPos _building,
			_numUnits,	//unit count
			-1,			//fillRadius
			true,		//fillRoof
			false,		//fillEvenly
			true,		//fillTopDown
			false,		//disableTeleport
			2		//unitMovementMode
		] call _garrisonUnits
	};
	//END create garrisoned groups of snipers
    	
};
//garrison end
#endif

[_wp_array_vecs, d_cur_target_radius, _trg_center] spawn d_fnc_createsecondary;

_wp_array_pat = nil;