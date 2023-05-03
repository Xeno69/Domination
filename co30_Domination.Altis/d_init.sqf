// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"

diag_log [diag_frameno, diag_ticktime, time, "Executing Dom d_init.sqf"];

if (isServer) then {
	call d_fnc_gmcwgextra;
};

if (!isServer) then {
	call compileScript ["init\initcommon.sqf", false];
};

if (hasInterface) then {
	call d_fnc_gmcwgextrac;
};

#ifdef __GROUPDEBUG__
call compileScript ["x_gdbfunctions.sqf", false];
#endif

if (hasInterface) then {
	private _vd = profileNamespace getVariable ["dom_viewdistance", d_InitialViewDistance];
	if (_vd > d_MaxViewDistance) then {
		_vd = d_MaxViewDistance;
	};
	if (d_ViewdistanceChange == 2) then {
		// special case, client may change later but initialize with d_InitialViewDistance
		_vd = d_InitialViewDistance;
	};
	setViewDistance _vd;
	diag_log ["DOM viewdistance at start:", _vd];
	setObjectViewDistance (_vd + 100);
	
	d_curviewdistance = _vd;
	d_curobjectdistance = _vd + 100;
	
	d_ViewDistanceVec = profileNamespace getVariable ["dom_viewdistancevec", d_curviewdistance];
	d_ViewDistanceAir = profileNamespace getVariable ["dom_viewdistanceair", d_curviewdistance];
	
	d_VD_Combi_use_InfVD = profileNamespace getVariable ["dom_vd_combi_use_infvd", false];
	
	d_maintarget_auto_vd = profileNamespace getVariable ["dom_maintarget_auto_vd", true];
	
	d_earplugs_userakey = profileNamespace getVariable ["dom_earplugs_userakey", 0];
	d_3dmarker_userakey = profileNamespace getVariable ["dom_3dmarker_userakey", 0];
	if (d_earplugs_userakey < 0 || {d_earplugs_userakey > 19}) then {d_earplugs_userakey = 0};
	if (d_3dmarker_userakey < 0 || {d_3dmarker_userakey > 19}) then {d_3dmarker_userakey = 0};
	d_earplugs_userakey_str = format ["User%1", d_earplugs_userakey + 1];
	d_3dmarker_userakey_str = format ["User%1", d_3dmarker_userakey + 1];
	
	d_ak_earplugs = actionKeys d_earplugs_userakey_str;
	d_ak_3dtoggle = actionKeys d_3dmarker_userakey_str;
	d_ak_getover = actionKeys "GetOver";
	d_ak_teamswitch = actionKeys "TeamSwitch";
	d_ak_hra = actionKeys "HeliRopeAction";
	d_ak_hslm = actionKeys "HeliSlingLoadManager";
	
	//d_player_radioprotocol = profileNamespace getVariable ["dom_player_radioprotocol", false];

	if (isMultiplayer) then {
		["d_server_name", [500, 500], "ICON", "ColorYellow", [2, 2], format ["%1 %2", localize "STR_DOM_MISSIONSTRING_1583a", serverName], 0, "hd_dot"] call d_fnc_CreateMarkerLocal;
	};
} else {
	setViewDistance 1600;
	setObjectViewDistance [1700, 0];
};

if (d_GrasAtStart == 1) then {
	setTerrainGrid 50;
	d_graslayer_index = 0;
} else {
	if (hasInterface) then {
		if (d_Terraindetail == 1) then {
			d_graslayer_index = 1;
			setTerrainGrid 25;
		} else {
			private _tg = profileNamespace getVariable ["dom_terraingrid", getTerrainGrid];
			diag_log ["DOM terraingrid at start:", _tg];
			if (_tg != getTerrainGrid) then {
				setTerrainGrid _tg;
				private _tmpidx = [50, 25, 12.5, 6.25, 3.125] find _tg;
				if (_tmpidx != -1) then {
					d_graslayer_index = _tmpidx;
				};
			} else {
				setTerrainGrid 25;
				d_graslayer_index = 1;
			};
		};
	};
};

d_target_names = [];
call d_fnc_maketarget_names;

// positions of service buildings
// first jet service, second chopper service, third wreck repair

d_service_buildings = [[], [], []];
#ifndef __TT__
if (d_dis_servicep == 1) then {
	if (markerPos "d_base_jet_sb" isNotEqualTo [0,0,0]) then {
		d_service_buildings set [0, [markerPos "d_base_jet_sb", markerDir "d_base_jet_sb"]];
	};
	if (!d_ifa3) then {
		if (markerPos "d_base_chopper_sb" isNotEqualTo [0,0,0]) then {
			d_service_buildings set [1, [markerPos "d_base_chopper_sb", markerDir "d_base_chopper_sb"]];
		};
	};
	if (markerPos "d_base_wreck_sb" isNotEqualTo [0,0,0]) then {
		d_service_buildings set [2, [markerPos "d_base_wreck_sb", markerDir "d_base_wreck_sb"]];
	};
};
d_FLAG_BASE allowDamage false;
if (isServer) then {
	deleteMarker "d_base_jet_sb";
	deleteMarker "d_base_chopper_sb";
	deleteMarker "d_base_wreck_sb";
};

// position base, side a and b length, direction and circle (false)/rectangle(true), like trigger; for the enemy at base area and marker
"d_base_marker" setMarkerAlphaLocal 0;
private _msize = markerSize "d_base_marker";
d_base_array = [[markerPos "d_base_marker" # 0, markerPos "d_base_marker" # 1, 1.9], _msize # 0, _msize # 1, markerDir "d_base_marker", true];
#else
d_EFLAG_BASE allowDamage false;
d_WFLAG_BASE allowDamage false;

"d_base_marker_w" setMarkerAlphaLocal 0;
"d_base_marker_e" setMarkerAlphaLocal 0;
private _msize = markerSize "d_base_marker_w";
private _msize2 = markerSize "d_base_marker_e";
d_base_array = [
	[[markerPos "d_base_marker_w" # 0, markerPos "d_base_marker_w" # 1, 1.9], _msize # 0, _msize # 1, markerDir "d_base_marker_w", true], // blufor
	[[markerPos "d_base_marker_e" # 0, markerPos "d_base_marker_e" # 1, 1.9], _msize2 # 0, _msize2 # 1, markerDir "d_base_marker_e", true] // opfor
];
#endif

"d_isledefense_marker" setMarkerAlphaLocal 0;

if (isServer) then {
#include "i_server.sqf"
};

if (d_with_dynsim == 0) then {
	enableDynamicSimulationSystem true;
	"Group" setDynamicSimulationDistance 1400;
	"Vehicle" setDynamicSimulationDistance 3000;
	"EmptyVehicle" setDynamicSimulationDistance 1000;
	"Prop" setDynamicSimulationDistance 600;
	"IsMoving" setDynamicSimulationDistanceCoef 2;
} else {
	enableDynamicSimulationSystem false;
};

if (isServer) then {
	d_serv_test_obj = d_HeliHEmpty createVehicle [101,101,101];
	d_serv_test_obj allowDamage false;
	d_serv_test_obj enableDynamicSimulation false;
	d_serv_test_obj enableSimulationGlobal false;
	private _all_farp_flags = (allMissionObjects "FlagCarrierCore") select {(str _x) select [0, 9] isEqualTo "d_flag_bb"};
	
	// marker position of the player ammobox at base and other player ammoboxes (marker always needs to start with d_player_ammobox_pos)
	// note, in the TT version add the side to the array too
	private _allMapMarkers = allMapMarkers select {_x select [0, 20] isEqualTo "d_player_ammobox_pos"};

#ifndef __TT__
	private _farpmarkers = allMapMarkers select {_x select [0, 13] == "d_farp_marker"};

	d_player_ammoboxes = [];
	private _smmcounter = 1243;
	private _icounter = 1;
	private _the_carrier = d_the_carrier;
	if (isNil "_the_carrier") then {
		_the_carrier = [0,0,0];
	};
	{
		private _mark = _x;
		private _markerpos = markerPos _mark;
		private _idxflag = -1;
		if (_markerpos distance2D _the_carrier > 200) then {
			_idxflag = _all_farp_flags findIf {_markerpos distance2D _x < 20};
			if (_idxflag != -1) then {
				if (d_retakefarps == 1) then {
					(_all_farp_flags # _idxflag) setVariable ["d_farptaken", true, true];
				};
				if (isNil {(_all_farp_flags # _idxflag) getVariable "d_farptaken"}) then {
					(_all_farp_flags # _idxflag) setVariable ["d_farp_aboxmarker", _mark];
					_mark setMarkerAlpha 0;
					private _name = format ["%1 %2", localize "STR_DOM_MISSIONSTRING_1762", _icounter, true];
					(_all_farp_flags # _idxflag) setVariable ["d_name", _name, true];
					_icounter = _icounter + 1;
				} else {
					_idxflag = -1;
				};
			};
			if (_idxflag != -1) then {
				private _idx = _farpmarkers findIf {_markerpos distance2D markerPos _x < 40};
				if (_idx != -1) then {
					(_all_farp_flags # _idxflag) setVariable ["d_farp_marker", _farpmarkers # _idx];
					(_farpmarkers # _idx) setMarkerAlpha 0;
				};
			};
		} else {
			_idxflag = _all_farp_flags findIf {_markerpos distance2D _x < 20};
			if (_idxflag != -1) then {
				(_all_farp_flags # _idxflag) setVariable ["d_farptaken", true, true];
				_idxflag = -1;
			};
		};
		if (_idxflag == -1) then {
			d_player_ammoboxes pushBack ([_x] call d_fnc_aboxcreate);
		} else {
			if (d_retakefarps == 0) then {
				[format ["d_smm|%1|farp", _smmcounter], (_all_farp_flags # _idxflag), "ICON", "ColorBlack", [1, 1], "", 0, "Empty"] call d_fnc_CreateMarkerGlobal;
				_smmcounter = _smmcounter + 1;
			};
		};
	} forEach _allMapMarkers;
#else
	d_player_ammoboxes = [[], []];

	private _tempar = d_player_ammoboxes # 1;
	private _rem = _allMapMarkers select {_x select [0, 22] isEqualTo "d_player_ammobox_pos_e"};
	{
		_tempar pushBack ([_x] call d_fnc_aboxcreate);
	} forEach _rem;
	_allMapMarkers = _allMapMarkers - _rem;

	_tempar = d_player_ammoboxes # 0;
	{
		_tempar pushBack ([_x] call d_fnc_aboxcreate);
	} forEach _allMapMarkers;
#endif
	publicVariable "d_player_ammoboxes";
};

if (isDedicated && {d_WithRevive == 0}) then {
	call compileScript ["revive.sqf", false];
};

#include "missions\missionssetup.sqf"

#ifndef __TT__
{_x allowDamage false} forEach (nearestTerrainObjects [d_FLAG_BASE, ["House"], 70, false, true]);
#else
{_x allowDamage false} forEach (nearestTerrainObjects [d_EFLAG_BASE, ["House"], 70, false, true]);
{_x allowDamage false} forEach (nearestTerrainObjects [d_WFLAG_BASE, ["House"], 70, false, true]);
#endif

if (isNil "d_target_clear") then {
	d_target_clear = false;
};
if (isNil "d_all_sm_res") then {
	d_all_sm_res = false;
};
if (isNil "d_the_end") then {
	d_the_end = false;
};
#ifndef __TT__
if (isNil "d_ari_available") then {
	d_ari_available = true;
};
#else
if (isNil "d_ari_available_w") then {
	d_ari_available_w = true;
};
if (isNil "d_ari_available_e") then {
	d_ari_available_e = true;
};
#endif
if (isNil "d_current_target_index") then {
	d_current_target_index = -1;
};
if (isNil "d_cur_sm_idx") then {
	d_cur_sm_idx = -1;
};
if (isNil "d_num_ammo_boxes") then {
	d_num_ammo_boxes = 0;
};
if (isNil "d_sec_kind") then {
	d_sec_kind = 0;
};
if (isNil "d_resolved_targets") then {
	d_resolved_targets = [];
};
if (isNil "d_ammo_boxes") then {
	d_ammo_boxes = [];
};
if (isNil "d_para_available") then {
	d_para_available = true;
};
if (isNil "d_searchintel") then {
	d_searchintel = [0,0,0,0,0,0,0];
};
#ifndef __TT__
if (isNil "d_arty_firing") then {
	d_arty_firing = false;
};
#else
if (isNil "d_arty_firing_w") then {
	d_arty_firing_w = false;
};
if (isNil "d_arty_firing_e") then {
	d_arty_firing_e = false;
};
#endif
if (isNil "d_numcamps") then {
	d_numcamps = 0;
};
#ifndef __TT__
if (isNil "d_campscaptured") then {
	d_campscaptured = 0;
};
#else
if (isNil "d_campscaptured_w") then {
	d_campscaptured_w = 0;
};
if (isNil "d_campscaptured_e") then {
	d_campscaptured_e = 0;
};
#endif

if (isNil "d_currentcamps") then {
	d_currentcamps = [];
};

if (isNil "d_farps") then {
	d_farps = [];
};
if (isNil "d_mashes") then {
	d_mashes = [];
};
if (isNil "d_cur_tgt_pos") then {
	d_cur_tgt_pos = [];
};
if (isNil "d_cur_tgt_name") then {
	d_cur_tgt_name = "";
};
if (isNil "d_cur_target_radius") then {
	d_cur_target_radius = -1;
};
if (isNil "d_mttarget_radius_patrol") then {
	d_mttarget_radius_patrol = -1;
};
if (isNil "d_cur_tgt_building_positions_occupied") then {
	d_cur_tgt_building_positions_occupied = [];
};
#ifndef __TT__
if (isNil "d_heli_taxi_available") then {
	d_heli_taxi_available = true;
};
if (isNil "d_cas_available") then {
	d_cas_available = true;
};
#else
if (isNil "d_cas_available_w") then {
	d_cas_available_w = true;
};
if (isNil "d_cas_available_e") then {
	d_cas_available_e = true;
};
#endif
if (isNil "d_num_barracks_tt") then {
	d_num_barracks_tt = 0;
};
if (isNil "d_num_barracks_objs") then {
	d_num_barracks_objs = 0;
};
if (isNil "d_winterw") then {
	d_winterw = 0;
};
if (isNil "d_mt_event_messages_array") then {
	d_mt_event_messages_array = [];
};
if (isNil "d_priority_targets") then {
	d_priority_targets = [];
};
if (isNil "d_civ_massacre") then {
	d_civ_massacre = false;
};
if (isNil "d_preemptive_special_event") then {
	d_preemptive_special_event = false;
};
if (isNil "d_preemptive_special_event_startpos_opfor") then {
	d_preemptive_special_event_startpos_opfor = [];
};
if (isNil "d_cur_tgt_civ_vehicles") then {
	d_cur_tgt_civ_vehicles = [];
};
if (isNil "d_cur_tgt_enemy_units") then {
	d_cur_tgt_enemy_units = [];
};

if (isNil "d_mt_tower") then {
	d_mt_tower_pos = [];
};

if (isNil "d_object_spawn_blacklist_common") then {
	d_object_spawn_blacklist_common = [
		#include "init\d_bldg_blacklist_common.sqf"
	];
};

if (isNil "d_object_spawn_blacklist_civs") then {
	d_object_spawn_blacklist_civs = [
		#include "init\d_bldg_blacklist_common.sqf"
		,
		#include "init\d_bldg_blacklist_civs.sqf"
	];
};

if (isNil "d_cur_uav_combat") then {
	d_cur_uav_combat = [];
};

if (hasInterface) then {
	if (isNil "d_MainTargets") then {d_MainTargets = count d_target_names};
};

if (isServer) then {
	execVM "bikb\kbinit.sqf";

	call d_fnc_serverinit;

#ifndef __TT__
	0 spawn {
		scriptName "spawn_initx_createbase";
		waitUntil {time > 0};
		sleep 2;

		private _mmm = markerPos "d_base_sb_ammoload";
		__TRACE_1("","_mmm")

		if (_mmm isNotEqualTo [0,0,0]) then {
			private _stype = [d_servicepoint_building] call BIS_fnc_simpleObjectData;
			_mmm set [2, 3.3];
			private _fac = createSimpleObject [_stype # 1, _mmm];
			_fac setDir (markerDir "d_base_sb_ammoload");
			_fac setPos _mmm;
		};
		if (!isNil "d_base_aa_vec" && {d_base_aa_vec isNotEqualTo ""}) then {
			[d_own_side, d_base_aa_vec, "d_base_anti_air"] call d_fnc_cgraa;
		};
		if (!isNil "d_base_tank_vec" && {d_base_tank_vec isNotEqualTo ""}) then {
			[d_own_side, d_base_tank_vec, "d_base_tank"] call d_fnc_cgraa;
		};
		if (!isNil "d_base_apc_vec" && {d_base_apc_vec isNotEqualTo ""}) then {
			[d_own_side, d_base_apc_vec, "d_base_apc"] call d_fnc_cgraa;
		};
	};
#endif

	if (d_weather == 0) then {0 spawn d_fnc_weatherserver};
	if (d_with_targetselect_count == 0 || {d_tt_ver}) then {
		if (d_MainTargets_num > count d_target_names) then {
			d_MainTargets_num = count d_target_names;
		};

		if (!d_tt_ver) then {
			if (d_MainTargets_num == 9998 || {d_MainTargets_num == -1}) then {
				d_maintargets_list = [floor (random 3)] call d_fnc_create_route;
				d_MainTargets_num = count d_target_names;
			} else {
				if (d_MainTargets_num == 9999 || {d_MainTargets_num == -2}) then { // order like placed in the editor
					d_maintargets_list = call d_fnc_makteolpmttargets;
					d_MainTargets_num = count d_target_names;
				} else {
					// create random list of targets
					d_maintargets_list = call d_fnc_createrandomtargets;
				};
			};
		} else {
			d_MainTargets_num = count d_target_names;
			d_maintargets_list = call d_fnc_createrandomtargets;
		};
		//d_maintargets_list = [0,1,2,3];
		__TRACE_1("","d_maintargets_list")

		d_MainTargets = count d_maintargets_list;
	} else {
		d_MainTargets = count d_target_names;
		if (d_with_targetselect_count == -1 || {d_with_targetselect_count == 9999}) then {
			d_with_targetselect_count = d_MainTargets;
		};
		d_mttargets_ar =+ d_target_names;
		d_cur_tar_obj = d_FLAG_BASE;
	};
	publicVariable "d_MainTargets";

	if (d_sm_dorandom == 0) then {
		// create random list of side missions
		d_side_missions_random = d_sm_array call BIS_fnc_arrayShuffle;
	} else {
		d_side_missions_random =+ d_sm_array;
	};
	__TRACE_1("","d_side_missions_random")

	d_current_mission_counter = 0;

#ifndef __TT__
	// editor varname, unique number, true = respawn only when the chopper is completely destroyed, false = respawn after some time when no crew is in the chopper or chopper is destroyed
	// unique number must be between 3000 and 3999
	private _choppers = [[d_chopper_1,3001,true,600],[d_chopper_2,3002,true,1500],[d_chopper_3,3003,false,1500],[d_chopper_4,3004,false,600],[d_chopper_5,3005,false,600],[d_chopper_6,3006,false,600]] select {!isNil {_x # 0}};

	if (!isNil "d_additional_wreck") then {
		{
			_choppers pushBack [_x, 3000 + 10 + _forEachIndex , false, 600];
		} forEach d_additional_wreck;
	};

	if (!isNil "d_additional_lift") then {
		{
			_choppers pushBack [_x, 3000 + 30 + _forEachIndex , true];
		} forEach d_additional_lift;
	};

	if (!isNil "d_additional_trans") then {
		{
			_choppers pushBack [_x, 3000 + 40 + _forEachIndex , true];
		} forEach d_additional_trans;
	};

	if (_choppers isNotEqualTo []) then {
		_choppers call d_fnc_inithelirespawn2;
	};
	// editor varname, unique number
	//0-99 = MHQ, 100-199 = Medic vehicles, 200-299 = Fuel, Repair, Reammo trucks, 300-399 = Engineer Salvage trucks, 400-499 = Transport trucks
	// new in 3.70  third parameter for MHQ means a message will be displayed for a MHQ if it gets destroyed
	private _vecsar = [[d_vec_mhq_1,0,localize "STR_DOM_MISSIONSTRING_12"],[d_vec_mhq_2,1, localize "STR_DOM_MISSIONSTRING_13"],[d_vec_med_1,100],[d_vec_rep_1,200],[d_vec_fuel_1,201],[d_vec_ammo_1,202], [d_vec_rep_2,203],[d_vec_fuel_2,204], [d_vec_ammo_2,205], [d_vec_eng_1,300], [d_vec_eng_2,301], [d_vec_trans_1,400], [d_vec_trans_2,401]] select {!isNil {_x # 0}};
	{
		_vecsar pushBack [_x, 500 + _forEachIndex];
	} forEach (vehicles select {(str _x) select [0, 12] isEqualTo "d_vec_wreck_"});
	if (!isNil "d_additional_mhqs") then {
		{
			private _num = 2 + _forEachIndex;
			_vecsar pushBack [_x, _num, "MHQ " + str (_num)];
		} forEach d_additional_mhqs;
	};
	_vecsar call d_fnc_initvrespawn2;
	{
		[_x, 300, false] spawn d_fnc_vehirespawn;
	} forEach (vehicles select {(str _x) select [0, 7] isEqualTo "d_boat_"});
	
	private _specialv = vehicles select {(str _x) select [0, 15] isEqualTo "d_vecs_special_"};
	if (_specialv isNotEqualTo []) then {
		_specialv call d_fnc_initvecsspecial;
	};
#else
	private _choppers = [[d_chopper_1,3001,true,600],[d_chopper_2,3002,true,1500],[d_chopper_3,3003,false,1500],[d_chopper_4,3004,false,600],[d_chopper_5,3005,false,600],[d_chopper_6,3006,false,600],
		[d_choppero_1,4001,true,600],[d_choppero_2,4002,true,1500],[d_choppero_3,4003,false,1500],[d_choppero_4,4004,false,600],[d_choppero_5,4005,false,600],[d_choppero_6,4006,false,600]] select {!isNil {_x # 0}};
	
	//[[d_chopper_1,3001,true,600],[d_chopper_2,3002,true,1500],[d_chopper_3,3003,false,1500],[d_chopper_4,3004,false,600],[d_chopper_5,3005,false,600],[d_chopper_6,3006,false,600],
	//[d_choppero_1,4001,true,600],[d_choppero_2,4002,true,1500],[d_choppero_3,4003,false,1500],[d_choppero_4,4004,false,600],[d_choppero_5,4005,false,600],[d_choppero_6,4006,false,600]] call d_fnc_inithelirespawn2;
	
	if (!isNil "d_additional_wreck_b") then {
		{
			_choppers pushBack [_x, 3000 + 10 + _forEachIndex , false, 600];
		} forEach d_additional_wreck_b;
	};
	if (!isNil "d_additional_wreck_o") then {
		{
			_choppers pushBack [_x, 4000 + 10 + _forEachIndex , false, 600];
		} forEach d_additional_wreck_o;
	};

	if (!isNil "d_additional_lift_b") then {
		{
			_choppers pushBack [_x, 3000 + 30 + _forEachIndex , true];
		} forEach d_additional_lift_b;
	};
	if (!isNil "d_additional_lift_o") then {
		{
			_choppers pushBack [_x, 4000 + 30 + _forEachIndex , true];
		} forEach d_additional_lift_o;
	};

	if (!isNil "d_additional_trans_b") then {
		{
			_choppers pushBack [_x, 3000 + 40 + _forEachIndex , true];
		} forEach d_additional_trans_b;
	};
	if (!isNil "d_additional_trans_o") then {
		{
			_choppers pushBack [_x, 4000 + 40 + _forEachIndex , true];
		} forEach d_additional_trans_o;
	};

	if (_choppers isNotEqualTo []) then {
		_choppers call d_fnc_inithelirespawn2;
	};

	private _vecsar = [
		[d_vec_mhq_1,0,localize "STR_DOM_MISSIONSTRING_12"],[d_vec_mhq_2,1,localize "STR_DOM_MISSIONSTRING_13"],[d_vec_med_1,100],[d_vec_rep_1,200],[d_vec_fuel_1,201],[d_vec_ammo_1,202], [d_vec_rep_2,203],
		[d_vec_fuel_2,204], [d_vec_ammo_2,205], [d_vec_eng_1,300], [d_vec_eng_2,301], [d_vec_trans_1,400], [d_vec_trans_2,401],
		[d_vec_mhqo_1,1000,localize "STR_DOM_MISSIONSTRING_12"],[d_vec_mhqo_2,1001,localize "STR_DOM_MISSIONSTRING_13"],[d_vec_medo_1,1100],[d_vec_repo_1,1200],[d_vec_fuelo_1,1201],[d_vec_ammoo_1,1202], [d_vec_repo_2,1203],
		[d_vec_fuelo_2,1204], [d_vec_ammoo_2,1205], [d_vec_engo_1,1300], [d_vec_engo_2,1301], [d_vec_transo_1,1400], [d_vec_transo_2,1401]] select {!isNil {_x # 0}};
		
	if (!isNil "d_additional_mhqs_o") then {
		{
			private _num = 2 + _forEachIndex;
			_vecsar pushBack [_x, 1000 + _num, "MHQ " + str (_num)];
		} forEach d_additional_mhqs_o;
	};
	if (!isNil "d_additional_mhqs_b") then {
		{
			private _num = 2 + _forEachIndex;
			_vecsar pushBack [_x, _num, "MHQ " + str (_num)];
		} forEach d_additional_mhqs_b;
	};

	_vecsar call d_fnc_initvrespawn2;
	
	{
		[_x, 300, false] spawn d_fnc_vehirespawn;
	} forEach (vehicles select {(str _x) select [0, 7] isEqualTo "d_boat_"});
#endif
	0 spawn d_fnc_initrepwreck;

#ifdef __TT__
	d_public_points = true;
	d_points_blufor = 0;
	d_points_opfor = 0;
	d_kill_points_blufor = 0;
	d_kill_points_opfor = 0;
	d_points_array = [0,0,0,0];
	publicVariable "d_points_array";
#endif

	call d_fnc_setupserver;
	if (d_MissionType != 2) then {0 spawn d_fnc_createnexttarget};
	
	addMissionEventHandler ["PlayerDisconnected", {call d_fnc_playerdisconnected}];

	addMissionEventHandler ["HandleDisconnect", {call d_fnc_handledisconnect}];
	if (d_MissionType != 2) then {
		addMissionEventhandler ["BuildingChanged", {call d_fnc_buildingchanged}];
	};
};

if (hasInterface) then {
#ifndef __TT__
	if (d_dis_servicep == 1) then {
		{
			[format ["d_wreck_service%1", _forEachIndex], _x,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_0",0,"n_service"] call d_fnc_CreateMarkerLocal;
		} forEach ((allMissionObjects "HeliH") select {(str _x) select [0, 11] == "d_wreck_rep"});
		if (!isNil "d_jet_trigger") then {
			["d_aircraft_service", d_jet_trigger,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_2",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!d_ifa3 && {!isNil "d_chopper_trigger"}) then {
			["d_chopper_service", d_chopper_trigger,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_3",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!isNil "d_vecre_trigger") then {
			["d_vec_service", d_vecre_trigger,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_4",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (d_carrier) then {
			["d_service_point", d_serviceall_trigger,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_1761",0,"hd_dot"] call d_fnc_CreateMarkerLocal;
		};
	};
	{
		[format ["d_Ammobox_Reload%1", _forEachIndex],_x,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_5",0,"hd_dot"] call d_fnc_CreateMarkerLocal;
	} forEach ((allMissionObjects "HeliH") select {(str _x) select [0, 10] == "D_AMMOLOAD"});
	["d_teleporter", d_FLAG_BASE,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_6",0,"mil_flag"] call d_fnc_CreateMarkerLocal;
	
	if (d_without_sm_bonus == 0) then {
		{
			deleteMarkerLocal _x;
		} forEach (allMapMarkers select {_x find "bonus_" != -1});
	};
#else
	if (d_dis_servicep == 1) then {
		if (!isNil "d_wreck_rep") then {
			["d_wreck_service", d_wreck_rep,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_0",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!isNil "d_jet_trigger") then {
			["d_aircraft_service", d_jet_trigger,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_2",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!d_ifa3 && {!isNil "d_chopper_trigger"}) then {
			["d_chopper_service", d_chopper_trigger,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_3",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!isNil "d_vecre_trigger") then {
			["d_vec_service", d_vecre_trigger,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_4",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
	};
	["d_Ammobox_Reload", d_AMMOLOAD,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_5",0,"hd_dot"] call d_fnc_CreateMarkerLocal;
	["d_teleporter", d_WFLAG_BASE,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_6",0,"mil_flag"] call d_fnc_CreateMarkerLocal;

	if (d_dis_servicep == 1) then {
		if (!isNil "d_wreck_rep2") then {
			["d_wreck_serviceR", d_wreck_rep2,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_0",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!isNil "d_jet_trigger2") then {
			["d_aircraft_serviceR", d_jet_trigger2,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_2",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!isNil "d_chopper_triggerR") then {
			["d_chopper_serviceR", d_chopper_triggerR,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_3",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
		if (!isNil "d_vecre_trigger2") then {
			["d_vehicle_serviceR", d_vecre_trigger2,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_4",0,"n_service"] call d_fnc_CreateMarkerLocal;
		};
	};
	["d_Ammobox ReloadR", d_AMMOLOAD2,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_5",0,"hd_dot"] call d_fnc_CreateMarkerLocal;
	["d_teleporter_1", d_EFLAG_BASE,"ICON","ColorYellow",[1,1],localize "STR_DOM_MISSIONSTRING_6",0,"mil_flag"] call d_fnc_CreateMarkerLocal;
	{
		_x setMarkerAlphaLocal 0;
	} forEach ["d_chopper_service","d_wreck_service","d_teleporter","d_aircraft_service","bonus_air","bonus_vehicles","d_Ammobox_Reload","d_vec_service",
		"Start","d_chopper_serviceR","d_wreck_serviceR","d_teleporter_1","d_aircraft_serviceR","bonus_airR","bonus_vehiclesR","d_Ammobox ReloadR","Start_opfor","d_vehicle_serviceR", "d_runwaymarker_o", "d_runwaymarker"];
#endif

	private _icounter_o = 0;
	private _icounter_b = 0;
	private _icounter_i = 0;
	private _allmissobjs = allMissionObjects "FlagCarrierCore";
	{
#ifndef __TT__
		private _fla = _x;
		if (d_additional_respawn_points isEqualTo [] || {d_additional_respawn_points findIf {count _x > 7 && {(_x # 7) == _fla}} == -1}) Then {
#endif
		private _side = _x getVariable ["d_flagside", blufor];
		private _name = _x getVariable "d_name";
		if (isNil "_name") then {
			private _icounter = call {
				if (_side == blufor) exitWith {
					_icounter_b = _icounter_b + 1;
					_icounter_b;
				};
				if (_side == opfor) exitWith {
					_icounter_o = _icounter_o + 1;
					_icounter_o
				};
				_icounter_i = _icounter_i + 1;
				_icounter_i
			};
			_name = format ["%1 %2", localize "STR_DOM_MISSIONSTRING_1762", _icounter];
		};
		__TRACE_2("","_x","_name")
		d_additional_respawn_points pushBack [format ["d_add_farp_%1", _x], str _x, _name, _side, d_vec_at_farp == 0, getPosASL _x, _x];
#ifndef __TT__
		};
	} forEach ((_allmissobjs select {(str _x) select [0, 9] isEqualTo "d_flag_bb"}) select {!isNil {_x getVariable "d_farptaken"}});
#else
	} forEach (_allmissobjs select {(str _x) select [0, 9] isEqualTo "d_flag_bb"});
#endif
	_icounter_o = 0;
	_icounter_b = 0;
	_icounter_i = 0;
	{
		private _side = _x getVariable ["d_flagside", blufor];
		private _name = _x getVariable "d_name";
		if (isNil "_name") then {
			private _icounter = call {
				if (_side == blufor) exitWith {
					_icounter_b = _icounter_b + 1;
					_icounter_b;
				};
				if (_side == opfor) exitWith {
					_icounter_o = _icounter_o + 1;
					_icounter_o
				};
				_icounter_i = _icounter_i + 1;
				_icounter_i
			};
			_name = format ["%1 %2", localize "STR_DOM_MISSIONSTRING_1826", _icounter];
		};
		d_additional_respawn_points pushBack [format ["d_add_farp_%1", _x], str _x, _name, _side, true, getPosASL _x, _x];
	} forEach (_allmissobjs select {(str _x) select [0, 15] isEqualTo "d_respawn_point"});

	if (d_with_ranked) then {
		call {
			if (d_rhs) exitWith {
				call compileScript ["i_weapons_rhs.sqf", false];
			};
			if (d_cup) exitWith {
				call compileScript ["i_weapons_CUP.sqf", false];
			};
			if (d_pracs) exitWith {
				call compileScript ["i_weapons_PRACS.sqf", false];
			};
			if (d_ifa3) exitWith {
				call compileScript ["i_weapons_IFA3.sqf", false];
			};
			if (d_gmcwg) exitWith {
				call compileScript ["i_weapons_gmcwg.sqf", false];
			};
			if (d_unsung) exitWith {
				call compileScript ["i_weapons_UNSUNG.sqf", false];
			};
			if (d_vn) exitWith {
				call compileScript ["i_weapons_vn.sqf", false];
			};
			if (d_csla) exitWith {
				call compileScript ["i_weapons_csla.sqf", false];
			};
			call compileScript ["i_weapons_default.sqf", false];
		};
	};
};

d_init_processed = true;

diag_log [diag_frameno, diag_ticktime, time, "Dom d_init.sqf processed"];
