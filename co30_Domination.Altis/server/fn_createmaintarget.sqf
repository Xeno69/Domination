// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _selectit = {
	(ceil (random (((_this # 0) select (_this # 1)) # 1)))
};

private _selectitmen = {
	private _a_vng2 = (_this # 0) select (_this # 1);
	if (_a_vng2 # 0 > 0) then {
		if (d_always_max_groups == 1) then { 
			(_a_vng2 # 0)
		} else {
			private _num_ret = floor (random ((_a_vng2 # 0) + 1));
			if (_num_ret < _a_vng2 # 1) then {
				_a_vng2 # 1
			} else {
				_num_ret
			}
		};
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

// if selected use this array to override with mercenary units (nice weapons but no body armor)
// requires 2035 DLC
private _merc_array = [
	["East","OPF_G_F","Infantry","O_G_InfSquad_Assault"] call d_fnc_GetConfigGroup,
	["East","OPF_G_F","Infantry","O_G_InfTeam_Light"] call d_fnc_GetConfigGroup
];

if (d_enemy_mercenaries == 1) then {
	d_allmen_E =+ _merc_array;
	d_specops_E =+ _merc_array;
	publicVariable "d_allmen_E";
	publicVariable "d_specops_E";
	diag_log ["mercenaries configured for this map"];
};

private _faction_array = [];

if (d_enemy_factions > 0) then {

	// if selected use this array to override with factions units
	// most faction choices require CUP or CFP (Community Factions Project) or Asian Factions for CUP, more may be added later
	
	// Taliban
	if (d_enemy_factions == 1) then {
		_faction_array = [
			["EAST","CFP_O_TBAN","Infantry","CFP_O_TBAN_infantry_8man_team"] call d_fnc_GetConfigGroup
		];
	};
	
	// Asian Insurgents
	if (d_enemy_factions == 2) then {
		_faction_array = [
			["EAST","CUP_INS_ASIA","Infantry","cupinsasia_infantry_8man_team_a"] call d_fnc_GetConfigGroup,
			["EAST","CUP_INS_ASIA","Infantry","cupinsasia_infantry_8man_team_b"] call d_fnc_GetConfigGroup
		];
	};
	
	// Central African Rebels
	if (d_enemy_factions == 3) then {
		_faction_array = [
			["East","CFP_O_SOREBEL","Infantry","cfp_o_sorebel_infantry_rebel_squad"] call d_fnc_GetConfigGroup,
			["East","CFP_O_SOREBEL","Motorized","cfp_o_sorebel_motorized_technical"] call d_fnc_GetConfigGroup
		];
	};
	
	// Islamic State
	if (d_enemy_factions == 4) then {
		_faction_array = [
			["EAST","CFP_O_IS","Infantry","cfp_o_grp_is_inf_squad"] call d_fnc_GetConfigGroup,
			["EAST","CFP_O_IS","Infantry","cfp_o_grp_is_wpn_squad"] call d_fnc_GetConfigGroup,
			["EAST","CFP_O_IS","Infantry","cfp_o_grp_is_hq_squad"] call d_fnc_GetConfigGroup
		];
	};
	
	// Sudanese Armed Forces
	if (d_enemy_factions == 5) then {
		_faction_array = [
			["EAST","CFP_O_SDARMY","Infantry","CFP_O_SDARMY_infantry_squad"] call d_fnc_GetConfigGroup,
			["EAST","CFP_O_SDARMY","Infantry","CFP_O_SDARMY_infantry_riot_squad"] call d_fnc_GetConfigGroup,
			["EAST","CFP_O_SDARMY","SpecOps","CFP_O_SDARMY_specops_paratrooper_squad"] call d_fnc_GetConfigGroup
		];
	};
	
	d_allmen_E =+ _faction_array;
	d_specops_E =+ _faction_array;
	publicVariable "d_allmen_E";
	publicVariable "d_specops_E";
	diag_log [format["faction # %1 configured for this map", d_enemy_factions]];

};

private _type_list_guard = [];
private _type_list_guard_static = [];
private _camp_enable_guard_current = 0;
if (d_camp_enable_guard == -1) then {
	//random chance
	_camp_enable_guard_current = selectRandom [0,1];
};
if (d_camp_enable_guard == 1) then {
	//always enabled 
	_camp_enable_guard_current = 1;
};

if (_camp_enable_guard_current == 1) then {
	_type_list_guard = [
		["allmen", 0, [d_footunits_guard, 0] call _selectitmen],
		["specops", 0, [d_footunits_guard, 1] call _selectitmen],
		["tank", [d_vec_numbers_guard, 0] call _selectit, [d_vec_numbers_guard,0] call _selectitvec],
		["tracked_apc", [d_vec_numbers_guard, 1] call _selectit, [d_vec_numbers_guard,1] call _selectitvec],
		["wheeled_apc", [d_vec_numbers_guard, 2] call _selectit, [d_vec_numbers_guard,2] call _selectitvec],
		["jeep_mg", [d_vec_numbers_guard, 3] call _selectit, [d_vec_numbers_guard,3] call _selectitvec],
		["jeep_gl", [d_vec_numbers_guard, 4] call _selectit, [d_vec_numbers_guard,4] call _selectitvec]
	];
	_type_list_guard_static = [
		["allmen", 0, [d_footunits_guard_static, 0] call _selectitmen],
		["specops",0, [d_footunits_guard_static, 1] call _selectitmen],
		["tank", [d_vec_numbers_guard_static, 0] call _selectit, [d_vec_numbers_guard_static,0] call _selectitvec],
		["tracked_apc", [d_vec_numbers_guard_static, 1] call _selectit, [d_vec_numbers_guard_static,1] call _selectitvec],
		["aa", [d_vec_numbers_guard_static, 2] call _selectit, [d_vec_numbers_guard_static,2] call _selectitvec]
	];
};

private _type_list_patrol = [
	["allmen", 0, [d_footunits_patrol, 0] call _selectitmen],
	["specops", 0, [d_footunits_guard_static, 1] call _selectitmen],
	["tank", [d_vec_numbers_patrol, 0] call _selectit, [d_vec_numbers_patrol,0] call _selectitvec],
	["tracked_apc", [d_vec_numbers_patrol, 1] call _selectit, [d_vec_numbers_patrol,1] call _selectitvec],
	["wheeled_apc", [d_vec_numbers_patrol, 2] call _selectit, [d_vec_numbers_patrol,2] call _selectitvec],
	["jeep_mg", [d_vec_numbers_patrol, 3] call _selectit, [d_vec_numbers_patrol,3] call _selectitvec],
	["jeep_gl", [d_vec_numbers_patrol, 4] call _selectit, [d_vec_numbers_patrol,4] call _selectitvec]
];

private _d_veh_li = missionNamespace getVariable format ["d_veh_a_%1", d_enemy_side_short];

__TRACE_1("","_d_veh_li")
__TRACE_1("","count _d_veh_li")

if (count _d_veh_li > 12) then {
	__TRACE("Pushing back UAV")
	_type_list_patrol pushBack ["uav", [d_vec_numbers_patrol, 5] call _selectit, [d_vec_numbers_patrol,5] call _selectitvec];
};

__TRACE_1("","_type_list_patrol")

private _type_list_guard_static2 = [];
private _camp_static_weapons_current = 0;
if (d_camp_static_weapons == -1) then {
	//random chance
	_camp_static_weapons_current = selectRandom [0,1];
};
if (d_camp_static_weapons == 1) then {
	//always enabled
	_camp_static_weapons_current = 1;
};
if (_camp_static_weapons_current == 1) then {
	_type_list_guard_static2 = [
    	["stat_mg", 1, ceil (random 4)],
    	["stat_gl", 1, ceil (random 3)]
    ];
};

__TRACE_1("","_type_list_guard")

params ["_trgobj", "_radius"];
private _patrol_radius = _radius + 300 + random 300;
private _trg_center = if (_trgobj isEqualType objNull) then {getPosATL _trgobj} else {_trgobj};
__TRACE_1("","_trg_center")
__TRACE_3("","_trgobj","_radius","_patrol_radius")
__TRACE_1("","_this")

// set enemy mode
d_WithLessArmor call d_fnc_setenemymode;

d_groups_respawn_time_add = 0;
//limit barracks by d_max_bar_cnt, default is very high but may be lower if mission settings are non-default
d_num_barracks_objs = ((ceil random 7) max 4) min d_max_bar_cnt;
__TRACE_1("","d_num_barracks_objs")
d_mt_barracks_obj_ar = [];
if (d_bar_mhq_destroy == 0) then {
	d_mt_barmhq_ar = [];
};

d_priority_targets = [];
publicVariable "d_priority_targets";

private _parray = [_trg_center, _radius + 150, 8, 0.7, 0, false, true, true] call d_fnc_GetRanPointCircleBigArray;
if (count _parray < 8) then {
	diag_log "DOM Createmaintarget: Couldn't find enough positions with minimum distance 11m from next object, trying again without check!";
	_parray = [_trg_center, _radius + 150, 6, 0.7, 0, false, true] call d_fnc_GetRanPointCircleBigArray;
};

__TRACE_1("","_parray")

private ["_iccount", "_ecounter", "_poss"];
private _vec = objNull;
private _allbars = [];
private _doexit = false;
d_bara_trig_ar = [];

private _barcompo = call {
	if (d_vn) exitWith {
		[
			//["Land_vn_o_shelter_05",[0.397461,-0.0214844,0],0,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[-1.7793,-5.23535,0],0,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[-1.55469,5.90283,0],182,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[2.99609,-5.14209,0],359,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[-5.91113,-2.00537,0],91.0001,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[-5.9082,2.7207,0],91.0001,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[3.40723,5.72363,0],182,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[7.32715,-2.19434,0],270,1,0,[],"","",true,false],
			["Land_vn_fence_bamboo_02",[7.26758,2.78857,0],270,1,0,[],"","",true,false]
		]
	};
	if (d_ws) exitWith {
		[
			["Land_Wall_IndCnc_4_F",[-6.79297,-3.49902,0],270,1,0,[],"","",true,false],
			["Land_ConcreteWall_01_l_8m_F",[0.47168,7.73242,0.0022049],0,1,0,[],"","",true,false],
			["Land_Wall_IndCnc_4_F",[-6.33789,5.1084,0],280,1,0,[],"","",true,false],
			["Land_Wall_IndCnc_4_F",[7.88184,-3.47754,0.00019455],89.5086,1,0,[],"","",true,false],
			["Land_Wall_IndCnc_4_F",[-2.95898,-8.21387,0],180.111,1,0,[],"","",true,false],
			["Land_Wall_IndCnc_4_F",[7.46289,5.07715,0],80,1,0,[],"","",true,false],
			["Land_Wall_IndCnc_4_F",[4.27734,-8.12598,0],180.111,1,0,[],"","",true,false]
		]
	};
	[
		["Land_PillboxWall_01_6m_round_F",[-6.79297,-3.49902,0],270,1,0,[],"","",true,false],
		["Land_ConcreteWall_01_l_8m_F",[0.47168,7.73242,0.0022049],0,1,0,[],"","",true,false],
		["Land_PillboxWall_01_6m_round_F",[-6.33789,5.1084,0],280,1,0,[],"","",true,false],
		["Land_PillboxWall_01_6m_round_F",[7.88184,-3.47754,0.00019455],89.5086,1,0,[],"","",true,false],
		["Land_PillboxWall_01_6m_round_F",[-2.95898,-8.21387,0],180.111,1,0,[],"","",true,false],
		["Land_PillboxWall_01_6m_round_F",[7.46289,5.07715,0],80,1,0,[],"","",true,false],
		["Land_PillboxWall_01_6m_round_F",[4.27734,-8.12598,0],180.111,1,0,[],"","",true,false]
	]
};



private _barcountxx = -1;

for "_i" from 1 to d_num_barracks_objs do {
	private _idx = floor random (count _parray);
	_poss = _parray # _idx;
	__TRACE_1("1","_poss")

	if (_allbars isNotEqualTo []) then {
		private _fidx = _allbars findIf {_x distance2D _poss < 115};
		if (_fidx != -1) then {
			private _icounter = 0;
			while {_icounter < 50 || {_fidx != -1}} do {
				_idx = floor random (count _parray);
				_poss = _parray # _idx;
				_fidx = _allbars findIf {_x distance2D _poss < 115};
				_icounter = _icounter + 1;
			};
		};
	};

	_poss set [2, 0];
	_vec = createVehicle [d_barracks_building, _poss, [], 0, "NONE"];
	_vec setDir (_vec getDir _trg_center);
	if (([getPos _vec, 20] call d_fnc_getslope) > 0.4) then {
		_vec setVectorUp (surfaceNormal (getPos _vec));
	};
	_vec setVariable ["d_v_pos", getPos _vec];
	private _nump = count (allPlayers - entities "HeadlessClient_F");
	private _dist_trig_p = call {
		if (_nump < 25) exitWith {50};
		if (_nump < 30) exitWith {45};
		if (_nump < 35) exitWith {40};
		35
	};
	private _trig = [_vec, [_dist_trig_p, _dist_trig_p, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["this", "", ""]] call d_fnc_createtriggerlocal;
	_vec setVariable ["d_bar_trig", _trig];
	d_bara_trig_ar pushBack _trig;
	if (d_bar_mhq_destroy == 1) then {
		[_vec, 0] call d_fnc_checkmtrespawntarget;
	} else {
		_vec allowDamage false;
		_vec addEventHandler ["handleDamage", {0}];
		_vec setVariable ["d_timetotake", 30, true];
		_vec setVariable ["d_taketime", 0, true];
		_trig = [_vec, [10, 10, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["{alive _x && {!(_x getVariable ['xr_pluncon', false]) && {!(_x getVariable ['ace_isunconscious', false])}}} count thisList > 0", format ["d_bartrig_%1 = [thisTrigger, 0] spawn d_fnc_barmhqtrig", _i], format ["[thisTrigger, d_bartrig_%1] call d_fnc_bartrigover", _i]]] call d_fnc_createtriggerlocal;
		_trig setVariable ["d_vec", _vec];
		_vec setVariable ["d_isbarormhq", 0, true]; // 0 = barracks, 1 = MHQ...
		d_bara_trig_ar pushBack _trig;
		d_mt_barmhq_ar pushBack _vec;
		_barcountxx = _i;
	};
	d_mt_barracks_obj_ar pushBack _vec;
	_vec setVariable ["d_nextspawn", -1];
	sleep 0.1;
	__TRACE_1("1111","_vec")

	_parray deleteAt _idx;
	_allbars pushBack _vec;
	
	d_delvecsmt append ([getPos _vec, getDir _vec, _barcompo] call d_fnc_objectsMapper);

	sleep 0.1;
};
d_num_barracks_objs = count d_mt_barracks_obj_ar;
__TRACE_1("","d_mt_barracks_obj_ar")
__TRACE_1("2","d_num_barracks_objs")
d_mt_barracks_down = false;
d_num_barracks_tt = d_num_barracks_objs;
publicVariable "d_num_barracks_objs";
publicVariable "d_num_barracks_tt";

private _idx = floor random (count _parray);
_poss = _parray # _idx;
__TRACE_1("1","_poss")

if (_allbars isNotEqualTo []) then {
	private _fidx = _allbars findIf {_x distance2D _poss < 115};
	if (_fidx != -1) then {
		private _icounter = 0;
		while {_icounter < 50 || {_fidx != -1}} do {
			_idx = floor random (count _parray);
			_poss = _parray # _idx;
			_fidx = _allbars findIf {_x distance2D _poss < 115};
			_icounter = _icounter + 1;
		};
	};
};
_parray deleteAt _idx;
_poss set [2, 0];
_vec = createVehicle [d_vehicle_building, _poss, [], 0, "NONE"];
__TRACE_1("d_vehicle_building","_vec")
_vec setDir (_vec getDir _trg_center);
//_vec setPos _poss;
if (([getPos _vec, sizeOf d_vehicle_building] call d_fnc_getslope) > 0.4) then {
	_vec setVectorUp (surfaceNormal (getPos _vec));
};/* else {
	_vec setVectorUp [0,0,1];
};*/
_vec setVariable ["d_v_pos", getPos _vec];
if (d_bar_mhq_destroy == 1) then {
	[_vec, 1] call d_fnc_checkmtrespawntarget;
} else {
	_barcountxx = _barcountxx + 1;
	_vec allowDamage false;
	_vec addEventHandler ["handleDamage", {0}];
	_vec setVariable ["d_timetotake", 40, true];
	_vec setVariable ["d_taketime", 0, true];
	_trig = [_vec, [13, 13, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["{alive _x && {!(_x getVariable ['xr_pluncon', false]) && {!(_x getVariable ['ace_isunconscious', false])}}} count thisList > 0", format ["d_bartrig_%1 = [thisTrigger, 1] spawn d_fnc_barmhqtrig", _barcountxx], format ["[thisTrigger, d_bartrig_%1] call d_fnc_bartrigover", _barcountxx]]] call d_fnc_createtriggerlocal;
	_trig setVariable ["d_vec", _vec];
	_vec setVariable ["d_isbarormhq", 1, true]; // 0 = barracks, 1 = MHQ...
	d_bara_trig_ar pushBack _trig;
	d_mt_barmhq_ar pushBack _vec;
};
d_mt_mobile_hq_down = false;
d_mt_mobile_hq_obj = _vec;

if (d_bar_mhq_destroy == 0) then {
	publicVariable "d_mt_barmhq_ar";
	remoteExec ["d_fnc_makebarmhqwait", [0, -2] select isDedicated];
};

#ifndef __VN__
private _unitstog = [
	getPos _vec,
	3,		//_maxNumUnits
	10,		//fillRadius
	true,	//fillRoof
	false,	//fillEvenly
	true,	//fillTopDown
	false,	//disableTeleport
	0		//unitMovementMode
] call d_fnc_garrisonUnits;
d_delinfsm append _unitstog;
#endif
sleep 0.1;

#ifdef __DEBUG__
{
	[str _x, getPos _x, "ICON", "ColorBlack", [0.5, 0.5], "Barracks", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
} forEach d_mt_barracks_obj_ar;
[str d_mt_mobile_hq_obj, getPos d_mt_mobile_hq_obj, "ICON", "ColorBlack", [0.5, 0.5], "Mobile forces HQ", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif

#ifndef __VN__
private _wp_array_inf = [_trg_center, _radius + 50 + random 20, 0, 1, 0.3, true] call d_fnc_getwparray;
#else
private _wp_array_inf = [_trg_center, _radius + 50 + random 20, 0, 0, 0, true] call d_fnc_getwparray;
#endif
private _wp_array_vecs = [_trg_center, _radius + 50 + random 20, 0, 4, 0.7, true] call d_fnc_getwparray;

sleep 0.112;

private _fnc_dospawnr = {
	if !(_this in ["tank", "tracked_apc"]) then {
		random 100 > 20
	} else {
		selectrandom [0, 1] == 1
	};
};

private _comppost = [];
// create guard groups (and a camp if allmen/specops)
{
	if ((_x # 0) call _fnc_dospawnr || d_always_max_groups == 1) then {
		for "_xxx" from 1 to (_x # 2) do {
			private _ppos = [];
			private _iscompost = false;
			if (!isNil "d_compositions" && {d_compositions isNotEqualTo [] && {(_x # 0) in ["allmen", "specops"]}}) then {
				_idx = floor random (count _parray);
				_nppos = _parray # _idx;
				_ppos = _nppos;
				if (_comppost findIf {_x distance2D _ppos < 30} == -1) then {
					d_delvecsmt append ([_ppos, random 360, selectRandom d_compositions] call d_fnc_objectsMapper);
#ifdef __DEBUG__
					[str _ppos, _ppos, "ICON", "ColorBlack", [0.5, 0.5], "Mapper", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
					_comppost pushBack _ppos;
					_iscompost = true;
					_parray deleteAt _idx;
					sleep 0.2;
				} else {
					_ppos = [];
				};
			};
			if (_ppos isEqualTo []) then {
				private _curar = [_wp_array_vecs, _wp_array_inf] select (_x # 1 == 0);
				private _wp_ran = (count _curar) call d_fnc_RandomFloor;
				_ppos = _curar # _wp_ran;
				_curar deleteAt _wp_ran;
			};
			[_x # 0, [_ppos], _trg_center, _x # 1, "guard", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _radius], !_iscompost] call d_fnc_makegroup;
			sleep 0.2;
		};
	};
} forEach (_type_list_guard select {_x # 2 > 0});

sleep 0.233;

// create guard_static groups (and a camp if allmen/specops)
{
	if (d_always_max_groups == 1 || {(_x # 0) call _fnc_dospawnr}) then {
		for "_xxx" from 1 to (_x # 2) do {
			private _ppos = [];
			private _iscompost = false;
			if (!isNil "d_compositions" && {d_compositions isNotEqualTo [] && {(_x # 0) in ["allmen", "specops"]}}) then {
				_idx = floor random (count _parray);
				_nppos = _parray # _idx;
				_ppos = _nppos;
				if (_comppost findIf {_x distance2D _ppos < 30} == -1) then {
					d_delvecsmt append ([_ppos, random 360, selectRandom d_compositions] call d_fnc_objectsMapper);
#ifdef __DEBUG__
					[str _ppos, _ppos, "ICON", "ColorBlack", [0.5, 0.5], "Mapper", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
					_comppost pushBack _ppos;
					_iscompost = true;
					_parray deleteAt _idx;
					sleep 0.2;
				} else {
					_ppos = [];
				};
			};
			if (_ppos isEqualTo []) then {
				private _curar = [_wp_array_vecs, _wp_array_inf] select (_x # 1 == 0);
				private _wp_ran = (count _curar) call d_fnc_RandomFloor;
				_ppos = _curar # _wp_ran;
				_curar deleteAt _wp_ran;
			};
			[_x # 0, [_ppos], _trg_center, _x # 1, "guardstatic", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _radius], !_iscompost] call d_fnc_makegroup;
			sleep 0.2;
		};
	};
} forEach (_type_list_guard_static select {_x # 2 > 0});

// create guard_static2 groups (static GL and/or MG)
{
	for "_xxx" from 1 to (_x # 2) do {
		private _wp_ran = (count _wp_array_inf) call d_fnc_RandomFloor;
		[_x # 0, [_wp_array_inf # _wp_ran], _trg_center, _x # 1, "guardstatic2", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _radius]] call d_fnc_makegroup;
		_wp_array_inf deleteAt _wp_ran;
		sleep 0.1;
	};
} forEach (_type_list_guard_static2 select {_x # 2 > 0});

// create patrol groups
{
	__TRACE_1("patrol","_x")
	if (d_grp_cnt_footpatrol > 0 || {d_always_max_groups == 1 || {(_x # 0) call _fnc_dospawnr}}) then {
		if (d_grp_cnt_footpatrol == 0) exitWith {};
		private _curar = [_wp_array_vecs, _wp_array_inf] select (_x # 1 == 0);
		private _group_count = (_x # 2);
		if (d_grp_cnt_footpatrol > 0 && (_x # 0 == "allmen" || {_x # 0 == "specops"})) then {
			_group_count = d_grp_cnt_footpatrol;
		};
		for "_xxx" from 1 to _group_count do {
			private _wp_ran = (count _curar) call d_fnc_RandomFloor;
			[_x # 0, [_curar # _wp_ran], _trg_center, _x # 1, ["patrol", "patrol2mt"] select (_x # 0 == "allmen" || {_x # 0 == "specops"}), d_enemy_side_short, 0, -1.111, 1, [_trg_center, _patrol_radius]] call d_fnc_makegroup;
			_curar deleteAt _wp_ran;
			sleep 0.2;
		};
	};
} forEach (_type_list_patrol select {_x # 2 > 0});

_type_list_guard = nil;
_type_list_guard_static = nil;
_type_list_guard_static2 = nil;
_type_list_patrol = nil;

sleep 1.124;

if (d_allow_observers == 1 && {d_no_more_observers < 2}) then {
	d_nr_observers = floor random 4;
	if (d_nr_observers < 2) then {d_nr_observers = 2};
	d_obs_array = [];
	private _unit_array = ["arti_observer", d_enemy_side_short] call d_fnc_getunitlistm;
	for "_xx" from 0 to d_nr_observers - 1 do {
		private _agrp = [d_side_enemy] call d_fnc_creategroup;
		private _xx_ran = (count _wp_array_inf) call d_fnc_RandomFloor;
		private _xpos = _wp_array_inf # _xx_ran;
		_wp_array_inf deleteAt _xx_ran;
		__TRACE("from createmaintarget 1")
		private _observer = ([_xpos, _unit_array, _agrp, true, false] call d_fnc_makemgroup) # 0;
		[_agrp, _xpos, [_trg_center, _radius], [5, 20, 40], "", 0] spawn d_fnc_MakePatrolWPX;
		_agrp setVariable ["d_PATR", true];
		if (d_with_dynsim == 0) then {
			[_agrp, 0] spawn d_fnc_enabledynsim;
		};
		_observer addEventHandler ["killed", {
			d_nr_observers = d_nr_observers - 1;
			if (d_nr_observers <= 0) then {
#ifndef __TT__
				[3] call d_fnc_DoKBMsg;
#else
				[4] call d_fnc_DoKBMsg;
#endif
			};
		}];
		d_obs_array pushBack _observer;
		sleep 0.2;
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
//create civilian vehicles
//adapted from script by h8ermaker https://www.youtube.com/watch?v=pE47H8lG8uc
if (d_enable_civ_vehs > 0) then {
	_roadList = _trg_center nearroads d_enable_civ_vehs_rad;
	
	{
		_roadConnectedTo = roadsConnectedTo _x;
		
		if (count _roadConnectedTo > 2 || {count (roadsConnectedTo (_roadConnectedTo # 0)) > 2 || {count (roadsConnectedTo (_roadConnectedTo # 1)) > 2 || {((nearestBuilding _x) distance2D _x) > 20}}}) then {
			//only has 2 connections, children also only have 2 connections, is within 20m of a building
			_roadList=_roadList - [_x];	
		};
	} foreach _roadList;

	_roadList=_roadList call BIS_fnc_arrayShuffle;
	
	private _max_car_count = floor(d_enable_civ_vehs * 2.25); // sanity check, avoid spawning too many cars
	_carSpawns = round((count _roadList) * d_enable_civ_vehs / 100) min _max_car_count;
	diag_log [format ["creating %1 cars (calculated allowable is %2)", _carSpawns, _max_car_count]];
	
	for "_i" from 1 to _carSpawns do {
		_currentRoad = _roadList # _i;
		if (!isNil "_currentRoad" && {!isNull _currentRoad}) then {
			_roadConnectedTo = roadsConnectedTo _currentRoad;
			_connectedRoad = _roadConnectedTo # 0;
			if (isNil "_connectedRoad" || {isNull _connectedRoad}) exitWith {};
			_direction = [_currentRoad, _connectedRoad] call BIS_fnc_DirTo;
			
			_veh = createVehicle [selectRandomWeighted d_civ_vehicles_weighted, _currentRoad, [], 0, "NONE"];
			if (d_enable_civ_vehs_locked == 1) then {
				_veh lock true;
			};
			_veh enableSimulationGlobal false;
			_veh allowDamage false;
			_veh setDamage 0;
			_veh setdir _direction;
			_veh setPos [(getPos _veh # 0) + 5.5, getPos _veh # 1, getPos _veh # 2];
			d_cur_tgt_civ_vehicles pushBack _veh;
		};
	};
	
	sleep 10;
	_badCars = 0;
	{
		if ((vectorUp _x) # 2 < 0.8) then {
			_badCars = _badCars + 1;
		};
		_x enableSimulationGlobal true;
		_x allowDamage true;
		_x setDamage 0;
	} forEach d_cur_tgt_civ_vehicles;
	//hint format["badCars count: %1", _badCars];
};
#endif
//garrison begin

if (d_occ_bldgs == 1) then {
	//create garrisoned "occupy" groups of AI (free to move immediately)
	private _occ_cnt = 0;
	if (d_occ_cnt == -1 || d_occ_cnt == -2 || d_occ_cnt == -3 || d_occ_cnt == -4 || d_occ_cnt == -5) then {
		//adaptive group count
		//calculate number of occupy groups by counting the number of building in the maintarget area * spawn factor
		private _occ_spawn_factor = 0;
		if (d_occ_cnt == -1) then {
			_occ_spawn_factor = 0.03;  // adaptive (low)
		};
		if (d_occ_cnt == -2) then {
			_occ_spawn_factor = 0.06;  // adaptive (normal)
		};
		if (d_occ_cnt == -3) then {
			_occ_spawn_factor = 0.12;  // adaptive (high)
		};
		if (d_occ_cnt == -4) then {
			_occ_spawn_factor = 0.20;  // adaptive (very high)
		};
		if (d_occ_cnt == -5) then {
			_occ_spawn_factor = 0.75;  // adaptive (extreme)
		};
		private _bldg_count = count ([_trg_center, d_occ_rad] call d_fnc_getbldgswithpositions);
		private _occ_cnt_max = floor(_occ_spawn_factor * 100);
		_occ_cnt = floor (_bldg_count * _occ_spawn_factor) min _occ_cnt_max;
		diag_log [format ["_occ_cnt adaptive value: %1", _occ_cnt]];
	} else {
		_occ_cnt = d_occ_cnt;
	};
	
	diag_log [format ["creating occupy groups _occ_cnt: %1", _occ_cnt]];
	if (_occ_cnt > 0) then {
		for "_xx" from 0 to (_occ_cnt - 1) do {
			private _unitstog = [
				[[[_trg_center, d_occ_rad]],[]] call BIS_fnc_randomPos,
				-1,     //_maxNumUnits
				99,		//fillRadius
				false,		//fillRoof
				false,		//fillEvenly
				false,		//fillTopDown
				false,		//disableTeleport
				0		//unitMovementMode
			] call d_fnc_garrisonUnits;
			d_delinfsm append _unitstog;
		};
	};
	
	//create garrisoned "overwatch" groups of AI (movement disabled)
	private _ovrw_cnt = 0;
	if (d_ovrw_cnt == -1 || d_ovrw_cnt == -2 || d_ovrw_cnt == -3 || d_ovrw_cnt == -4 || d_ovrw_cnt == -5) then {
		//adaptive group count
		//calculate number of overwatch groups by counting the number of building in the maintarget area * spawn factor
		private _ovrw_spawn_factor = 0;
		if (d_ovrw_cnt == -1) then {
			_ovrw_spawn_factor = 0.03;  // adaptive (low)
		};
		if (d_ovrw_cnt == -2) then {
			_ovrw_spawn_factor = 0.06;  // adaptive (normal)
		};
		if (d_ovrw_cnt == -3) then {
			_ovrw_spawn_factor = 0.12;  // adaptive (high)
		};
		if (d_ovrw_cnt == -4) then {
			_ovrw_spawn_factor = 0.20;  // adaptive (very high)
		};
		if (d_ovrw_cnt == -5) then {
			_ovrw_spawn_factor = 0.75;  // adaptive (extreme)
		};
		private _bldg_count = count ([_trg_center, d_ovrw_rad] call d_fnc_getbldgswithpositions);
		private _ovrw_cnt_max = floor(_ovrw_spawn_factor * 100);
		_ovrw_cnt = floor (_bldg_count * _ovrw_spawn_factor) min _ovrw_cnt_max;
		diag_log [format ["_ovrw_cnt adaptive value: %1", _ovrw_cnt]];
	} else {
		_ovrw_cnt = d_ovrw_cnt;
	};
	diag_log [format ["creating overwatch groups _ovrw_cnt: %1", _ovrw_cnt]];
	if (_ovrw_cnt > 0) then {
		for "_xx" from 0 to (_ovrw_cnt - 1) do {
			private _unitstog = [
				[[[_trg_center, d_ovrw_rad]],[]] call BIS_fnc_randomPos,
				-1,     //_maxNumUnits
				99,		//fillRadius
				false,		//fillRoof
				false,		//fillEvenly
				false,		//fillTopDown
				false,		//disableTeleport
				3		//unitMovementMode - overwatch
			] call d_fnc_garrisonUnits;
			d_delinfsm append _unitstog;
		};
	};

	//create garrisoned "ambush" groups of AI (free to move after firedNear is triggered)
	private _amb_cnt = 0;
	if (d_amb_cnt == -1 || d_amb_cnt == -2 || d_amb_cnt == -3 || d_amb_cnt == -4 || d_amb_cnt == -5) then {
		//adaptive group count
		//calculate number of ambush groups by counting the number of building in the maintarget area * spawn factor
		private _amb_spawn_factor = 0;
		if (d_amb_cnt == -1) then {
			_amb_spawn_factor = 0.03;  // adaptive (low)
		};
		if (d_amb_cnt == -2) then {
			_amb_spawn_factor = 0.06;  // adaptive (normal)
		};
		if (d_amb_cnt == -3) then {
			_amb_spawn_factor = 0.12;  // adaptive (high)
		};
		if (d_amb_cnt == -4) then {
			_amb_spawn_factor = 0.20;  // adaptive (very high)
		};
		if (d_amb_cnt == -5) then {
			_amb_spawn_factor = 0.85;  // adaptive (extreme)
		};
		private _bldg_count = count ([_trg_center, d_amb_rad] call d_fnc_getbldgswithpositions);
		private _amb_cnt_max = floor(_amb_spawn_factor * 100);
		_amb_cnt = floor (_bldg_count * _amb_spawn_factor) min _amb_cnt_max;
		diag_log [format ["_amb_cnt adaptive value: %1", _amb_cnt]];
	} else {
		_amb_cnt = d_amb_cnt;
	};
	diag_log [format ["creating ambush groups _amb_cnt: %1", _amb_cnt]];
	if (_amb_cnt > 0) then {
		for "_xx" from 0 to (_amb_cnt - 1) do {
			private _pos = [[[_trg_center, d_amb_rad]],[]] call BIS_fnc_randomPos;
			// create an ambush group
			private _unitstog = [
				_pos,
				-1,     //_maxNumUnits
				99,		//fillRadius
				false,		//fillRoof
				false,		//fillEvenly
				false,		//fillTopDown
				false,		//disableTeleport
				1		//unitMovementMode - ambush
			] call d_fnc_garrisonUnits;
			d_delinfsm append _unitstog;
			
			// create an overwatch group in same building or area (cover the ambush group)
			private _unitstog = [
				_pos,
				-1,     //_maxNumUnits
				99,		//fillRadius
				false,		//fillRoof
				false,		//fillEvenly
				true,		//fillTopDown
				false,		//disableTeleport
				3		//unitMovementMode - overwatch
			] call d_fnc_garrisonUnits;
			d_delinfsm append _unitstog;
		};
	};

	//create garrisoned "sniper" groups of AI (static, never leave spawn position)
	private _snp_cnt = 0;
	if (d_snp_cnt == -1 || d_snp_cnt == -2 || d_snp_cnt == -3 || d_snp_cnt == -4 || d_snp_cnt == -5) then {
		//adaptive group count
		//calculate number of sniper groups by counting the number of building in the maintarget area * spawn factor
		private _snp_spawn_factor = 0;
		if (d_snp_cnt == -1) then {
			_snp_spawn_factor = 0.02;  // adaptive (low)
		};
		if (d_snp_cnt == -2) then {
			_snp_spawn_factor = 0.05;  // adaptive (normal)
		};
		if (d_snp_cnt == -3) then {
			_snp_spawn_factor = 0.10;  // adaptive (high)
		};
		if (d_snp_cnt == -4) then {
			_snp_spawn_factor = 0.20;  // adaptive (very high)
		};
		if (d_snp_cnt == -5) then {
			_snp_spawn_factor = 0.75;  // adaptive (extreme)
		};
		private _bldg_count = count ([_trg_center, d_snp_rad] call d_fnc_getbldgswithpositions);
		private _snp_cnt_max = floor(_snp_spawn_factor * 100);
		_snp_cnt = floor (_bldg_count * _snp_spawn_factor) min _snp_cnt_max;
		diag_log [format ["_snp_cnt adaptive value: %1", _snp_cnt]];
	} else {
		_snp_cnt = d_snp_cnt;
	};
	diag_log [format ["creating sniper groups _snp_cnt: %1", _snp_cnt]];
	if (_snp_cnt > 0) then {
		//START create garrisoned groups of snipers
		//prepare to create garrisoned groups of snipers - find and sort buildings
		private _buildingsArrayRaw = nearestObjects [_trg_center, ["Building", "House"], d_snp_rad, true];
	
		if (_buildingsArrayRaw isEqualTo []) exitWith {};
	
		private _buildingsArrayUsable = _buildingsArrayRaw select {(_x buildingPos -1) isNotEqualTo []};
	
		if (_buildingsArrayUsable isEqualTo []) exitWith {};
	
		__TRACE_1("","_buildingsArrayUsable")
	
		//sort by building height
		//_buildingsArraySorted = [_buildingsArrayUsable, [_trg_center], { _x modelToWorld (boundingBox _x # 1) # 2 }, "DESCEND", { 1 == 1 }] call BIS_fnc_sortBy;
	
		//sort by elevation - sort by highest position in each building
		private _buildingsArraySorted = [
			_buildingsArrayUsable,
			[],
			{
				private _topElevation = 0;
				private _currentElevation = 0;
				private _bldg = _x;
				_posArray = _bldg buildingPos -1;
	
				{
					_currentElevation = (getTerrainHeightASL _x) + (_x # 2); //Z axis
					if (_currentElevation > _topElevation && {(_x # 2) > 2}) then {_topElevation = _currentElevation}; // criteria: highest sea-level position AND position height is greater than 2m above terrain height
				} forEach _posArray;
	
				_topElevation
			},
			"DESCEND"
		] call BIS_fnc_sortBy;
	
		__TRACE_1("","_buildingsArraySorted")
	
		if (_buildingsArraySorted isEqualTo []) exitWith {};
	
		//choose the Top N of sorted buildings array
		
		private _buildingsArray = [];
	
		if (_snp_cnt >= count _buildingsArraySorted) then {
			_buildingsArray = _buildingsArraySorted select [0, count _buildingsArraySorted];
		} else {
			_buildingsArray = _buildingsArraySorted select [0, _snp_cnt];
		};
	
		__TRACE_1("","_buildingsArray")
	
		//create garrisoned groups of snipers with Top N of sorted buildings
		{
			//create the group but do not exceed the total number of positions in the building
			__TRACE_2("","_x","count (_x buildingPos -1)")
			private _unitstog = [
				getPos _x,
				2,		//_maxNumUnits
				5,		//fillRadius
				true,	//fillRoof
				false,	//fillEvenly
				true,	//fillTopDown
				false,	//disableTeleport
				2,		//unitMovementMode
				_x      //targetBuilding
			] call d_fnc_garrisonUnits;
			d_delinfsm append _unitstog;
		} forEach _buildingsArray;
		//END create garrisoned groups of snipers
	};

};
//garrison end

[_wp_array_inf, _radius, _trg_center] spawn d_fnc_createsecondary;

#ifndef __TT__
if (d_enable_civs == 1) then {
	diag_log ["creating static and walking civilians with civilian module"];
	[_trg_center, d_cur_target_radius] call d_fnc_civilianmodule;
	
	// loop to control civilian behaviors
	d_cur_tgt_afterfirednear_script_handle = [] spawn d_fnc_afterfirednear_civ_loop;
};
#endif


#ifndef __TT__
if (d_with_MainTargetEvents != 0) then {
	private _doMainTargetEvent = {
		params ["_event_string"];
		switch (_event_string) do {
			case "PILOT_RESCUE": {
				[_radius, _trg_center] spawn d_fnc_event_sideevac;
			};
			case "POW_RESCUE": {
				[_radius, _trg_center] spawn d_fnc_event_sideprisoners;
			};
			case "GUERRILLA_TANKS": {
				[_radius, _trg_center] spawn d_fnc_event_tanksincoming;
			};
			case "GUERRILLA_INFANTRY": {
				[_radius, _trg_center] spawn d_fnc_event_guerrilla_infantry_incoming;
			};
			case "RABBIT_RESCUE": {
				[_radius, _trg_center] spawn d_fnc_event_rabbitrescue;
			};
			case "MARKED_FOR_DEATH": {
				[_radius, _trg_center] spawn d_fnc_event_markedfordeath;
			};
			case "RESCUE_DEFEND": {
				[_radius, _trg_center] spawn d_fnc_event_sidevipdefend;
			};
			case "RESCUE_DEFUSE": {
				[_radius, _trg_center] spawn d_fnc_event_sideprisonerdefuse;
			};
			case "KILL_TRIGGERMAN": {
				[_radius, _trg_center] spawn d_fnc_event_sidekilltriggerman;
			};
			case "CIV_RESISTANCE_INDEPENDENT": {
				[_radius, _trg_center] spawn d_fnc_event_guerrillas_embedded_as_civilians;
			};
			case "MARKED_FOR_DEATH_VIP_ESCORT": {
				[_radius, _trg_center, true] spawn d_fnc_event_sidevipescort;
			};
		};
	};
	
	private _doEvent = false;
	if (d_with_MainTargetEvents < 0) then {
		// always do an event
		_doEvent = true;
	} else {
		// random chance for an event
		if (d_with_MainTargetEvents == 1) exitWith {
			if (random 100 < 30) then {_doEvent = true};
		};
		if (d_with_MainTargetEvents == 2 && {(random 100 < 70)}) then {_doEvent = true};
	};
	// choose event(s)
	if (_doEvent) then {
		private _tmpMtEvents = + d_x_mt_event_types;
		if (d_with_MainTargetEvents != -3 && {d_with_MainTargetEvents != -4}) then {
			// some events are only eligible if d_with_MainTargetEvents == -3 or -4
			// remove ineligible events from the temp array
			_tmpMtEvents deleteAt (_tmpMtEvents find "GUERRILLA_INFANTRY");
			//_tmpMtEvents deleteAt (_tmpMtEvents find "CIV_RESISTANCE_INDEPENDENT"); // todo - fix event
			//_tmpMtEvents deleteAt (_tmpMtEvents find "CIV_RESISTANCE_JOINPLAYER");  // todo - fix event
		};
		if (d_with_MainTargetEvents == -2 || {d_with_MainTargetEvents == -3 || {d_with_MainTargetEvents == -4}}) then {
			// create multiple simultaneous events
			private _num_events_for = 2; // default three events for iterator starting at zero
			if (d_with_MainTargetEvents == -4) then {
				// "all" parameter selected so entire events array will be used
				_num_events_for = (count _tmpMtEvents);
			};
			for "_i" from 0 to (_num_events_for - 1) do {
				private _tmpRandomEvent = selectRandom _tmpMtEvents;
				[_tmpRandomEvent] call _doMainTargetEvent;
				_tmpMtEvents deleteAt (_tmpMtEvents find _tmpRandomEvent);
				// if guerrilla infantry are randomly selected then there is a 1 in 3 chance of guerrilla tanks
				if (_tmpRandomEvent == "GUERRILLA_INFANTRY" && {(random 3 <= 1)}) then {
					[_radius, _trg_center] spawn d_fnc_event_tanksincoming;
				};
			};
		} else {
			// create one event
			// case for d_with_MainTargetEvents == -1 (always) falls through to here
			[selectRandom d_x_mt_event_types] call _doMainTargetEvent;
		};
		if (d_ai_awareness_rad > 0 && {d_enable_civs == 1 && {d_ai_aggressiveshoot == 1}}) then {
			// awareness, civs, agressiveshoot are enabled
			// very small chance of a civilian massacre
			if (2 > random 100) then {
				// bad luck for the civilians
				[_radius, _trg_center] spawn d_fnc_event_civ_massacre;
			};
		};
	};
};

if (d_ai_awareness_rad > 0 || {d_snp_aware == 1 || {d_ai_pursue_rad > 0 || {d_ai_aggressiveshoot == 1 || {d_ai_quickammo == 1}}}}) then {
	// at least one awareness setting is enabled, run the awareness loop
	d_cur_tgt_awareness_script_handle = [] spawn d_fnc_hallyg_dlegion_Snipe_awareness_loop;
};
#endif

#ifdef __VN__
// on SOG maps AI navigation is broken by dykes around the rice paddies, fix from johnnyboy
// https://forums.bohemia.net/forums/topic/234952-enable-prairie-fire-dlc-ai-to-navigate-rice-paddies/
{ 
	_mapDyke = _x; 
	_dyke = createSimpleObject ["vn\env_assets_f_vietnam\dykes\vn_dyke_10.p3d", [0,0,0]];
	_dir = getDir _mapDyke;
	_pos = getpos _mapDyke;
	hideObjectGlobal _mapDyke;
	_dyke setDir _dir; 
	_dyke setpos [_pos#0,_pos#1,.3];
} foreach ([nearestTerrainObjects [_trg_center, [], 1000], {(getModelInfo _x # 1) find "vn_dyke"> 0 }] call BIS_fnc_conditionalSelect);
#endif
