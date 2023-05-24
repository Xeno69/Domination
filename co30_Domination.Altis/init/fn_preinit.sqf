// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
#include "..\x_dbsetup.sqf"
diag_log format ["############################# %1 %2 #############################", missionName, missionNameSource];
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom fn_preinit.sqf"];

#ifndef __TT__
d_tt_ver = false;
#else
d_tt_ver = true;
#endif

#ifndef __TANOA__
d_tanoa = false;
#else
d_tanoa = true;
#endif

#ifndef __LIVONIA__
d_livonia = false;
#else
d_livonia = true;
#endif

#ifdef __TTTANOA__
d_tanoa = true;
#endif

#ifndef __IFA3__
d_ifa3 = false;
d_kbtel_chan = "SIDE";
#else
d_ifa3 = true;
d_kbtel_chan = "GLOBAL";
#endif

#ifdef __CUP__
d_cup = true;
#else
d_cup = false;
#endif

#ifdef __CARRIER__
d_carrier = true;
#else
d_carrier = false;
#endif

#ifndef __MALDEN_
d_malden = false;
#else
d_malden = true;
#endif

#ifndef __RHS__
d_rhs = false;
#else
d_rhs = true;
#endif

#ifndef __GMCWG__
d_gmcwg = false;
#else
d_gmcwg = true;
#endif

#ifndef __GMCWGW__
d_gmcwgwinter = false;
#else
d_gmcwgwinter = true;
#endif

#ifdef __UNSUNG__
d_unsung = true;
#else
d_unsung = false;
#endif

#ifdef __CSLA__
d_csla = true;
#else
d_csla = false;
#endif

#ifdef __VN__
d_vn = true;
#else
d_vn = false;
#endif

#ifdef __WS__
d_ws = true;
#else
d_ws = false;
#endif

#ifdef __PRACS__
d_pracs = true;
#else
d_pracs = false;
#endif

d_HeliHEmpty = "Land_HelipadEmpty_F";

// BLUFOR, OPFOR or INDEPENDENT for own side, setup in x_setup.sqf
#ifdef __OWN_SIDE_BLUFOR__
d_own_side = "WEST";
d_own_sides = ["WEST"];
d_own_sides_o = [blufor];
d_enemy_side = "EAST";
d_enemy_side_short = "E";
d_side_enemy = opfor;
d_rhs_blufor = true;
d_side_player = blufor;
d_version_string = "Blufor";
d_e_marker_color = "ColorOPFOR";
#endif
#ifdef __OWN_SIDE_OPFOR__
d_own_side = "EAST";
d_own_sides = [["EAST", "GUER"], ["EAST"]] select (!d_ifa3);
d_own_sides_o = [[opfor, independent], [opfor]] select (!d_ifa3);
d_enemy_side = "WEST";
d_enemy_side_short = "W";
d_side_enemy = blufor;
d_rhs_blufor = false;
d_side_player = opfor;
d_version_string = "Opfor";
d_e_marker_color = "ColorBLUFOR";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
d_own_side = "GUER";
d_own_sides = ["GUER"];
d_own_sides_o = [independent];
d_enemy_side = "EAST";
d_enemy_side_short = "E";
d_side_enemy = opfor;
d_side_player = independent;
d_version_string = "GUER";
d_e_marker_color = "ColorGUER";
#endif
#ifdef __TT__
d_own_side = "WEST";
d_own_sides = ["WEST"];
d_enemy_side = "GUER";
d_enemy_side_short = "G";
d_side_enemy = independent;
d_side_player = blufor;
d_version_string = "Two Teams";
d_e_marker_color = "ColorYellow";
#endif

#ifdef __IFA3__
d_version_string = "IFA3";
#endif

#ifdef __CARRIER__
d_version_string = "Carrier";
#endif

#ifdef __RHS__
d_version_string = ["RHS Opfor", "RHS Blufor"] select d_rhs_blufor;
#endif

#ifdef __IFA3__
d_e_marker_color_alpha = 1.3;
#else
d_e_marker_color_alpha = 0.8;
#endif

#ifdef __ALTIS__
#include "sm_bonus_vec_ar_altis.sqf"
#endif
#ifdef __CUP_CHERNARUS__
#include "sm_bonus_vec_ar_cup.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "sm_bonus_vec_ar_cup.sqf"
#endif
#ifdef __CUP_SARA__
#include "sm_bonus_vec_ar_cup.sqf"
#endif
#ifdef __IFA3__
#include "sm_bonus_vec_ar_ifa3.sqf"
#endif
#ifdef __GMCWG__
#include "sm_bonus_vec_ar_gmcwg.sqf"
#endif
#ifdef __LIVONIA__
#include "sm_bonus_vec_ar_tanoa.sqf"
#endif
#ifdef __TTALTIS__
#include "sm_bonus_vec_ar_tt.sqf"
#endif
#ifdef __TTTANOA__
#include "sm_bonus_vec_ar_tt_tanoa.sqf"
#endif
#ifdef __TTMALDEN__
#include "sm_bonus_vec_ar_tt.sqf"
#endif
#ifdef __TANOA__
#include "sm_bonus_vec_ar_tanoa.sqf"
#endif
#ifdef __STRATIS__
#include "sm_bonus_vec_ar_altis.sqf"
#endif
#ifdef __MALDEN__
#include "sm_bonus_vec_ar_altis.sqf"
#endif
#ifdef __RHS__
#include "sm_bonus_vec_ar_rhs.sqf"
#endif
#ifdef __UNSUNG__
#include "sm_bonus_vec_ar_uns.sqf"
#endif
#ifdef __CSLA__
#include "sm_bonus_vec_ar_csla.sqf"
#endif
#ifdef __VN__
#include "sm_bonus_vec_ar_vn.sqf"
#endif
#ifdef __WS__
#include "sm_bonus_vec_ar_ws.sqf"
#endif
#ifdef __PRACS__
#include "sm_bonus_vec_ar_pracs.sqf"
#endif

#ifdef __ALTIS__
#include "mt_bonus_vec_ar_altis.sqf"
#endif
#ifdef __LIVONIA__
#include "mt_bonus_vec_ar_tanoa.sqf"
#endif
#ifdef __GMCWG__
#include "mt_bonus_vec_ar_gmcwg.sqf"
#endif
#ifdef __CUP_CHERNARUS__
#include "mt_bonus_vec_ar_cup.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "mt_bonus_vec_ar_cup.sqf"
#endif
#ifdef __CUP_SARA__
#include "mt_bonus_vec_ar_cup.sqf"
#endif
#ifdef __IFA3__
#include "mt_bonus_vec_ar_ifa3.sqf"
#endif
#ifdef __TTALTIS__
#include "mt_bonus_vec_ar_tt.sqf"
#endif
#ifdef __TTMALDEN__
#include "mt_bonus_vec_ar_tt.sqf"
#endif
#ifdef __TTTANOA__
#include "mt_bonus_vec_ar_tt_tanoa.sqf"
#endif
#ifdef __TANOA__
#include "mt_bonus_vec_ar_tanoa.sqf"
#endif
#ifdef __STRATIS__
#include "mt_bonus_vec_ar_altis.sqf"
#endif
#ifdef __MALDEN__
#include "mt_bonus_vec_ar_altis.sqf"
#endif
#ifdef __RHS__
#include "mt_bonus_vec_ar_rhs.sqf"
#endif
#ifdef __UNSUNG__
#include "mt_bonus_vec_ar_uns.sqf"
#endif
#ifdef __CSLA__
#include "mt_bonus_vec_ar_csla.sqf"
#endif
#ifdef __VN__
#include "mt_bonus_vec_ar_vn.sqf"
#endif
#ifdef __WS__
#include "mt_bonus_vec_ar_ws.sqf"
#endif
#ifdef __PRACS__
#include "mt_bonus_vec_ar_pracs.sqf"
#endif

#ifndef __TT__
d_sm_b_vec_ar_c = d_sm_bonus_vehicle_array apply {toLowerANSI _x};
d_sm_bonus_vehicle_array =+ d_sm_b_vec_ar_c;
d_mt_bonus_vehicle_array = d_mt_bonus_vehicle_array apply {toLowerANSI _x};
#else
d_sm_b_vec_ar_c = [];
d_sm_b_vec_ar_c pushBack ((d_sm_bonus_vehicle_array # 0) apply {toLowerANSI _x});
d_sm_b_vec_ar_c pushBack ((d_sm_bonus_vehicle_array # 1) apply {toLowerANSI _x});
d_sm_bonus_vehicle_array set [0, d_sm_b_vec_ar_c # 0];
d_sm_bonus_vehicle_array set [1, d_sm_b_vec_ar_c # 1];
d_mt_bonus_vehicle_array set [0, (d_mt_bonus_vehicle_array # 0) apply {toLowerANSI _x}];
d_mt_bonus_vehicle_array set [1, (d_mt_bonus_vehicle_array # 1) apply {toLowerANSI _x}];
#endif

d_x_drop_array =
#ifdef __OWN_SIDE_INDEPENDENT__
	call {
		if (d_pracs) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "PRACS_M998_cargo_open"], [localize "STR_DOM_MISSIONSTRING_20", "Box_NATO_Ammo_F"]]
		};
		[[], [localize "STR_DOM_MISSIONSTRING_22", "I_MRAP_03_F"], [localize "STR_DOM_MISSIONSTRING_20", "Box_IND_Ammo_F"]]
	};
#endif
#ifdef __OWN_SIDE_BLUFOR__
	call {
		if (d_cup) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "CUP_B_M1151_WDL_USA"], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]]
		};
		if (d_rhs) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "rhsusf_m998_w_2dr"], [localize "STR_DOM_MISSIONSTRING_20", "Box_NATO_Ammo_F"]]
		};
		if (d_gmcwg) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", ["gm_ge_army_u1300l_cargo", "gm_ge_army_u1300l_cargo_win"] select d_gmcwgwinter], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]]
		};
		if (d_unsung) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "uns_willys_2"], [localize "STR_DOM_MISSIONSTRING_20", "Box_NATO_Ammo_F"]]
		};
		if (d_vn) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "vn_b_wheeled_m151_01"], [localize "STR_DOM_MISSIONSTRING_20", "vn_b_ammobox_05"]]
		};
		[[], [localize "STR_DOM_MISSIONSTRING_22", ["B_MRAP_01_F", "B_T_LSV_01_unarmed_F"] select (d_tanoa || {d_livonia})], [localize "STR_DOM_MISSIONSTRING_20", "Box_NATO_Ammo_F"]]
	};
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_rhs) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "rhs_tigr_m_3camo_vdv"], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]]
		};
		if (d_ifa3) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "LIB_US_Willys_MB"], [localize "STR_DOM_MISSIONSTRING_20", "LIB_BasicWeaponsBox_SU"]]
		};
		if (d_csla) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "CSLA_AZU_para"], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]]
		}; 
		if (d_pracs) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "PRACS_SLA_Tigr"], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]]
		};
		[[], [localize "STR_DOM_MISSIONSTRING_22", ["O_MRAP_02_F", "O_T_LSV_02_unarmed_F"] select (d_tanoa || {d_livonia})], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]]
	};
#endif
#ifdef __TT__
	[[], [], []];
#endif

// side of the pilot that will fly the drop air vehicle
d_drop_side = d_own_side;

// d_jumpflag_vec = empty ("") means normal jump flags for HALO jump get created
// if you add a vehicle typename to d_jumpflag_vec (d_jumpflag_vec = "B_Quadbike_01_F"; for example) only a vehicle gets created and no HALO jump is available
//d_jumpflag_vec = "B_Quadbike_01_F";
d_jumpflag_vec = "";

d_servicepoint_building = "Land_Cargo_House_V2_F";

#ifndef __VN__
d_illum_tower = "Land_TTowerBig_2_F";
#else
d_illum_tower = "Land_vn_ttowerbig_2_f";
#endif

d_cargotower =
#ifdef __ALTIS__
	"Land_Cargo_Tower_V3_F";
#endif
#ifdef __CUP_CHERNARUS__
	"Land_Cargo_Tower_V1_F";
#endif
#ifdef __CUP_TAKISTAN__
	"Land_Cargo_Tower_V3_F";
#endif
#ifdef __CUP_SARA__
	"Land_Cargo_Tower_V1_F";
#endif
#ifdef __IFA3__
	"";
#endif
#ifdef __TANOA__
	"Land_Cargo_Tower_V4_F";
#endif
#ifdef __STRATIS__
	"Land_Cargo_Tower_V3_F";
#endif
#ifdef __MALDEN__
	"Land_Cargo_Tower_V3_F";
#endif
#ifdef __LIVONIA__
	"Land_Cargo_Tower_V1_F";
#endif
#ifdef __TT__
	"";
#endif
#ifdef __GMCWG__
	"";
#endif
#ifdef __UNSUNG__
	"";
#endif
#ifdef __CSLA__
	"";
#endif
#ifdef __VN__
	"";
#endif
#ifdef __WS__
	"Land_Cargo_Tower_V3_F";
#endif

d_wcamp =
#ifdef __ALTIS__
	"Land_Cargo_Patrol_V1_F";
#endif
#ifdef __CUP_CHERNARUS__
	"Land_Cargo_Patrol_V4_F";
#endif
#ifdef __CUP_TAKISTAN__
	"Land_Cargo_Patrol_V1_F";
#endif
#ifdef __CUP_SARA__
	"Land_Cargo_Patrol_V1_F";
#endif
#ifdef __IFA3__
	"Land_Misc_deerstand";
#endif
#ifdef __TANOA__
	"Land_Cargo_Patrol_V4_F";
#endif
#ifdef __STRATIS__
	"Land_Cargo_Patrol_V1_F";
#endif
#ifdef __MALDEN__
	"Land_Cargo_Patrol_V1_F";
#endif
#ifdef __LIVONIA__
	"Land_Cargo_Patrol_V4_F";
#endif
#ifdef __TT__
	"Land_Cargo_Patrol_V1_F";
#endif
#ifdef __GMCWG__
	"Land_Cargo_Patrol_V4_F";
#endif
#ifdef __UNSUNG__
	"Land_Cargo_Patrol_V4_F";
#endif
#ifdef __CSLA__
	"Land_Cargo_Patrol_V4_F";
#endif
#ifdef __VN__
	"Land_vn_strazni_vez";
#endif
#ifdef __WS__
	"Land_Cargo_Patrol_V1_F";
#endif

#ifndef __VN__
d_mash = "Land_FirstAidKit_01_closed_F";
#else
d_mash = "Land_vn_tent_mash_01_01";
#endif

d_dropped_box_marker = "mil_marker";

d_strongpointmarker = "mil_objective";

d_flag_str_blufor = "\a3\data_f\flags\flag_blue_co.paa";
d_flag_str_opfor = "\a3\data_f\flags\flag_red_co.paa";
d_flag_str_independent = "\a3\data_f\flags\flag_green_co.paa";
if (d_pracs) then {
	d_flag_str_opfor = "\PRACS_SLA_Core\Flags\flag_north_co.paa";
	d_flag_str_independent = "\PRACS_Core\Flags\KingdomofSahrani.paa";
};

d_cargo_chute =
#ifdef __OWN_SIDE_BLUFOR__
	"B_Parachute_02_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
	"O_Parachute_02_F";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"I_Parachute_02_F";
#endif
#ifdef __TT__
	"I_Parachute_02_F";
#endif

d_flag_pole = "FlagPole_F";

d_vec_camo_net =
#ifdef __OWN_SIDE_OPFOR__
	"CamoNet_OPFOR_big_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"CamoNet_BLUFOR_big_F";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"CamoNet_INDP_big_F";
#endif
#ifdef __TT__
	"CamoNet_INDP_big_F";
#endif

// internal
d_sm_winner = 0;
d_objectID1 = objNull;
d_objectID2 = objNull;

// no farps in A3 so we fake them
// first entry should always be a helipad because the trigger which is needed to make it work is spawned there
// second object is also needed, remove action gets added on the second object
#ifndef __VN__
d_farp_classes = ["Land_HelipadSquare_F", "Land_Cargo40_military_green_F"];
#else
d_farp_classes = ["Land_HelipadSquare_F", "vn_us_komex_medium_01"];
#endif

// artillery operators
#ifndef __TT__
d_can_use_artillery = ["d_artop_1", "d_artop_2"]; // case has to be the same as in mission.sqm, d_artop_1 D_ARTOP_1 is not the same :)
#else
d_can_use_artillery = ["d_artop_blufor", "d_artop_opfor"];
#endif

// those units can mark artillery targets but can not call in artillery strikes (only d_can_use_artillery can call in artillery strikes and also mark arty targets)
#ifndef __TT__
d_can_mark_artillery = ["d_alpha_1", "d_bravo_1", "d_charlie_1", "d_echo_1"];
#else
d_can_mark_artillery = ["d_blufor_1", "d_blufor_2", "d_blufor_3", "d_opfor_1", "d_opfor_2", "d_opfor_3"];
#endif

#ifndef __TT__
d_can_call_cas = ["d_alpha_1", "d_bravo_1", "d_charlie_1", "d_echo_1"];
#else
d_can_call_cas = ["d_blufor_1", "d_blufor_2", "d_blufor_3", "d_opfor_1", "d_opfor_2", "d_opfor_3"];
#endif

d_arty_m_marker =
#ifdef __OWN_SIDE_OPFOR__
	"o_art";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"b_art";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"n_art";
#endif
#ifdef __TT__
	"n_art";
#endif

d_color_m_marker =
#ifdef __OWN_SIDE_OPFOR__
	"ColorEAST";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"ColorWEST";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"ColorGUER";
#endif
#ifdef __TT__
	"ColorGUER";
#endif

d_non_steer_para = "NonSteerable_Parachute_F";

call {
	if (d_own_side == "WEST") exitWith {
		call {
			if (d_vn) exitWith {
				d_the_box = "vn_b_ammobox_04";
				d_the_base_box = "vn_b_ammobox_06";
			};
			d_the_box = "Box_NATO_Wps_F";
			d_the_base_box = "B_supplyCrate_F";
		};
	};
	if (d_own_side == "EAST") exitWith {
		d_the_box = "Box_East_Wps_F";
		d_the_base_box = "O_supplyCrate_F";
	};
	d_the_box = "Box_IND_Wps_F";
	d_the_base_box = "I_supplyCrate_F";
};

private _confmapsize = call {
	if (markerPos "d_whole_island" isNotEqualTo [0,0,0]) exitWith {
		private _ret = (markerSize "d_whole_island" # 0) * 2;
		deleteMarkerLocal "d_whole_island";
		_ret
	};
	if (worldName == "cup_chernarus_A3") exitWith {
		worldSize
	};
	getNumber(configFile>>"CfgWorlds">>worldName>>"mapSize")
};
if (_confmapsize == 0) then {_confmapsize = worldSize};
d_island_center = [_confmapsize / 2, _confmapsize / 2, 300];

d_island_x_max = _confmapsize;
d_island_y_max = _confmapsize;

private _wname = toLowerANSI worldName;
d_iscup_island = _wname in ["chernarus_summer", "chernarus_winter", "chernarus", "eden", "abel", "noe", "sara", "takistan", "sara_dbe1", "zargabad"] || {(_wname select [0, 4]) isEqualTo "cup_"};

if (isServer) then {
	d_player_hash = createHashMap;
	d_misc_s_hash = createHashMap;
	d_placed_objs_hash = createHashMap;
	d_placed_objs_hash2 = createHashMap;
	d_placed_objs_hash3 = createHashMap;
	d_placed_objs_hash4 = createHashMap;

	d_hc_array = [];
	d_hc_counter = 0;
	d_retaken_farpspos = [];

	d_with_ace = isClass (configFile>>"CfgPatches">>"ace_main");
	publicVariable "d_with_ace";
	diag_log ["Dom d_with_ace:", d_with_ace];
	d_database_found = false;
	d_sql_database = false;
	d_db_type = -1; // 0 = extDB3, 1 = InterceptDB, 2 = missionProfileNamespace
	
	d_delete_marker_meh = [];
	
	d_c_t_e_u_b = false;
	d_last_admin_mt_end = -1;

	if (isMultiplayer) then {
		if (isClass (configFile >> "Intercept" >> "Dedmen" >> "intercept_database")) then {
			diag_log "DOM InterceptDB class found!";
			 if (isFilePatchingEnabled) then {
				diag_log "DOM FilePatching needed for InterceptDB IS enabled!";
				if (fileExists "@InterceptDB\domination.sqf") then {
					diag_log "DOM InterceptDB domination.sqf file found!";
					call compile preprocessFileLineNumbers "@InterceptDB\domination.sqf";
				} else {
					diag_log "DOM InterceptDB domination.sqf file NOT found! Needs to be in the IntercepDB addon folder!";
				};
			}else {
				diag_log "DOM FilePatching needed for InterceptDB not enabled!";
			};
		} else {
			diag_log "DOM InterceptDB class not found!";
		};
	};
	if (isNil "d_interceptdb") then {
		diag_log "DOM InterceptDB d_interceptdb is nil";
		d_interceptdb = false
	};
	if (d_interceptdb) then {
		call d_fnc_createdbconn;
		diag_log ["Dom Intercept DB created:", D_DB_CON];
		d_database_found = true;
		d_sql_database = true;
		d_db_type = 1;
	} else {
		private _isextdb3loaded = false;
		if (!isNil "extDB3_var_loaded") then {
			_isextdb3loaded = if (extDB3_var_loaded isEqualType {}) then {
				call extDB3_var_loaded
			} else {
				extDB3_var_loaded
			};
		};
		diag_log ["DOM extDB3 _isextdb3loaded:", _isextdb3loaded];
		if (_isextdb3loaded) then {
			d_db_type = 0;
			private _uins = uiNamespace getVariable "d_database_init";
			if (isNil "_uins") then {
				private _result = "extdb3" callExtension "9:ADD_DATABASE:Domination";
				diag_log ["Dom Database result loading:", _result];
				if (_result != "[1]" && {_result != "[0,""Already Connected to Database""]"}) exitWith {};
				_result = "extdb3" callExtension "9:ADD_DATABASE_PROTOCOL:Domination:SQL_CUSTOM:dom:domination-custom.ini";
				diag_log ["Dom Database result custom ini:", _result];
				if (_result != "[1]" && {_result != "[0,""Error Protocol Name Already Taken""]"}) exitWith {};
				"extDB3" callExtension "9:LOCK";
				uiNamespace setVariable ["d_database_init", true];
			};
			d_database_found = true;
			d_sql_database = true;
		};
	};
	
	diag_log ["DOM d_sql_database:", d_sql_database];

	if (d_sql_database) then {
		d_use_sql_settings = false;

		private _dbresult = [];
		call {
			if (d_db_type == 0) exitWith {
				_dbresult = parseSimpleArray ("extdb3" callExtension "0:dom:getDomSettings");
				if (_dbresult # 0 != 1) then {
					_dbresult = [];
				} else {
					_dbresult = _dbresult # 1;
				};
			};
			if (d_db_type == 1) exitWith {
				_dbresult = ["getDomSettings"] call d_fnc_queryconfig;
			};
		};
		__TRACE_1("getDomSettings","_dbresult")
		diag_log "Dom Database result loading dom_settings:";
		{
			diag_log _x;
		} forEach _dbresult;
		if (_dbresult isNotEqualTo []) then {
			{
				call {
					private _tla = toLowerANSI (_x # 0);
					if (_tla in ["d_reserved_slot", "d_uid_reserved_slots", "d_uids_for_reserved_slots", "d_uids_def_choppers"]) exitWith {
						if ((_x # 1) isNotEqualTo []) then {
							missionNamespace setVariable [_x # 0, _x # 1, true];
						};
					};
					if (_tla in ["d_use_sql_settings", "d_db_auto_save", "d_cas_available_time", "d_ai_groups_respawn_time", "d_addscore_a", "d_number_attack_planes", "d_number_attack_choppers", "d_number_light_attack_choppers", "d_number_attack_uavs", "d_noambient_bf_sounds", "d_time_until_next_sidemission", "d_sm_vec_weighting"]) exitWith {
						missionNamespace setVariable [_x # 0, _x # 1];
					};
					if (_tla in ["d_set_pl_score_db", "d_ranked_a", "d_points_needed", "d_points_needed_db", "d_launcher_cooldown"]) exitWith {
						missionNamespace setVariable [_x # 0, _x # 1, true];
					};
#ifdef __TT__
					if (_x # 0 == "d_tt_points") exitWith {
						missionNamespace setVariable [_x # 0, _x # 1, true];
					};
#endif
				};
			} forEach _dbresult;
		};

		if (!isMultiplayer && {isNil "paramsArray"}) then {
			paramsArray = [];
		};

		if (d_use_sql_settings) then {
			diag_log ["DOM database d_use_sql_settings", d_use_sql_settings];
			call {
				if (d_db_type == 0) exitWith {
					_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:getDomParams2:%1", __DOMDBPARAMNAME]);
					if (_dbresult # 0 != 1) then {
						_dbresult = [];
					} else {
						_dbresult = _dbresult # 1;
					};
				};
				if (d_db_type == 1) exitWith {
					_dbresult = ["getDomParams2", [__DOMDBPARAMNAME]] call d_fnc_queryconfig;
				};
			};
			__TRACE_1("getDomParams2","_dbresult")
			diag_log "Dom Database result standard params:";
			{
				diag_log _x;
			} forEach _dbresult;
			if (_dbresult isNotEqualTo []) then {
				if (isClass (getMissionConfig "Params")) then {
					private _conf = getMissionConfig "Params";
					if (paramsArray isEqualTo []) then {
						paramsArray resize (count _conf);
					};
					for "_i" from 0 to (count _conf - 1) do {
						private _cname = configName (_conf select _i);
						__TRACE_1("","_cname")
						private _fidx = _dbresult findIf {_x # 0 == _cname};
						__TRACE_1("","_fidx")
						if (_fidx != -1) then {
							private _val = _dbresult # _fidx # 1;
							if (_val == 0 && {_cname in ["xr_max_lives", "d_MainTargets_num", "d_ai_awareness_rad", "d_ai_pursue_rad", "d_max_camp_cnt", "d_score_needed_to_fly", "d_ai_awareness_rad", "d_ai_pursue_rad", "d_max_camp_cnt"]}) then {
								_val = -1;
							};
							__TRACE_1("","_val")
							paramsArray set [_i, _val];
						};
					};
					publicVariable "paramsArray";
				};
			} else {
				if (isClass (getMissionConfig "Params")) then {
					private _conf = getMissionConfig "Params";
					for "_i" from 0 to (count _conf - 1) do {
						private _paramName = configName (_conf select _i);
						private _paramval = getNumber (_conf>>_paramName>>"default");
						if (_paramval != -66) then {
							call {
								if (d_db_type == 0) exitWith {
									"extdb3" callExtension format ["1:dom:domParamsInsertN:%1:%2:%3", __DOMDBPARAMNAME, _paramName, _paramval];
								};
								if (d_db_type == 1) exitWith {
									["domParamsInsertN", [__DOMDBPARAMNAME, _paramName, _paramval]] call d_fnc_queryconfigasync;
								};
							};
						};
					};
				};
			};
		};
		if (!isMultiplayer && {!isNil "paramsArray"}) then {
			paramsArray = nil;
		};
	};
	
	call compileScript ["init\initcommon.sqf", false];
	
	if (!d_sql_database && {d_save_to_mpns > 0}) then {
		d_database_found = true;
		d_db_type = 2;
	};
	publicVariable "d_database_found";
	diag_log ["DOM d_database_found:", d_database_found, "d_db_type:", d_db_type];

	d_house_objects = [];
	d_house_objects2 = [];

	calculatePlayerVisibilityByFriendly false;

	if (d_weather == 0) then {
		0 setOvercast ([random 1, random 0.49] select d_ws);
		if (d_ws) then {
			d_enable_fog = 1;
		};
		if (d_enable_fog == 0) then {
			private _fog = if (random 100 > 90) then {
				[random 0.1, 0.1, 20 + (random 40)]
			} else {
				[0,0,0]
			};
			__TRACE_1("","_fog")
			0 setFog _fog;
		} else {
			0 setFog [0, 0, 0];
			0 spawn {
				scriptName "spawn_preinitfog";
				sleep 100;
				0 setFog [0, 0, 0];
			};
		};
		if (d_WithWinterWeather == 0) then {
			d_winterw = [0, [2, 1] select (rain <= 0.3)] select (overcast > 0.5);
			publicVariable "d_winterw";
		};
	} else {
		0 setFog [0, 0, 0];
		0 setOvercast 0;
		0 spawn {
			scriptName "spawn_preinitovercast";
			while {true} do {
				sleep 100;
				0 setOvercast 0;
				0 setFog [0, 0, 0];
			};
		};
	};
	forceWeatherChange;

	if (d_timemultiplier > 1) then {
		setTimeMultiplier d_timemultiplier;
	} else {
		0 spawn d_fnc_nightmultiplier;
	};

	d_fifo_ar = [];

	// _E = Opfor
	// _W = Blufor
	// _G = Independent
	// this is what gets spawned
	d_allmen_E = [
#ifdef __ALTIS__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_allmen_O_tanoa.sqf"
#endif
#ifdef __GMCWG__
if (!d_gmcwgwinter) then {
#include "d_allmen_O_gmcwg.sqf"
} else {
#include "d_allmen_O_gmcwgw.sqf"
}
#endif
#ifdef __CUP_CHERNARUS__
#include "d_allmen_O_CUP_CHER.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "d_allmen_O_CUP_TAKI.sqf"
#endif
#ifdef __CUP_SARA__
#include "d_allmen_O_CUP_SLA.sqf"
#endif
#ifdef __IFA3__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __TTALTIS__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __TTTANOA__
#include "d_allmen_O_tanoa.sqf"
#endif
#ifdef __TANOA__
#include "d_allmen_O_tanoa.sqf"
#endif
#ifdef __STRATIS__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __MALDEN__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __TTMALDEN__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __VN__
#include "d_allmen_O_vn.sqf"
#endif
#ifdef __UNSUNG__
#include "d_allmen_O_uns.sqf"
#endif
#ifdef __CSLA__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __WS__
#include "d_allmen_O_ws.sqf"
#endif
	];
	
	call {
		if (d_ifa3) exitWith {
			d_allmen_W = [
				#include "d_allmen_B_ifa3.sqf"
			];
		};
		if (d_rhs) exitWith {
			d_allmen_W = [
				#include "d_allmen_B_RHS.sqf"
			];
			d_allmen_E = [
				#include "d_allmen_O_RHS.sqf"
			];
		};
		if (d_csla) exitWith {
			d_allmen_W = [
				#include "d_allmen_B_CSLA.sqf"
			];
		}; 
		if (d_pracs) exitWith {
			d_allmen_E = [
				#include "d_allmen_O_PRACS.sqf"
			];
		};
		d_allmen_W = [
			#include "d_allmen_B_default.sqf"
		];
	};

#ifdef __IFA3__
	{
		if (count _x > 6) then {
			private _ran = floor random 7;
			if (_ran < 4) then {_ran = 4};
			_x resize _ran;
		};
	} forEach d_allmen_W;
#endif

	d_allmen_G = [
#ifdef __ALTIS__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __GMCWG__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __CUP_CHERNARUS__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __CUP_SARA__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __IFA3__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __TTALTIS__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __TTTANOA__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __TANOA__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __STRATIS__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __TTMALDEN__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __UNSUNG__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __VN__
#include "d_allmen_G_vn.sqf"
#endif
#ifdef __CSLA__
#include "d_allmen_G_default.sqf"
#endif
#ifdef __WS__
#include "d_allmen_G_default.sqf"
#endif
	];

	d_specops_E = [
#ifdef __ALTIS__
#include "d_specops_O_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_specops_O_livonia.sqf"
#endif
#ifdef __GMCWG__
if (!d_gmcwgwinter) then {
#include "d_specops_O_gmcwg.sqf"
} else {
#include "d_specops_O_gmcwgw.sqf"
}
#endif
#ifdef __CUP_CHERNARUS__
#include "d_specops_O_CUP_CHER.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "d_specops_O_CUP_TAKI.sqf"
#endif
#ifdef __CUP_SARA__
if (!d_pracs) then {
#include "d_specops_O_CUP_SLA.sqf"
} else {
#include "d_specops_O_PRACS.sqf"
}
#endif
#ifdef __IFA3__
#include "d_specops_O_default.sqf"
#endif
#ifdef __TTALTIS__
#include "d_specops_O_default.sqf"
#endif
#ifdef __TTTANOA__
#include "d_specops_O_tanoa.sqf"
#endif
#ifdef __TANOA__
#include "d_specops_O_tanoa.sqf"
#endif
#ifdef __STRATIS__
#include "d_specops_O_default.sqf"
#endif
#ifdef __MALDEN__
#include "d_specops_O_default.sqf"
#endif
#ifdef __TTMALDEN__
#include "d_specops_O_default.sqf"
#endif
#ifdef __UNSUNG__
#include "d_specops_O_uns.sqf"
#endif
#ifdef __VN__
#include "d_specops_O_vn.sqf"
#endif
#ifdef __CSLA__
#include "d_specops_O_default.sqf"
#endif
#ifdef __WS__
	["O_SFIA_Soldier_TL_lxWS","O_SFIA_exp_lxWS","O_SFIA_exp_lxWS","O_SFIA_medic_lxWS","O_SFIA_Soldier_GL_lxWS","O_SFIA_soldier_at_lxWS"]
#endif
	];

#ifdef __GMCWG__
	{
		if (count _x > 5) then {
			_x resize 5
		};
	} forEach d_specops_E;
#endif

	d_specops_W = call {
		if (d_rhs) exitWith {
			[["West","rhs_faction_socom_marsoc","rhs_group_nato_marsoc_infantry","rhs_group_nato_marsoc_infantry_squad"] call d_fnc_GetConfigGroup, ["West","rhs_faction_socom_marsoc","rhs_group_nato_marsoc_infantry","rhs_group_nato_marsoc_infantry_team"] call d_fnc_GetConfigGroup]
		};
		if (d_ifa3) exitWith {
			[["West","SG_STURM","Infantry","SG_GER_AT_squad"] call d_fnc_GetConfigGroup, ["West","SG_STURM","Infantry","SG_GER_infantry_squad"] call d_fnc_GetConfigGroup]
		};
		if (d_csla) exitWith {
			[["West","US85","US85_SpecForUnits","US85_sfSqd"] call d_fnc_GetConfigGroup]
		}; 
		[["West","BLU_F","Infantry","BUS_ReconTeam"] call d_fnc_GetConfigGroup,["West","BLU_F","Infantry","BUS_ReconSquad"] call d_fnc_GetConfigGroup]
	};

	if (!d_ws) then {
		if (d_tanoa || {d_livonia}) then {
			d_sniper_E = [["East","OPF_T_F","Infantry","O_T_SniperTeam"] call d_fnc_GetConfigGroup,["O_T_ghillie_tna_F","O_T_ghillie_tna_F"],["O_ghillie_lsh_F","O_ghillie_lsh_F"]];
			d_sniper_W = [["West","BLU_T_F","Infantry","B_T_SniperTeam"] call d_fnc_GetConfigGroup,["B_T_ghillie_tna_F","B_T_ghillie_tna_F"],["B_ghillie_lsh_F","B_ghillie_lsh_F"]];
			d_sniper_G = [["Indep","IND_F","Infantry","HAF_SniperTeam"] call d_fnc_GetConfigGroup];
		} else {
			d_sniper_E = [["East","OPF_F","Infantry","OI_SniperTeam"] call d_fnc_GetConfigGroup,["O_ghillie_ard_F","O_ghillie_ard_F"],["O_ghillie_lsh_F","O_ghillie_lsh_F"],["O_ghillie_sard_F","O_ghillie_sard_F"]];
			d_sniper_W = [["West","BLU_F","Infantry","BUS_SniperTeam"] call d_fnc_GetConfigGroup,["B_ghillie_ard_F","B_ghillie_ard_F"],["B_ghillie_lsh_F","B_ghillie_lsh_F"],["B_ghillie_sard_F","B_ghillie_sard_F"]];
			d_sniper_G = [["Indep","IND_F","Infantry","HAF_SniperTeam"] call d_fnc_GetConfigGroup];
		};
	} else {
		d_sniper_E = [["O_SFIA_sharpshooter_lxWS","O_SFIA_sharpshooter_lxWS"]];
	};

#ifdef __RHS__
	d_specops_E = [
		["East","rhs_faction_vmf","rhs_group_rus_vmf_infantry_recon","rhs_group_rus_vmf_infantry_recon_squad"] call d_fnc_GetConfigGroup, ["East","rhs_faction_vmf","rhs_group_rus_vmf_infantry_recon","rhs_group_rus_vmf_infantry_recon_squad_2mg"] call d_fnc_GetConfigGroup,
		["East","rhs_faction_vmf","rhs_group_rus_vmf_infantry_recon","rhs_group_rus_vmf_infantry_recon_squad_sniper"] call d_fnc_GetConfigGroup, ["East","rhs_faction_vmf","rhs_group_rus_vmf_infantry_recon","rhs_group_rus_vmf_infantry_recon_squad_mg_sniper"] call d_fnc_GetConfigGroup
	];
#endif
	d_specops_G = [["I_G_Soldier_exp_F", "I_Soldier_exp_F", "I_G_Soldier_GL_F", "I_G_medic_F"]];

	d_sabotage_E = [["O_recon_exp_F"]];
	d_sabotage_W = [["B_recon_exp_F"]];
	d_sabotage_G = [["I_diver_exp_F"]];
#ifdef __CUP__
	d_sabotage_E = [["CUP_O_RUS_Saboteur_Autumn", "CUP_O_RUS_SpecOps_Autumn"]];
	d_sabotage_W = [["CUP_B_US_SpecOps", "CUP_B_FR_Soldier_Exp"]];
	d_sabotage_G = [["CUP_I_GUE_Saboteur"]];
#endif
#ifdef __RHS__
	d_sabotage_E = [["rhs_vmf_recon_rifleman_scout_akm", "rhs_vmf_recon_sergeant"]];
	d_sabotage_W = [["rhsusf_socom_marsoc_cso_breacher", "rhsusf_socom_marsoc_cso"]];
	d_sabotage_G = [["CUP_I_GUE_Saboteur"]];
#endif
#ifdef __GMCWG__
	d_sabotage_E = [[["gm_gc_army_demolition_mpiaks74n_80_str"], ["gm_gc_army_demolition_mpiaks74n_80_win"]] select d_gmcwgwinter];
	d_sabotage_W = [["gm_ge_army_demolition_g3a4_80_ols"]];
	d_sabotage_G = [["CUP_I_GUE_Saboteur"]];

	d_sniper_E = [[["gm_gc_army_squadleader_mpiak74n_80_str", "gm_gc_army_rifleman_mpiak74n_80_str"], ["gm_gc_army_squadleader_mpiak74n_80_win", "gm_gc_army_rifleman_mpiak74n_80_win"]] select d_gmcwgwinter];
	d_sniper_W = [[["gm_ge_army_squadleader_g3a3_p2a1_80_ols", "gm_ge_army_rifleman_g3a3_80_ols"], ["gm_ge_army_squadleader_g3a3_p2a1_parka_80_win", "gm_ge_army_rifleman_g3a3_parka_80_win"]] select d_gmcwgwinter];
#endif

#ifdef __CUP_CHERNARUS__
	d_sniper_E = [["East","CUP_O_RU","Infantry_VDV_EMR","CUP_O_RU_SniperTeam_VDV_EMR"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","CUP_B_USMC","Infantry","CUP_B_USMC_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","CUP_I_NAPA","Infantry","CUP_I_NAPA_GrpInf_TeamSniper"] call d_fnc_GetConfigGroup];
#endif
#ifdef __CUP_TAKISTAN__
	d_sniper_E = [["East","CUP_O_TK","Infantry","CUP_O_TK_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","CUP_B_US_Army","Infantry","CUP_B_US_Army_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","CUP_I_TK_GUE","Infantry","CUP_I_TK_GUE_SniperTeam"] call d_fnc_GetConfigGroup];
#endif
#ifdef __CUP_SARA__
	d_sniper_E = [["East","CUP_O_SLA","Infantry_Desert","CUP_O_SLA_SniperTeam_Desert"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","CUP_B_US_Army","Infantry","CUP_B_US_Army_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","CUP_I_RACS","Infantry","CUP_I_RACS_SniperTeam"] call d_fnc_GetConfigGroup];
#endif
#ifdef __IFA3__
	d_sniper_E = [["East","LIB_RKKA","Infantry","LIB_SOV_sniper_team"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","LIB_WEHRMACHT","Infantry","LIB_GER_sniper_team"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","LIB_US_ARMY","Infantry","LIB_US_Sniper_Team"] call d_fnc_GetConfigGroup];
#endif
#ifdef __RHS__
	d_sniper_E = [["East","rhs_faction_vmf","rhs_group_rus_vmf_infantry_recon","rhs_group_rus_vmf_infantry_recon_squad_sniper"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad_sniper"] call d_fnc_GetConfigGroup];
	d_sniper_G = [["Indep","rhssaf_faction_army","rhssaf_group_army_m10_digital_infantry","rhssaf_group_army_m10_digital_infantry_squad_sniper"] call d_fnc_GetConfigGroup];
#endif
#ifdef __UNSUNG__
	d_sniper_E = [["uns_men_VC_mainforce_Rmrk", "uns_men_VC_mainforce_Roff"]];
	d_sabotage_E = [["uns_men_VC_mainforce_68_Roff","uns_men_VC_mainforce_68_Ra1", "uns_men_VC_mainforce_68_Ra2", "uns_men_VC_mainforce_68_Rmg"]];
#endif
#ifdef __VN__
	d_sniper_E = [["vn_o_men_nva_10", "vn_o_men_nva_24"], ["vn_o_men_vc_local_31", "vn_o_men_vc_local_10"]];
	d_sabotage_E = [["vn_o_men_nva_09","vn_o_men_nva_23"]];
	d_sabotage_G = [["vn_i_men_ranger_05"], ["vn_i_men_sf_05"]];
	d_specops_G = [
		["Indep","VN_ARVN","vn_i_group_men_sf","vn_i_group_men_sf_01"] call d_fnc_GetConfigGroup,
		["Indep","VN_ARVN","vn_i_group_men_sf","vn_i_group_men_sf_02"] call d_fnc_GetConfigGroup,
		["Indep","VN_ARVN","vn_i_group_men_sf","vn_i_group_men_sf_03"] call d_fnc_GetConfigGroup
	];
#endif
#ifdef __CSLA__
	d_sabotage_W = [["West","US85","US85_SpecForUnits","US85_sfSqd"] call d_fnc_GetConfigGroup];
	
	d_sniper_W = [["US85_sfM21G", "US85_sfSptG"]];
#endif
#ifdef __WS__
d_sabotage_E = [["O_SFIA_exp_lxWS"]];
#endif
#ifdef __PRACS__
	d_sabotage_E = [["PRACS_SLA_Especas_ENG", "PRACS_SLA_Especas_Ninja_ENG"]];
	d_sabotage_W = [["CUP_B_US_SpecOps", "CUP_B_FR_Soldier_Exp"]];
	d_sabotage_G = [["PRACS_Commando_ENG", "PRACS_Paratrooper_ENG", "PRACS_QSB_ENG"]];
	d_sniper_E = [["East","pracs_sla_groups","pracs_sla_especas_group_light","pracs_sla_especas_group_SHPS"] call d_fnc_GetConfigGroup, ["East","pracs_sla_groups","pracs_sla_infantry_group_light","pracs_sla_infantry_group_SHPS"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","CUP_B_US_Army","Infantry","CUP_B_US_Army_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","PRACS_RACS_GROUPS","pracs_1st_infantry_group","pracs_1st_infantry_group_SHPS"] call d_fnc_GetConfigGroup, ["Indep","PRACS_RACS_GROUPS","pracs_commando_squads","pracs_Commando_Sniper_Team"] call d_fnc_GetConfigGroup];
#endif

	d_veh_a_E = [
#ifdef __ALTIS__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_veh_a_O_tanoa.sqf"
#endif
#ifdef __GMCWG__
#include "d_veh_a_O_gmcwg.sqf"
#endif
#ifdef __CUP_CHERNARUS__
#include "d_veh_a_O_CUP_CHER.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "d_veh_a_O_CUP_TAKI.sqf"
#endif
#ifdef __CUP_SARA__
#include "d_veh_a_O_CUP_SARA.sqf"
#endif
#ifdef __IFA3__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __TTALTIS__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __TTMALDEN__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __TTTANOA__
#include "d_veh_a_O_tanoa.sqf"
#endif
#ifdef __TANOA__
#include "d_veh_a_O_tanoa.sqf"
#endif
#ifdef __STRATIS__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __MALDEN__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __UNSUNG__
#include "d_veh_a_O_uns.sqf"
#endif
#ifdef __VN__
#include "d_veh_a_O_vn.sqf"
#endif
#ifdef __CSLA__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __WS__
#include "d_veh_a_O_ws.sqf"
#endif
	];

#ifdef __GMCWG__
	if (d_gmcwgwinter) then {
		d_veh_a_E = [
			#include "d_veh_a_O_gmcwgwin.sqf"
		];
	};
#endif
	d_veh_a_W = [
#ifndef __IFA3__
		#include "d_veh_a_B_default.sqf"
#else
		#include "d_veh_a_B_ifa3.sqf"
#endif
	];
#ifdef __RHS__
	d_veh_a_W = [
		#include "d_veh_a_B_RHS.sqf"
	];
	d_veh_a_E = [
		#include "d_veh_a_O_RHS.sqf"
	];
#endif
#ifdef __CSLA__
	d_veh_a_W = [
		#include "d_veh_a_B_CSLA.sqf"
	];
#endif
#ifdef __PRACS__
	d_veh_a_E = [
		#include "d_veh_a_O_PRACS.sqf"
	];
#endif

	d_veh_a_G = [
		#include "d_veh_a_G_default.sqf"
	];

#ifdef __ALTIS__
	d_arti_observer_E = [["O_recon_JTAC_F"]];
#endif
#ifdef __LIVONIA__
	d_arti_observer_E = [["O_T_Recon_JTAC_F"]];
#endif
#ifdef __GMCWG__
	d_arti_observer_E = [[["gm_gc_army_squadleader_mpiak74n_80_str"], ["gm_gc_army_squadleader_mpiak74n_80_win"]] select d_gmcwgwinter];
#endif
#ifdef __CUP_CHERNARUS__
	d_arti_observer_E = [["CUP_O_RUS_SpecOps_Scout_Autumn"]];
#endif
#ifdef __CUP_TAKISTAN__
	d_arti_observer_E = [["CUP_O_RUS_SpecOps_Scout_Autumn"]];
#endif
#ifdef __CUP_SARA__
	d_arti_observer_E = [["CUP_O_sla_Officer"]];
#endif
#ifdef __IFA3__
	d_arti_observer_E = [["O_recon_JTAC_F"]];
#endif
#ifdef __TANOA__
	d_arti_observer_E = [["O_T_Recon_JTAC_F"]];
#endif
#ifdef __STRATIS__
	d_arti_observer_E = [["O_recon_JTAC_F"]];
#endif
#ifdef __MALDEN__
	d_arti_observer_E = [["O_recon_JTAC_F"]];
#endif
#ifndef __IFA3__
	d_arti_observer_W = [["B_recon_JTAC_F"]];
#else
	d_arti_observer_W = [["LIB_GER_ober_lieutenant"]];
#endif
#ifdef __RHS__
	d_arti_observer_W = [["rhsusf_army_ocp_jfo"], ["rhsusf_army_ucp_fso"], ["rhsusf_usmc_marpat_d_fso"], ["rhsusf_usmc_marpat_d_jfo"]];
	d_arti_observer_E = [["rhs_vmf_recon_rifleman_scout_akm"], ["rhs_vmf_recon_rifleman_scout"]];
#endif
#ifdef __UNSUNG__
	d_arti_observer_E = [["uns_men_VC_mainforce_68_RTO"]];
#endif
#ifdef __VN__
	d_arti_observer_E = [["vn_o_men_nva_01","vn_o_men_nva_65_01"]];
#endif
#ifdef __CSLA__
	d_arti_observer_W = [["US85_mcRTO"]];
#endif
#ifdef __WS__
	d_arti_observer_E = [["O_Tura_watcher_lxWS"]];
#endif

	d_arti_observer_G = [["I_Soldier_TL_F"]];

#ifdef __PRACS__
	d_arti_observer_E = [["PRACS_SLA_Naval_Infantry_RTO","PRACS_SLA_Paratrooper_RTO","PRACS_SLA_Infantry_RTO"]];
	d_arti_observer_G = [["PRACS_Royal_Marine_RTO","PRACS_Paratrooper_RTO","PRACS_Infantry_RTO"]];
#endif

	if (isNil "d_number_attack_planes") then {
		d_number_attack_planes = 1;
	};
	if (isNil "d_number_attack_choppers") then {
		d_number_attack_choppers = 1;
	};
	if (isNil "d_number_light_attack_choppers") then {
		d_number_light_attack_choppers = 1;
	};
	if (isNil "d_number_attack_uavs") then {
		d_number_attack_uavs = 1;
	};
#ifdef __ALTIS__
	d_divers_E = [["East","OPF_F","SpecOps","OI_diverTeam"] call d_fnc_GetConfigGroup];
#endif
#ifdef __MALDEN__
	d_divers_E = [["East","OPF_F","SpecOps","OI_diverTeam"] call d_fnc_GetConfigGroup];
#endif

	// Type of aircraft, that will air drop stuff
	d_drop_aircraft =
#ifdef __OWN_SIDE_INDEPENDENT__
		call {
			if (d_pracs) exitWith {
				"PRACS_C130"
			};
			"I_Heli_Transport_02_F"
		};
#endif
#ifdef __OWN_SIDE_BLUFOR__
		call {
			if (d_cup) exitWith {
				"CUP_B_C130J_Cargo_USMC"
			};
			if (d_gmcwg) exitWith {
				if (d_gmcwgwinter) exitWith {
					"gm_ge_airforce_do28d2_un"
				};
				"gm_ge_airforce_do28d2"
			};
			if (d_rhs) exitWith {
				"RHS_C130J"
			};
			if (d_unsung) exitWith {
				"uns_C130_H"
			};
			if (d_vn) exitWith {
				"vn_b_air_ch34_01_01"
			};
			if (d_ifa3) exitWith {
				""
			};
			if (d_ws) exitWith {
				"B_D_Heli_Transport_01_lxWS"
			};
			"B_Heli_Transport_01_camo_F"
		};
#endif
#ifdef __OWN_SIDE_OPFOR__
		call {
			if (d_ifa3) exitWith {
				"LIB_Pe2"
			};
			if (d_rhs) exitWith {
				"RHS_Mi8mt_Cargo_vv"
			};
			if (d_csla) exitWith {
				"CSLA_Mi17"
			}; 
			if (d_gmcwg) exitWith {
				""
			};
			if (d_cup) exitWith {
				""
			};
			if (d_pracs) exitWith {
				"PRACS_AN12B"
			};
			"O_Heli_Light_02_unarmed_F"
		};
#endif
#ifdef __TT__
		"O_Heli_Light_02_unarmed_F";
#endif

	if (d_drop_aircraft == "") then {
		d_drop_aircraft_avail = false;
		publicVariable "d_drop_aircraft_avail";
	};

	d_cas_plane =
#ifdef __OWN_SIDE_INDEPENDENT__
		call {
			if (d_pracs) exitWith {
				"PRACS_A4M"
			};
			"I_Plane_Fighter_03_CAS_F"
		};
#endif
#ifdef __OWN_SIDE_BLUFOR__
		call {
			if (d_cup) exitWith {
				"CUP_B_A10_CAS_USA"
			};
			if (d_gmcwg) exitWith {
				""
			};
			if (d_unsung) exitWith {
				"uns_A1J_CAS"
			};
			if (d_rhs) exitWith {
				"RHS_A10"
			};
			if (d_vn) exitWith {
				"vn_b_air_f4c_ucas"
			};
			if (d_ws) exitWith {
				"B_D_Plane_CAS_01_dynamicLoadout_lxWS"
			};
			"B_Plane_CAS_01_F"
		};
#endif
#ifdef __OWN_SIDE_OPFOR__
		call {
			if (d_ifa3) exitWith {
				"LIB_P47"
			};
			if (d_rhs) exitWith {
				"RHS_Su25SM_vvsc"
			};
			if (d_csla) exitWith {
				""
			}; 
			if (d_pracs) exitWith {
				"PRACS_SLA_MiG27"
			};
			"O_Plane_CAS_02_F"
		};
#endif
#ifdef __TT__
		["B_Plane_CAS_01_F", "O_Plane_CAS_02_F"];
#endif

#ifndef __TT__
	if (d_cas_plane == "") then {
#else
	if (d_cas_plane isEqualTo []) then {
#endif
		d_cas_plane_avail = false;
		publicVariable "d_cas_plane_avail";
	};

	// can now also be an array
	d_cas_plane_ai =
#ifdef __OWN_SIDE_INDEPENDENT__
		call {
			if (d_pracs) exitWith {
				"PRACS_SLA_MiG27"
			};
			""
		};
#endif
#ifdef __OWN_SIDE_BLUFOR__
		call {
			if (d_ifa3) exitWith {
				"LIB_P47"
			};
			if (d_cup) exitWith {
				"CUP_O_Su25_Dyn_RU"
			};
			if (d_gmcwg) exitWith {
				""
			};
			if (d_unsung) exitWith {
				"uns_Mig21_CAS"
			};
			if (d_rhs) exitWith {
				"RHS_Su25SM_vvsc"
			};
			if (d_vn) exitWith {
				"vn_o_air_mig19_cas"
			};
			"O_Plane_CAS_02_F"
		};
#endif
#ifdef __OWN_SIDE_OPFOR__
		call {
			if (d_ifa3) exitWith {
				"LIB_Ju87"
			};
			if (d_cup) exitWith {
				"CUP_B_A10_CAS_USA"
			};
			if (d_csla) exitWith {
				""
			};
			if (d_rhs) exitWith {
				"RHS_A10"
			};
			if (d_pracs) exitWith {
				"PRACS_A4M"
			};
			"B_Plane_CAS_01_F"
		};
#endif
#ifdef __TT__
		"I_Plane_Fighter_03_CAS_F";
#endif

	d_sm_speedboat = call {
		if (d_enemy_side_short == "E") exitWith {
			call {
				if (d_cup) exitWith {
					""
				};
				if (d_gmcwg) exitWith {
					""
				};
				if (d_rhs) exitWith {
					""
				};
				if (d_unsung) exitWith {
					"UNS_ASSAULT_BOAT_VC"
				};
				if (d_ifa3) exitWith {
					""
				};
				if (d_vn) exitWith {
					"vn_o_boat_03_02"
				};
				if (d_ws) exitWith {
					"vn_o_boat_03_02"
				};
				if (d_pracs) exitWith {
					"PRACS_SLA_GoFast_gun"
				};
				"O_Boat_Armed_01_hmg_F"
			};
		};
		if (d_enemy_side_short == "W") exitWith {
			call {
				if (d_cup) exitWith {
					"CUP_B_RHIB_USMC"
				};
				if (d_ifa3) exitWith {
					""
				};
				if (d_rhs) exitWith {
					""
				};
				if (d_gmcwg) exitWith {
					""
				};
				if (d_csla) exitWith {
					""
				};
				if (d_pracs) exitWith {
					"PRACS_Mk5_SOCR"
				};
				"B_Boat_Armed_01_minigun_F"
			};
		};
		if (d_enemy_side_short == "G") exitWith {
			call {
				if (d_cup) exitWith {
					"CUP_I_RHIB_RACS"
				};
				if (d_ifa3) exitWith {
					""
				};
				if (d_rhs) exitWith {
					""
				};
				"I_Boat_Armed_01_minigun_F"
			};
		};
	};

#ifdef __ALTIS__
#include "d_compositions_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_compositions_default.sqf"
#endif
#ifdef __CUP_CHERNARUS__
#include "d_compositions_CUP_Chernarus.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "d_compositions_CUP_Takistan.sqf"
#endif
#ifdef __CUP_SARA__
#include "d_compositions_CUP_Chernarus.sqf"
#endif
//#ifdef __GMCWG__
// no compositions
//#endif
//#ifdef __IFA3__
// no compositions
//#endif
//#ifdef __CSLA__
// no compositions
//#endif
#ifdef __TT__
#include "d_compositions_default.sqf"
#endif
#ifdef __TANOA__
#include "d_compositions_default.sqf"
#endif
#ifdef __STRATIS__
#include "d_compositions_default.sqf"
#endif
#ifdef __MALDEN__
#include "d_compositions_default.sqf"
#endif
#ifdef __WS__
#include "d_compositions_default.sqf"
#endif
#ifdef __PRACS__
#include "d_compositions_PRACS.sqf"
#endif

	// max men for main target clear
	d_man_count_for_target_clear = 6;
	// max tanks for main target clear
	d_tank_count_for_target_clear = 1;
	// max cars for main target clear
	d_car_count_for_target_clear = 1;

	// time (in sec) between attack planes and choppers over main target will respawn once they were shot down (a random value between 0 and 240 will be added)
	if (isNil "d_airai_respawntime") then {
		d_airai_respawntime = 1000;
	};

	d_side_missions_random = [];
	d_player_created = [];

	if (isNil "d_time_until_next_sidemission") then {
		d_time_until_next_sidemission = [
			[10,300], // if player number <= 10, it'll take 300 seconds until the next sidemission
			[20,400], // if player number <= 20, it'll take 400 seconds until the next sidemission
			[30,500], // if player number <= 30, it'll take 500 seconds until the next sidemission
			[500,600] // if player number > 30, it'll take 600 seconds until the next sidemission
		];
	};
	
	if (isNil "d_sm_vec_weighting") then {
		// sidemissoin vehicles get randomly selected by "weight"
		// means, planes have a weight of 0.1, helicopters 0.2, tanks 0.7 and all other vehicles 1.3
		// the higher the weight the higher the chance to get such a vehicle
		// indices: plane, helicopter, tank, other vehicles
		d_sm_vec_weighting = [0.1,0.2,0.7,1.3];
	};

	call {
		if (d_gmcwg) exitWith {
			d_civilians_t = ["gm_gc_civ_man_01_80_blk","gm_gc_civ_man_01_80_blu","gm_gc_civ_man_02_80_brn","gm_gc_civ_man_02_80_gry","gm_gc_pol_officer_80_blu"];
		};
		if (d_unsung) exitWith {
			d_civilians_t = ["uns_civilian1","uns_civilian2","uns_civilian3","uns_civilian4"];
		};
		if (d_vn) exitWith {
			d_civilians_t = ["vn_c_men_01","vn_c_men_02","vn_c_men_03","vn_c_men_04","vn_c_men_05","vn_c_men_06","vn_c_men_07","vn_c_men_08","vn_c_men_09","vn_c_men_10","vn_c_men_11","vn_c_men_12","vn_c_men_13","vn_c_men_14","vn_c_men_22","vn_c_men_23","vn_c_men_24","vn_c_men_25","vn_c_men_26","vn_c_men_27","vn_c_men_28","vn_c_men_29","vn_c_men_30","vn_c_men_31","vn_c_men_32"];
		};
		if (d_csla) exitWith {
			d_civilians_t = ["CSLA_CIV_Citizen","CSLA_CIV_Citizen_V2","CSLA_CIV_Citizen_V3","CSLA_CIV_Citizen_V4","CSLA_CIV_Doctor","CSLA_CIV_Foreman","CSLA_CIV_Foreman_V2","CSLA_CIV_Woodlander","CSLA_CIV_Woodlander_V2","CSLA_CIV_Woodlander_V3","CSLA_CIV_Woodlander_V4","CSLA_CIV_Functionary","CSLA_CIV_Functionary_V2","CSLA_CIV_Villager","CSLA_CIV_Villager_V2","CSLA_CIV_Villager_V3","CSLA_CIV_Villager_V4","CSLA_CIV_Worker","CSLA_CIV_Worker_V2","CSLA_CIV_Worker_V3","CSLA_CIV_Worker_V4"];
		};
		if (d_ws) exitWith {
			d_civilians_t = ["C_Djella_01_lxWS","C_Djella_02_lxWS","C_Djella_03_lxWS","C_Djella_04_lxWS","C_Djella_05_lxWS","C_Tak_02_A_lxWS","C_Tak_02_B_lxWS","C_Tak_02_C_lxWS","C_Tak_03_A_lxWS","C_Tak_03_B_lxWS","C_Tak_03_C_lxWS","C_man_shorts_1_F_afro","C_Tak_01_A_lxWS","C_Tak_01_B_lxWS","C_Tak_01_C_lxWS"];
		};
		d_civilians_t = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
	};

	d_base_aa_vec =
#ifdef __OWN_SIDE_INDEPENDENT__
	call {
		if (d_pracs) exitWith {
			"PRACS_M163_MACHBET"
		};
		"I_LT_01_AA_F"
	};
#endif
#ifdef __OWN_SIDE_BLUFOR__
	call {
		if (d_cup) exitWith {
			"CUP_B_M6LineBacker_USA_W"
		};
		if (d_rhs) exitWith {
			"RHS_M6_wd"
		};
		if (d_gmcwg) exitWith {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_gepard1a1_win"
			};
			"gm_ge_army_gepard1a1"
		};
		if (d_unsung) exitWith {
			"uns_m163"
		};
		if (d_vn) exitWith {
			"vn_b_sf_static_m45"
		};
		if (d_tanoa || {d_livonia}) exitWith {
			"B_T_APC_Tracked_01_AA_F"
		};
		if (d_ws) exitWith {
			"B_D_APC_Tracked_01_aa_lxWS"
		};
		"B_APC_Tracked_01_AA_F";
	};
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_cup) exitWith {
			"CUP_O_2S6M_RU"
		};
		if (d_rhs) exitWith	{
			"rhs_zsu234_aa"
		};
		if (d_csla) exitWith	{
			"CSLA_PLdvK59V3S"
		};
		if (d_ifa3) exitWith {
			"LIB_61k"
		};
		if (d_pracs) exitWith {
			"PRACS_SLA_MTLB_ZU23"
		};
		"O_APC_Tracked_02_AA_F"
	};
#endif
#ifdef __TT__
	"";
#endif
	d_base_tank_vec =
#ifdef __OWN_SIDE_INDEPENDENT__
	call {
		if (d_pracs) exitWith {
			"PRACS_M60S"
		};
		"I_MBT_03_cannon_F"
	};
#endif
#ifdef __OWN_SIDE_BLUFOR__
	call {
		if (d_cup) exitWith {
			"CUP_B_M1A1_Woodland_US_Army"
		};
		if (d_rhs) exitWith {
			"rhsusf_m1a1aimwd_usarmy"
		};
		if (d_gmcwg) exitWith {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_Leopard1a1a1_win"
			};
			"gm_ge_army_Leopard1a1a1"
		};
		if (d_unsung) exitWith {
			"uns_m48a3"
		};
		if (d_vn) exitWith {
			"vn_b_armor_m41_01_01"
		};
		if (d_tanoa || {d_livonia}) exitWith {
			"B_T_MBT_01_cannon_F"
		};
		if (d_ws) exitWith {
			"B_D_MBT_01_cannon_lxWS"
		};
		"B_MBT_01_cannon_F";
	};
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_cup) exitWith {
			"CUP_O_T72_RU"
		};
		if (d_rhs) exitWith {
			"rhs_t90_tv"
		};
		if (d_csla) exitWith	{
			"CSLA_T72M1"
		};
		if (d_ifa3) exitWith {
			"LIB_T34_85"
		};
		if (d_pracs) exitWith {
			"PRACS_SLA_T72BV"
		};
		"O_MBT_02_cannon_F"
	};
#endif
#ifdef __TT__
	"";
#endif
	d_base_apc_vec =
#ifdef __OWN_SIDE_INDEPENDENT__
	call {
		if (d_pracs) exitWith {
			"PRACS_Pizarro"
		};
		"I_APC_tracked_03_cannon_F"
	};
#endif
#ifdef __OWN_SIDE_BLUFOR__
	call {
		if (d_cup) exitWith {
			"CUP_B_M2Bradley_USA_W"
		};
		if (d_rhs) exitWith {
			"RHS_M2A2_wd"
		};
		if (d_gmcwg) exitWith {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_m113a1g_apc_win"
			};
			"gm_ge_army_m113a1g_apc"
		};
		if (d_unsung) exitWith {
			"uns_M113_M2"
		};
		if (d_vn) exitWith {
			""
		};
		if (d_tanoa || {d_livonia}) exitWith {
			"B_T_APC_Wheeled_01_cannon_F"
		};
		if (d_vn) exitWith {
			"B_D_APC_Tracked_01_rcws_lxWS"
		};
		if (d_pracs) exitWith {
			"PRACS_Pizarro"
		};
		"B_APC_Wheeled_01_cannon_F"
	};
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_cup) exitWith {
			"CUP_O_BMP2_RU"
		};
		if (d_rhs) exitWith	{
			"rhs_bmp2d_tv"
		};
		if (d_csla) exitWith	{
			"CSLA_BVP1"
		};
		if (d_ifa3) exitWith {
			"LIB_SOV_M3_Halftrack"
		};
		if (d_pracs) exitWith {
			"PRACS_SLA_BMP2"
		};
		"O_APC_Tracked_02_cannon_F"
	};
#endif
#ifdef __TT__
	"";
#endif

	d_wreck_cur_ar = [];

#ifdef __ALTIS__
#include "d_sm_classes_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_sm_classes_default.sqf"
#endif
#ifdef __GMCWG__
#include "d_sm_classes_gmcwg.sqf"
#endif
#ifdef __CUP_CHERNARUS__
#include "d_sm_classes_CUP.sqf"
#endif
#ifdef __CUP_TAKISTAN__
#include "d_sm_classes_CUP.sqf"
#endif
#ifdef __CUP_SARA__
#include "d_sm_classes_CUP.sqf"
#endif
#ifdef __IFA3__
#include "d_sm_classes_ifa3.sqf"
#endif
#ifdef __TANOA__
#include "d_sm_classes_default.sqf"
#endif
#ifdef __STRATIS__
#include "d_sm_classes_default.sqf"
#endif
#ifdef __MALDEN__
#include "d_sm_classes_default.sqf"
#endif
#ifdef __TT__
#include "d_sm_classes_default.sqf"
#endif
#ifdef __RHS__
#include "d_sm_classes_rhs.sqf"
#endif
#ifdef __UNSUNG__
#include "d_sm_classes_uns.sqf"
#endif
#ifdef __VN__
#include "d_sm_classes_vn.sqf"
#endif
#ifdef __CSLA__
#include "d_sm_classes_csla.sqf"
#endif
#ifdef __WS__
#include "d_sm_classes_ws.sqf"
#endif
#ifdef __PRACS__
#include "d_sm_classes_PRACS.sqf"
#endif

	d_intel_unit = objNull;

	d_ArtyShellsBlufor = [
		"Sh_120mm_HE", // HE
		"Smoke_120mm_AMOS_White", // Smoke
		"G_40mm_HE" // dpicm
	];

	d_ArtyShellsOpfor = [
		"Sh_120mm_HE", // HE
		"Smoke_120mm_AMOS_White", // Smoke
		"G_40mm_HE" // dpicm
	];

	d_hd_sim_types = ["SHOTPIPEBOMB", "SHOTTIMEBOMB", "SHOTDIRECTIONALBOMB", "SHOTMINE", "shotboundingmine"];
	d_hd_sim_types = d_hd_sim_types apply {toLowerANSI _x};

	d_isle_defense_marker = "n_mech_inf";
	
	call {
		if (d_enemy_side_short == "E") exitWith {
			if (d_vn) exitWith {
				d_air_radar = "Land_vn_radar_small_f";
				d_air_radar2 = "Land_vn_mobileradar_01_radar_f";
				d_enemy_hq = "Land_Cargo_HQ_V1_F";
			};
			d_air_radar = "Land_Radar_Small_F";
			d_air_radar2 = "Land_MobileRadar_01_radar_F";
			d_enemy_hq = "Land_Cargo_HQ_V1_F";
		};
		if (d_enemy_side_short == "W") exitWith {
			d_air_radar = "Land_Radar_Small_F";
			d_air_radar2 = "Land_MobileRadar_01_radar_F";
			d_enemy_hq = "Land_Cargo_HQ_V1_F";
		};
		d_air_radar = "Land_Radar_Small_F";
		d_air_radar2 = "Land_MobileRadar_01_radar_F";
		d_enemy_hq = "Land_Cargo_HQ_V1_F";
	};

	// type of enemy plane that will fly over the main target
	d_airai_attack_plane = call {
		if (d_enemy_side_short == "E") exitWith {
			call {
				if (d_cup) exitWith {
					["O_Plane_CAS_02_F","CUP_O_Su25_RU_3","CUP_O_Su25_RU_1","CUP_O_Su25_RU_2"]
				};
				if (d_gmcwg) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					["rhs_mig29s_vmf","rhs_mig29sm_vmf","rhs_mig29s_vvsc","rhs_mig29sm_vvsc","RHS_Su25SM_vvsc","RHS_Su25SM_vvs","RHS_T50_vvs_generic_ext","RHS_T50_vvs_blueonblue"]
				};
				if (d_unsung) exitWith {
					["uns_Mig21_CAS", "uns_Mig21_CBU", "uns_Mig21_HCAS"]
				};
				if (d_vn) exitWith {
					[]
				};
				if (d_pracs) exitWith {
					["PRACS_SLA_MiG27","PRACS_SLA_Su25","PRACS_SLA_SU22"]
				};
				["O_Plane_CAS_02_F"]
			};
		};
		if (d_enemy_side_short == "W") exitWith {
			call {
				if (d_ifa3) exitWith {
					["LIB_FW190F8", "LIB_FW190F8_4", "LIB_FW190F8_2", "LIB_FW190F8_5", "LIB_FW190F8_3"]
				};
				if (d_rhs) exitWith {
					["RHS_A10","rhsusf_f22"]
				};
				if (d_csla) exitWith {
					[]
				};
				["B_Plane_CAS_01_F"]
			};
		};
		if (d_enemy_side_short == "G") exitWith {
			call {
				if (d_pracs) exitWith {
					["PRACS_A4M","PRACS_MirageV","PRACS_Mohawk"]
				};
				["I_Plane_Fighter_03_CAS_F"]
			};
		};
	};

       // type of enemy UAV that will fly over the main target
	d_airai_attack_uav = call {
		if (d_enemy_side_short == "E") exitWith {
			call {
				if (d_cup) exitWith {
					[]
				};
				if (d_gmcwg) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					[]
				};
				if (d_unsung) exitWith {
					[]
				};
				if (d_vn) exitWith {
					[]
				};
				if (d_ifa3) exitWith {
					[]
				};
				if (d_ws) exitWith {
					[]
				};
				["O_UAV_02_F","O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"]
			};
		};
		if (d_enemy_side_short == "W") exitWith {
			call {
				if (d_cup) exitWith {
					["CUP_B_USMC_DYN_MQ9"]
				};
				if (d_ifa3) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					[]
				};
				if (d_gmcwg) exitWith {
					[]
				};
				if (d_csla) exitWith {
					[]
				};
				["B_T_UAV_03_F", "B_UAV_02_F", "B_UAV_05_F"]
			};
		};
		if (d_enemy_side_short == "G") exitWith {
			call {
				if (d_cup) exitWith {
					[]
				};
				if (d_ifa3) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					[]
				};
				["I_UAV_02_F", "I_UAV_02_CAS_F"]
			};
		};
	};

	// type of enemy chopper that will fly over the main target
	d_airai_attack_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			call {
				if (d_cup) exitWith {
					["O_Heli_Attack_02_F","CUP_O_Mi24_P_RU","CUP_O_Mi24_V_RU","CUP_O_Ka50_SLA"]
				};
				if (d_gmcwg) exitWith {
					if (d_gmcwgwinter) exitWith {
						["gm_gc_airforce_mi2urn_un"]
					};
					["gm_gc_airforce_mi2urn"]
				};
				if (d_rhs) exitWith {
					["RHS_Mi24P_vdv","RHS_Mi24V_vdv","RHS_Ka52_vvsc","RHS_Mi24P_vvsc","RHS_Mi24Vt_vvsc","rhs_mi28n_vvsc"]
				};
				if (d_unsung) exitWith {
					["uns_Mi8TV_VPAF_MG"]
				};
				if (d_vn) exitWith {
					["vn_o_air_mi2_04_06","vn_o_air_mi2_04_02"]
				};
				if (d_ws) exitWith {
					["O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS"]
				};
				if (d_pracs) exitWith {
					["PRACS_SLA_Mi24D","PRACS_SLA_Mi24V_UPK"]
				};
				["O_Heli_Attack_02_F"]
			};
		};
		if (d_enemy_side_short == "W") exitWith {
			call {
				if (d_ifa3) exitWith {
					["LIB_Ju87_Italy2", "LIB_Ju87_Italy", "LIB_Ju87"]
				};
				if (d_rhs) exitWith {
					["RHS_AH64D","RHS_AH64DGrey","RHS_AH64D_wd","RHS_AH1Z","RHS_AH1Z_wd"]
				};
				if (d_csla) exitWith {
					["US85_MH60FFAR"]
				}; 
				["B_Heli_Attack_01_F"]
			};
		};
		if (d_enemy_side_short == "G") exitWith {
			call {
				if (d_pracs) exitWith {
					["PRACS_AH1S","PRACS_RAH6","PRACS_Sa330_Puma_SOCAT"]
				};
				["I_Heli_light_03_F"]
			};
		};
	};

#ifdef __ALTIS__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_T_VTOL_02_infantry_grey_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_T_VTOL_01_infantry_blue_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __GMCWG__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["gm_gc_airforce_l410s_salon","gm_gc_airforce_l410t"]
		};
		if (d_enemy_side_short == "W") exitWith {
			[]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __TANOA__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_T_VTOL_02_infantry_grey_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_T_VTOL_01_infantry_blue_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __LIVONIA__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_T_VTOL_02_infantry_grey_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_T_VTOL_01_infantry_blue_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __STRATIS__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_T_VTOL_02_infantry_grey_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_T_VTOL_01_infantry_blue_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __MALDEN__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_T_VTOL_02_infantry_grey_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_T_VTOL_01_infantry_blue_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __IFA3__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_T_VTOL_02_infantry_grey_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["LIB_RBAF_Ju87"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __TT__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_T_VTOL_02_infantry_grey_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_T_VTOL_01_infantry_blue_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __CUP_CHERNARUS__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["CUP_O_MI6T_RU"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_Heli_Light_01_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __CUP_SARA__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["CUP_O_Mi8_SLA_1"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_Heli_Light_01_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __CUP_TAKISTAN__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["CUP_O_AN2_TK"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_Heli_Light_01_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __RHS__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["RHS_Mi8MTV3_vvsc"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["rhsusf_CH53E_USMC"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __UNSUNG__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["uns_an2"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["rhsusf_CH53E_USMC"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __VN__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["vn_o_air_mi2_01_01"]
		};
	};
#endif
#ifdef __CSLA__
	d_transport_chopper = call {
		if (d_enemy_side_short == "W") exitWith {
			["US85_UH60"]
		};
	};
#endif
#ifdef __WS__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["O_Heli_Light_02_unarmed_F"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_T_VTOL_01_infantry_blue_F"]
		};
		["I_Heli_Transport_02_F"]
	};
#endif
#ifdef __PRACS__
	// enemy parachute troops transport chopper
	d_transport_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			["PRACS_SLA_Mi8amt","PRACS_AN12B"]
		};
		if (d_enemy_side_short == "W") exitWith {
			["B_Heli_Light_01_F"]
		};
		["PRACS_Sa330_Puma","PRACS_C130"]
	};
#endif

	// light attack chopper (for example I_Heli_light_03_F with MG)
	d_light_attack_chopper = call {
		if (d_enemy_side_short == "E") exitWith {
			call {
				if (d_cup) exitWith {
					["O_Heli_Attack_02_black_F", "CUP_O_Mi8_RU"]
				};
				if (d_gmcwg) exitWith {
					if (d_gmcwgwinter) exitWith {
						["gm_gc_airforce_mi2us_un"]
					};
					["gm_gc_airforce_mi2us"]
				};
				if (d_unsung) exitWith {
					["uns_Mi8TV_VPAF_MG"]
				};
				if (d_vn) exitWith {
					["vn_o_air_mi2_03_05"]
				};
				if (d_ifa3) exitWith {
					[]
				};
				if (d_ws) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					["RHS_Mi24P_vvs"]
				};
				if (d_pracs) exitWith {
					["PRACS_SLA_Mi17Sh","PRACS_SLA_Mi17Sh_UPK"]
				};
				["O_Heli_Attack_02_black_F"]
			};
		};
		if (d_enemy_side_short == "W") exitWith {
			call {
				if (d_cup) exitWith {
					[]
				};
				if (d_ifa3) exitWith {
					["LIB_Ju87_Italy2"]
				};
				if (d_csla) exitWith {
					["US85_UH60M240"]
				}; 
				if (d_gmcwg) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					["RHS_MELB_AH6M","RHS_UH1Y_d","RHS_UH1Y"]
				};
				["B_Heli_Light_01_armed_F"]
			};
		};
		call {
			if (d_cup) exitWith {
				[]
			};
			if (d_ifa3) exitWith {
				[]
			};
			if (d_rhs) exitWith {
				[]
			};
			if (d_gmcwg) exitWith {
				[]
			};
			if (d_pracs) exitWith {
				["PRACS_UH1H_CAS"]
			};
			["I_Heli_light_03_dynamicLoadout_F"]
		};
	};

	// enemy AI inf barracks in main target... As long as the building exists enemy AI inf respawns inside the building thus in the main target area!!!
	// Needs a building which can be entered by AI (as they will respawn inside)
	// can only be destroyed by satchel charges!!!
	// no marker gets created!
	d_barracks_building = call {
		if (d_vn) exitWith {
			"Land_vn_o_shelter_05"
		};
		if (d_ws) exitWith {
			"Land_BagBunker_Large_F"
		};
		"Land_BagBunker_01_large_green_F"
	};

	// same as barracks building. But enemy AI vehicles do not spawn inside the main target area but outside
	// if destroyed no more enemy vehicles respawn
	d_vehicle_building =
#ifdef __ALTIS__
		"Land_Cargo_HQ_V1_F";
#endif
#ifdef __CUP_CHERNARUS__
		"Land_Cargo_HQ_V4_F";
#endif
#ifdef __CUP_TAKISTAN__
		"Land_Cargo_HQ_V1_F";
#endif
#ifdef __CUP_SARA__
		"Land_Cargo_HQ_V1_F";
#endif
#ifdef __IFA3__
		"CDF_WarfareBHeavyFactory";
#endif
#ifdef __TANOA__
		"Land_Cargo_HQ_V4_F";
#endif
#ifdef __STRATIS__
		"Land_Cargo_HQ_V1_F";
#endif
#ifdef __MALDEN__
		"Land_Cargo_HQ_V1_F";
#endif
#ifdef __LIVONIA__
		"Land_Cargo_HQ_V4_F";
#endif
#ifdef __TT__
		"Land_Cargo_HQ_V1_F";
#endif
#ifdef __GMCWG__
		"Land_Cargo_HQ_V4_F";
#endif
#ifdef __UNSUNG__
		"Land_Cargo_HQ_V4_F";
#endif
#ifdef __CSLA__
		"Land_Cargo_HQ_V4_F";
#endif
#ifdef __VN__
		"Land_vn_wf_vehicle_service_point_east";
#endif
#ifdef __WS__
		"Land_Cargo_HQ_V3_F";
#endif

	d_b_small_static_high =
#ifdef __ALTIS__
		"Land_BagBunker_Small_F";
#endif
#ifdef __CUP_CHERNARUS__
		"Land_BagBunker_01_small_green_F";
#endif
#ifdef __CUP_TAKISTAN__
		"Land_BagBunker_Small_F";
#endif
#ifdef __CUP_SARA__
		"Land_BagBunker_01_small_green_F";
#endif
#ifdef __IFA3__
		"";
#endif
#ifdef __TANOA__
		"Land_BagBunker_01_small_green_F";
#endif
#ifdef __STRATIS__
		"Land_BagBunker_Small_F";
#endif
#ifdef __MALDEN__
		"Land_BagBunker_Small_F";
#endif
#ifdef __LIVONIA__
		"Land_BagBunker_01_small_green_F";
#endif
#ifdef __TT__
		"Land_BagBunker_Small_F";
#endif
#ifdef __GMCWG__
		"";
#endif
#ifdef __UNSUNG__
		"Land_BagBunker_01_small_green_F";
#endif
#ifdef __CSLA__
		"Land_BagBunker_01_small_green_F";
#endif
#ifdef __VN__
		"";
#endif
#ifdef __WS__
		"Land_BagBunker_Small_F";
#endif

	if (isNil "d_ai_groups_respawn_time") then {
		// inf base time, inf min time, vehicle base time, vehicle min time, all in seconds
		// means, inf base time minus number of players but at least wait 150 to respawn a group, same for vehicles
		// can also be put into the dom_settings in Domination sql DB
		d_ai_groups_respawn_time = [250, 150, 320, 170];
	};

	// set to true to disable ambient battlefield sounds at main targets
	if (isNil "d_noambient_bf_sounds") then {
		d_noambient_bf_sounds = false;
	};

	d_dbox_idx = 0;
	
	d_chem_objs_ar = [];

	//
	//civilian vehicles
	//
	d_civVehiclesWeightedCityWealthHigh = [
		"C_Offroad_01_F", 0.15,
		"C_Hatchback_01_F", 0.30,
		"C_Truck_02_covered_F", 0.05,
		"C_Van_01_box_F", 0.05,
		"C_Van_02_transport_F", 0.05,
		"C_Hatchback_01_sport_F", 0.10,
		"C_Offroad_02_unarmed_F", 0.15,
		"C_SUV_01_F", 0.15
	];

	d_civVehiclesWeightedCityWealthLow = [
		"C_Offroad_01_F", 0.10,
		"C_Hatchback_01_F", 0.10,
		"C_Truck_02_covered_F", 0.03,
		"C_Truck_02_transport_F", 0.03,
		"C_Van_01_box_F", 0.05,
		"C_Van_02_transport_F", 0.05,
		"C_Hatchback_01_sport_F", 0.05,
		"C_Offroad_02_unarmed_F", 0.07,
		"C_Hatchback_01_F", 0.35,
		"C_SUV_01_F", 0.16
	];

	d_civVehiclesWeightedRural = [
		"C_Offroad_01_F", 0.30,
		"C_Truck_02_covered_F", 0.10,
		"C_Truck_02_transport_F", 0.10,
		"C_Van_01_box_F", 0.05,
		"C_Offroad_02_unarmed_F", 0.25,
		"C_SUV_01_F", 0.15,
		"C_Tractor_01_F", 0.10
	];

	d_civVehiclesWeightedRuralCup = [
		"CUP_C_Golf4_random_Civ", 0.25,
		"CUP_C_Datsun", 0.25,
		"CUP_C_Octavia_CIV", 0.25,
		"CUP_C_V3S_Covered_TKC", 0.20,
		"C_Tractor_01_F", 0.05
	];

	d_civVehiclesWeightedRuralCupRemote = [
		"CUP_C_Datsun", 0.35,
		"CUP_C_Datsun_4seat", 0.35,
		"CUP_C_V3S_Covered_TKC", 0.15,
		"C_Tractor_01_F", 0.15
	];

	private _civVehiclesWeightedRuralLivonia = [
		"C_Offroad_01_F", 0.30,
		"C_Truck_02_transport_F", 0.15,
		"C_Offroad_02_unarmed_F", 0.30,
		"C_SUV_01_F", 0.15,
		"C_Tractor_01_F", 0.10
	];

	private _civVehiclesWeightedRuralGmcwg = [
		"C_Truck_02_transport_F", 0.10,
		"gm_gc_civ_p601", 0.40,
		"gm_ge_civ_typ1200", 0.40,
		"C_Tractor_01_F", 0.10
	];

	private _civVehiclesWeightedRuraluns = [
		"C_Truck_02_transport_F", 0.10,
		"uns_willys_2", 0.40,
		"uns_willys_2", 0.40,
		"C_Tractor_01_F", 0.10
	];
	
	private _civVehiclesWeightedRuralVn = [
		"C_Truck_02_covered_F", 0.15,
		"C_Truck_02_transport_F", 0.15,
		"C_Van_01_box_F", 0.15,
		"C_Tractor_01_F", 0.05,
		"vn_c_wheeled_m151_01", 0.25,
		"vn_c_wheeled_m151_02", 0.25
	];
	
	d_civ_vehicles_weighted = [];
	
	//
	// civilian faces
	//
	private _africanFaces = [
		"AfricanHead_01",
		"AfricanHead_02",
		"AfricanHead_03"
	];
	private _asianFaces = [
		"AsianHead_A3_01",
		"AsianHead_A3_02",
		"AsianHead_A3_03"
	];

	private _greekFaces = [
		"GreekHead_A3_01",
		"GreekHead_A3_02",
		"GreekHead_A3_03",
		"GreekHead_A3_04",
		"GreekHead_A3_05",
		"GreekHead_A3_06",
		"GreekHead_A3_07",
		"GreekHead_A3_08",
		"GreekHead_A3_09"
		//GreekHead_A3_10_a //arid
		//GreekHead_A3_10_l //lush
		//GreekHead_A3_10_sa //unknown?
	];

	private _persianFaces = [
		"PersianHead_A3_01",
		"PersianHead_A3_02",
		"PersianHead_A3_03"
		//PersianHead_A3_04_a
		//PersianHead_A3_04_l
		//PersianHead_A3_04_sa
	];

	private _whiteFaces = [
		"WhiteHead_01",
		"WhiteHead_02",
		"WhiteHead_03",
		"WhiteHead_04",
		"WhiteHead_05",
		"WhiteHead_06",
		"WhiteHead_07",
		"WhiteHead_08",
		"WhiteHead_09",
		"WhiteHead_10",
		"WhiteHead_11",
		"WhiteHead_12",
		"WhiteHead_13",
		"WhiteHead_14",
		"WhiteHead_15",
		"WhiteHead_16",
		"WhiteHead_17",
		"WhiteHead_18",
		"WhiteHead_19",
		"WhiteHead_20",
		"WhiteHead_21"
		//WhiteHead_22_a
		//WhiteHead_22_l
		//WhiteHead_22_sa
	];

	private _mixedFaces = _greekFaces + _persianFaces + _whiteFaces;
	
	d_civ_faces = [];

	//todo - do these work?
	//WomanHead_A3
	//MaskHead_A3
	//BlackHead_A3
	
	//
	// civilian unit types
	//
	d_civArray = [];

	private _commonCivs = [
		"C_man_p_beggar_F", 1,
		"C_Man_casual_1_F", 1,
		"C_Man_casual_3_F", 1,
		"C_Man_casual_4_v2_F", 1,
		"C_Man_casual_5_v2_F", 1,
		"C_Man_casual_6_v2_F", 1,
		"C_Man_casual_7_F", 1,
		"C_Man_casual_8_F", 1,
		"C_Man_casual_9_F", 1,
		"C_Man_p_fugitive_F", 1,
		"C_Man_p_messenger_01_F", 1,
		"C_Story_Mechanic_01_F", 0.5,
		"C_Nikos_aged", 0.5,
		//"C_Man_paramedic_01_F", 1,
		"C_scientist_01_informal_F", 1,
		"C_scientist_02_informal_F", 1,
		// minorities
		"C_man_p_beggar_F_afro", 1,
		"C_Man_p_fugitive_F_afro", 1
	];

	d_africanCivs = [
		"C_man_p_beggar_F_afro", 1,
		"C_Man_casual_1_F_afro", 1,
		//"C_Man_casual_2_F_afro", 1,
		"C_Man_casual_3_F_afro", 1,
		"C_Man_casual_4_v2_F_afro", 1,
		"C_Man_casual_5_v2_F_afro", 1,
		"C_Man_casual_6_v2_F_afro", 1,
		"C_Man_casual_7_F_afro", 1,
		"C_Man_casual_8_F_afro", 1,
		"C_Man_casual_9_F_afro", 1,
		"C_Man_p_fugitive_F_afro", 1,
		// minorities
		"C_Man_casual_3_F", 1,
		"C_Man_casual_4_v2_F", 1,
		"C_Man_casual_5_v2_F", 1,
		"C_Man_p_fugitive_F", 1
	];
	
	d_asianCivs = [
		"C_man_p_beggar_F_asia", 1,
		"C_Man_casual_1_F_afro", 1,
		//"C_Man_casual_2_F_afro", 1,
		"C_Man_casual_3_F_afro", 1,
		"C_Man_casual_4_v2_F_afro", 1,
		"C_Man_casual_5_v2_F_afro", 1,
		"C_Man_casual_6_v2_F_afro", 1,
		"C_Man_casual_7_F_afro", 1,
		"C_Man_casual_8_F_afro", 1,
		"C_Man_casual_9_F_afro", 1,
		"C_Man_p_fugitive_F_afro", 1,
		// minorities
		"C_man_p_beggar_F_afro", 1,
		"C_Man_p_fugitive_F_afro", 1,
		"C_Man_casual_3_F", 1,
		"C_Man_casual_4_v2_F", 1
	];
	
	d_euroCivs = [
		"C_Man_casual_1_F_euro", 1,
		//"C_Man_casual_2_F_afro", 1,
		"C_Man_casual_3_F_euro", 1,
		"C_Man_casual_4_v2_F_euro", 1,
		"C_Man_casual_5_v2_F_euro", 1,
		"C_Man_casual_6_v2_F_euro", 1,
		"C_Man_casual_7_F_euro", 1,
		"C_Man_casual_8_F_euro", 1,
		"C_Man_casual_9_F_euro", 1,
		"C_Man_p_fugitive_F_euro", 1,
		"C_scientist_01_informal_F", 1,
		"C_scientist_02_informal_F", 1,
		// minorities
		"C_man_p_beggar_F_afro", 1,
		"C_Man_p_fugitive_F_afro", 1,
		"C_Man_casual_3_F", 1,
		"C_Man_casual_4_v2_F", 1
	];
	
	private _cupCivsChernarus = [
		"CUP_C_C_Citizen_01", 1,
		"CUP_C_C_Citizen_02", 1,
		"CUP_C_C_Citizen_03", 1,
		"CUP_C_C_Citizen_04", 1,
		"CUP_C_C_Worker_01", 1,
		"CUP_C_C_Worker_02", 1,
		"CUP_C_C_Worker_03", 1,
		"CUP_C_C_Worker_04", 1,
		"CUP_C_C_Profiteer_01", 1,
		"CUP_C_C_Profiteer_01", 1,
		"CUP_C_C_Profiteer_02", 1,
		"CUP_C_C_Profiteer_03", 1,
		"CUP_C_C_Profiteer_04", 1,
		"CUP_C_C_Woodlander_01", 1,
		"CUP_C_C_Woodlander_02", 1,
		"CUP_C_C_Woodlander_03", 1,
		"CUP_C_C_Woodlander_04", 1,
		"CUP_C_C_Villager_01", 1,
		"CUP_C_C_Villager_02", 1,
		"CUP_C_C_Villager_03", 1,
		"CUP_C_C_Villager_04", 1,
		"CUP_C_C_Priest_01", 1
	];

	d_cupCivsTakistan = [
		"CUP_C_TK_Man_04", 1,
		"CUP_C_TK_Man_04_Jack", 1,
		"CUP_C_TK_Man_04_Waist", 1,
		"CUP_C_TK_Man_07", 1,
		"CUP_C_TK_Man_07_Coat", 1,
		"CUP_C_TK_Man_07_Waist", 1,
		"CUP_C_TK_Man_08", 1,
		"CUP_C_TK_Man_08_Coat", 1,
		"CUP_C_TK_Man_08_Waist", 1,
		"CUP_C_TK_Man_05_Coat", 1,
		"CUP_C_TK_Man_05_Jack", 1,
		"CUP_C_TK_Man_05_Waist", 1,
		"CUP_C_TK_Man_06_Coat", 1,
		"CUP_C_TK_Man_06_Jack", 1,
		"CUP_C_TK_Man_06_Waist", 1,
		"CUP_C_TK_Man_02", 1,
		"CUP_C_TK_Man_02_Jack", 1,
		"CUP_C_TK_Man_02_Waist", 1,
		"CUP_C_TK_Man_01_Coat", 1,
		"CUP_C_TK_Man_01_Jack", 1,
		"CUP_C_TK_Man_01_Waist", 1,
		"CUP_C_TK_Man_03_Coat", 1,
		"CUP_C_TK_Man_03_Jack", 1,
		"CUP_C_TK_Man_03_Waist", 1
	];
	
	private _civsLivonia = [
		"C_Man_1_enoch_F", 1,
		"C_Man_2_enoch_F", 1,
		"C_Man_3_enoch_F", 1,
		"C_Man_4_enoch_F", 1,
		"C_Man_5_enoch_F", 1,
		"C_Man_6_enoch_F", 1,
		"C_Farmer_01_enoch_F", 1
	];
	
	private _civsVietnam = [
		"vn_c_men_01", 1,
		"vn_c_men_02", 1,
		"vn_c_men_03", 1,
		"vn_c_men_04", 1,
		"vn_c_men_05", 1,
		"vn_c_men_06", 1,
		"vn_c_men_07", 1,
		"vn_c_men_08", 1,
		"vn_c_men_09", 1,
		"vn_c_men_10", 1,
		"vn_c_men_11", 1,
		"vn_c_men_12", 1,
		"vn_c_men_13", 1,
		"vn_c_men_14", 1,
		"vn_c_men_15", 1,
		"vn_c_men_16", 1,
		"vn_c_men_17", 1,
		"vn_c_men_18", 1,
		"vn_c_men_19", 1,
		"vn_c_men_20", 1,
		"vn_c_men_21", 1,
		"vn_c_men_22", 1,
		"vn_c_men_23", 1,
		"vn_c_men_24", 1,
		"vn_c_men_25", 1,
		"vn_c_men_26", 1,
		"vn_c_men_27", 1,
		"vn_c_men_28", 1,
		"vn_c_men_29", 1,
		"vn_c_men_30", 1,
		"vn_c_men_31", 1,
		"vn_c_men_32", 1
	];

	private _civsWestSahara = [
		"C_Djella_01_lxWS", 1,
		"C_Djella_02_lxWS", 1,
		"C_Djella_03_lxWS", 1,
		"C_Djella_04_lxWS", 1,
		"C_Djella_05_lxWS", 1,
		"C_Tak_01_A_lxWS", 1,
		"C_Tak_01_B_lxWS", 1,
		"C_Tak_01_C_lxWS", 1,
		"C_Tak_02_A_lxWS", 1,
		"C_Tak_02_B_lxWS", 1,
		"C_Tak_02_C_lxWS", 1,
		"C_Tak_03_A_lxWS", 1,
		"C_Tak_03_B_lxWS", 1,
		"C_Tak_03_C_lxWS", 1
	];
	
	d_civ_women_common = [
		"Max_woman1", 7,
		"Max_woman3", 1,
		"Max_woman4", 1
	];
	
	d_civ_women_takistan = [
		"Max_Tak_woman1", 0.5,
		"Max_Tak_woman2", 0.5,
		"Max_Tak_woman3", 0.5,
		"Max_Tak_woman4", 0.5,
		"Max_Tak_woman5", 0.5,
		"Max_Tak_woman6", 15,
		"Max_Taky_woman1", 0.5,
		"Max_Taky_woman2", 0.5,
		"Max_Taky_woman3", 0.5,
		"Max_Taky_woman4", 0.5,
		"Max_Taky_woman5", 0.5,
		"Max_Tak2_woman1", 0.5,
		"Max_Tak2_woman2", 0.5,
		"Max_Tak2_woman3", 0.5,
		"Max_Tak2_woman4", 0.5,
		"Max_Tak2_woman5", 0.5
	];
	
	d_civ_faction_tanoa = [
		"C_man_p_beggar_F_tanoan", 1,
		"C_Man_casual_1_F_tanoan", 1,
		"C_Man_casual_3_F_tanoan", 1,
		"C_Man_casual_4_v2_F_tanoan", 1,
		"C_Man_casual_5_v2_F_tanoan", 1,
		"C_Man_casual_6_v2_F_tanoan", 1,
		"C_Man_casual_7_F_tanoan", 1,
		"C_Man_casual_8_F_tanoan", 1,
		"C_Man_casual_9_F_tanoan", 1
	];
	
	d_civ_faction_cup_chernarus = [
		"CUP_C_C_Assistant_01", 1,
        "CUP_C_C_Bully_01", 1,
        "CUP_C_C_Bully_02", 1,
        "CUP_C_C_Bully_03", 1,
        "CUP_C_C_Bully_04", 1,
        "CUP_C_C_Citizen_01", 1,
        "CUP_C_C_Citizen_02", 1,
        "CUP_C_C_Citizen_03", 1,
        "CUP_C_C_Citizen_04", 1,
        "CUP_C_C_Worker_05", 1,
        "CUP_C_C_Policeman_01", 1,
        "CUP_C_C_Racketeer_01", 1,
        "CUP_C_C_Racketeer_02", 1,
        "CUP_C_C_Racketeer_03", 1,
        "CUP_C_C_Racketeer_04", 1,
        "CUP_C_C_Schoolteacher_01", 1,
        "CUP_C_C_Villager_01", 1,
        "CUP_C_C_Villager_02", 1,
        "CUP_C_C_Villager_03", 1,
        "CUP_C_C_Villager_04", 1,
        "CUP_C_C_Woodlander_01", 1,
        "CUP_C_C_Woodlander_02", 1,
        "CUP_C_C_Woodlander_03", 1,
        "CUP_C_C_Woodlander_04", 1,
        "CUP_C_C_Worker_01", 1,
        "CUP_C_C_Worker_02", 1,
        "CUP_C_C_Worker_03", 1,
        "CUP_C_C_Worker_04", 1,
        "CUP_C_C_Citizen_Random", 1
	];
	
	d_civ_faction_cfp_chernarus_winter = [
		"CFP_C_CHERNO_WIN_Civilian_01", 1,
        "CFP_C_CHERNO_WIN_Civilian_02", 1,
        "CFP_C_CHERNO_WIN_Civilian_03", 1
	];
	
	d_civ_faction_cfp_afghanistan = [
		"CFP_C_AFG_Civilian_01", 1,
		"CFP_C_AFG_Civilian_02", 1
	];
	
	d_civ_faction_cfp_african_christian = [
		"CFP_C_AFRCHRISTIAN_Civ_1_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_2_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_3_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_4_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_5_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_6_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_7_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_8_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_9_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_10_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_11_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_12_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_13_01", 1,
		"CFP_C_AFRCHRISTIAN_Civ_14_01", 1
	];
	
	d_civ_faction_cfp_african_islamic = [
		"CFP_C_AFRISLAMIC_Civ_1_01", 1,
		"CFP_C_AFRISLAMIC_Civ_2_01", 1,
		"CFP_C_AFRISLAMIC_Civ_3_01", 1,
		"CFP_C_AFRISLAMIC_Civ_4_01", 1,
		"CFP_C_AFRISLAMIC_Civ_5_01", 1,
		"CFP_C_AFRISLAMIC_Civ_6_01", 1,
		"CFP_C_AFRISLAMIC_Civ_7_01", 1,
		"CFP_C_AFRISLAMIC_Civ_8_01", 1,
		"CFP_C_AFRISLAMIC_Civ_9_01", 1,
		"CFP_C_AFRISLAMIC_Civ_10_01", 1,
		"CFP_C_AFRISLAMIC_Civ_11_01", 1,
		"CFP_C_AFRISLAMIC_Civ_12_01", 1,
		"CFP_C_AFRISLAMIC_Civ_13_01", 1,
		"CFP_C_AFRISLAMIC_Civ_14_01", 1
	];
	
	d_civ_faction_cfp_asian = [
		"CFP_C_ASIA_Civilian_1_01", 1,
		"CFP_C_ASIA_Civilian_2_01", 1,
		"CFP_C_ASIA_Civilian_3_01", 1,
		"CFP_C_ASIA_Civilian_4_01", 1,
		"CFP_C_ASIA_Civilian_5_01", 1,
		"CFP_C_ASIA_Civilian_6_01", 1,
		"CFP_C_ASIA_Civilian_7_01", 1,
		"CFP_C_ASIA_Civilian_8_01", 1,
		"CFP_C_ASIA_Civilian_9_01", 1,
		"CFP_C_ASIA_Civilian_10_01", 1,
		"CFP_C_ASIA_Civilian_11_01", 1,
		"CFP_C_ASIA_Civilian_12_01", 1,
		"CFP_C_ASIA_Civilian_13_01", 1,
		"CFP_C_ASIA_Civilian_14_01", 1
	];
	
	d_civ_faction_cfp_malden - [
		"CFP_C_MALDEN_Civilian_01", 1,
        "CFP_C_MALDEN_Civilian_02", 1
	];
	
	d_civ_faction_cfp_middle_east = [
		"CFP_C_ME_Civ_1_01", 1,
        "CFP_C_ME_Civ_2_01", 1
	];
	
	
#ifdef __ALTIS__
	d_civ_vehicles_weighted = d_civVehiclesWeightedCityWealthHigh;
	d_civ_faces = _mixedFaces;
	d_civArray = d_euroCivs;
#endif
#ifdef __CUP_CHERNARUS__
	d_civ_vehicles_weighted = d_civVehiclesWeightedRural;
	d_civ_faces = _mixedFaces;
	d_civArray = _cupCivsChernarus;
#endif
#ifdef __CUP_TAKISTAN__
	d_civ_vehicles_weighted = d_civVehiclesWeightedRuralCupRemote;
	d_civ_faces = (_greekFaces + _persianFaces);
	d_civArray = d_cupCivsTakistan;
#endif
#ifdef __CUP_ZARGABAD__
	d_civ_vehicles_weighted = d_civVehiclesWeightedCityWealthLow;
	d_civ_faces = (_greekFaces + _persianFaces);
	d_civArray = d_cupCivsTakistan;
#endif
#ifdef __CUP_SARA__
	d_civ_vehicles_weighted = d_civVehiclesWeightedCityWealthLow;
	d_civ_faces = _mixedFaces;
	d_civArray =  d_euroCivs;
#endif
#ifdef __IFA3__
	d_civ_vehicles_weighted = d_civVehiclesWeightedRural;
	d_civ_faces = _mixedFaces;
	d_civArray = _commonCivs;
#endif
#ifdef __TANOA__
	d_civ_vehicles_weighted = d_civVehiclesWeightedCityWealthLow;
	d_civ_faces = _asianFaces;
	d_civArray = d_civ_faction_tanoa;
#endif
#ifdef __STRATIS__
	d_civ_vehicles_weighted = d_civVehiclesWeightedCityWealthHigh;
	d_civ_faces = _mixedFaces;
	d_civArray = d_euroCivs;
#endif
#ifdef __MALDEN__
	d_civ_vehicles_weighted = d_civVehiclesWeightedCityWealthLow;
	d_civ_faces = _mixedFaces;
	d_civArray = d_euroCivs;
#endif
#ifdef __LIVONIA__
	d_civ_vehicles_weighted = _civVehiclesWeightedRuralLivonia;
	d_civ_faces = _whiteFaces;
	d_civArray = _civsLivonia;
#endif
#ifdef __TT__
	d_civ_vehicles_weighted = d_civVehiclesWeightedRural;
	d_civ_faces = _mixedFaces;
	d_civArray = _commonCivs;
#endif
#ifdef __GMCWG__
	d_civ_vehicles_weighted = _civVehiclesWeightedRuralGmcwg;
	d_civ_faces = _whiteFaces;
	d_civArray = _commonCivs;
#endif
#ifdef __UNSUNG__
	d_civ_vehicles_weighted = _civVehiclesWeightedRuraluns;
	d_civ_faces = _asianFaces;
	d_civArray = d_asianCivs;
#endif
#ifdef __CSLA__
	d_civ_vehicles_weighted = _civVehiclesWeightedRuralLivonia;
	d_civ_faces = _mixedFaces;
	d_civArray = d_euroCivs;
#endif
#ifdef __VN__
	d_civ_vehicles_weighted = _civVehiclesWeightedRuralVn;
	d_civ_faces = _asianFaces;
	d_civArray = _civsVietnam;
#endif
#ifdef __WS__
	d_civ_vehicles_weighted = d_civVehiclesWeightedCityWealthLow;
	d_civ_faces = _persianFaces;
	d_civArray = (_civsWestSahara + d_africanCivs);
#endif
};

if (hasInterface) then {
	__TRACE("preInit hasInterface")

	// this vehicle will be created if you use the "Create XXX" at a mobile respawn (old "Create Motorcycle") or at a jump flag
	// IMPORTANT !!!! for ranked version !!!!
	// if there is more than one vehicle defined in the array the vehicle will be selected by player rank
	// one vehicle only, vehicle is only available when the player is at least lieutenant
	d_create_bike =
#ifdef __OWN_SIDE_INDEPENDENT__
	["I_Quadbike_01_F"];
#endif
#ifdef __OWN_SIDE_BLUFOR__
	call {
		if (d_tanoa || {d_livonia}) exitWith {
			["B_Quadbike_01_F", "B_T_LSV_01_unarmed_F"]
		};
		if (d_gmcwg) exitWith {
			if (d_gmcwgwinter) exitWith {
				["gm_ge_army_k125", "gm_xx_civ_bicycle_01", "gm_ge_army_iltis_cargo_win"]
			};
			["gm_ge_army_k125", "gm_xx_civ_bicycle_01", "gm_ge_army_iltis_cargo"]
		};
		if (d_rhs) exitWith {
			["rhsusf_mrzr4_d"]
		};
		if (d_unsung) exitWith {
			["uns_willys"]
		};
		if (d_vn) exitWith {
			["vn_b_wheeled_m151_01"]
		};
		if (d_ws) exitWith {
			["B_D_Quadbike_01_lxWS"]
		};
		["B_Quadbike_01_F", "B_LSV_01_unarmed_F", "B_UAV_01_F"]
	};
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_tanoa || {d_livonia}) exitWith {
			["O_Quadbike_01_F", "O_T_LSV_02_unarmed_F"]
		};
		if (d_rhs) exitWith {
			["rhs_tigr_3camo_msv", "RHS_UAZ_MSV_01"]
		};
		if (d_ifa3) exitWith {
			["LIB_Willys_MB", "LIB_US_Willys_MB"]
		};
		if (d_csla) exitWith {
			["CSLA_AZU", "CSLA_JARA250"]
		};
		["O_Quadbike_01_F", "O_LSV_02_unarmed_F", "O_UAV_01_F"]
	};
#endif
#ifdef __TT__
	["O_Quadbike_01_F"];
#endif

#ifdef __OWN_SIDE_BLUFOR__
	d_UAV_Small = "B_UAV_01_F";
	d_UAV_CAS = "B_UAV_02_F";
	d_UAV_Terminal = "B_UavTerminal";
#endif
#ifdef __OWN_SIDE_OPFOR__
	d_UAV_Small = "O_UAV_01_F";
	d_UAV_CAS = "O_UAV_02_F";
	d_UAV_Terminal = "O_UavTerminal";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	d_UAV_Small = "I_UAV_01_F";
	d_UAV_CAS = "I_UAV_02_F";
	d_UAV_Terminal = "I_UavTerminal";
#endif

	d_still_in_intro = true;

	d_cur_sm_txt = "";
	d_current_mission_resolved_text = "";

	d_allplayers = [];
	d_allplayermapd = [];
	d_allplayerai = [];
#ifndef __TT__
	d_showallnearusermarkers = true;
	d_allnearusermarkers = [];
#endif

	// ammobox handling (default, loading and dropping boxes) it means the time diff in seconds before a box can be loaded or dropped again in a vehicle
	d_drop_ammobox_time = 10;
	d_current_truck_cargo_array = [];
	// d_check_ammo_load_vecs
	// the only vehicles that can load an ammo box are the transport choppers and MHQs__
	d_check_ammo_load_vecs =
#ifdef __OWN_SIDE_BLUFOR__
	["B_Heli_Light_01_F", "B_MRAP_01_F", "B_APC_Tracked_01_CRV_F", "B_T_APC_Tracked_01_CRV_F","CUP_B_M1133_MEV_Woodland","CUP_B_LAV25_HQ_USMC","CUP_B_M1133_MEV_Desert","CUP_B_UH1Y_UNA_USMC","I_Heli_light_03_unarmed_F","RHS_MELB_MH6M","rhsusf_M1232_usarmy_wd","gm_ge_army_m113a1g_command","gm_ge_army_fuchsa0_command","CUP_B_UH1D_GER_KSK","I_E_Heli_light_03_unarmed_F",
	"uns_M113_transport","uns_UH1H_m60","gm_ge_army_bo105m_vbh", "vn_b_wheeled_m54_03", "vn_b_air_uh1d_02_05", "B_D_APC_Tracked_01_CRV_lxWS","B_D_APC_Wheeled_01_command_lxWS","gm_ge_army_m113a1g_command"];
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_ifa3) exitWith {
			["LIB_US6_Tent"]
		};
		if (d_csla) exitWith {
			["CSLA_DTP90", "CSLA_Mi17mg", "CSLA_Mi17"]
		};
		if (d_pracs) exitWith {
			["PRACS_SLA_Mi8amt","PRACS_SLA_BRDM_HQ","PRACS_SLA_BRDM_HQ_PKT","PRACS_SLA_MTLB_HQ"]
		};
		["O_MRAP_02_F", "O_Heli_Light_02_unarmed_F", "B_APC_Tracked_01_CRV_F", "rhsgref_BRDM2UM_vdv", "RHS_Mi8AMT_vvs"]
	};
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	call {
		if (d_pracs) exitWith {
			["PRACS_M577","PRACS_M577_4A","PRACS_M577_1ID","PRACS_M577_RF","PRACS_BMR_HQ","PRACS_BMR_HQ_4AD","PRACS_BMR_HQ_1ID","PRACS_BMR_HQ_Marine","PRACS_BMR_HQ_Fusilier",
			"PRACS_SUV_COM","PRACS_M998_Command","PRACS_M998_Command_2para","PRACS_M998_Command_1Inf","PRACS_M998_Command_3mtn","PRACS_M998_Command_4A",
			"PRACS_UH1H","PRACS_CH53","PRACS_Sa330_Puma","PRACS_Sa330_RSAF","PRACS_Sa330_Puma_NAVY","PRACS_Sa330_Puma_Marine","PRACS_Sa330_Puma_AS"]
		};
		["I_MRAP_03_F", "I_Heli_light_03_unarmed_F","I_E_Heli_light_03_unarmed_F"]
	};
#endif
#ifdef __TT__
	["B_Heli_Light_01_F", "B_APC_Tracked_01_CRV_F", "O_Heli_Light_02_unarmed_F", "B_T_APC_Tracked_01_CRV_F", "O_MRAP_02_F", "B_MRAP_01_F", "B_APC_Tracked_01_CRV_F", "B_T_APC_Tracked_01_CRV_F"];
#endif

	d_check_ammo_load_vecs = d_check_ammo_load_vecs apply {toLowerANSI _x};

	d_weapon_respawn = true;

	d_marker_vecs = [];
	d_mhq_3ddraw = [];

	// is engineer
#ifndef __TT__
	d_is_engineer = ["d_delta_1","d_delta_2","d_delta_3","d_delta_4","d_delta_5","d_delta_6"];
#else
	d_is_engineer = ["d_blufor_17","d_blufor_18","d_blufor_19","d_opfor_17","d_opfor_18","d_opfor_19"];
#endif

	// can call in air drop
#ifndef __TT__
	d_can_call_drop_ar = ["d_alpha_1","d_charlie_1","d_echo_1"];
#else
	d_can_call_drop_ar = [];
#endif

	d_chophud_on = true;

	d_drop_max_dist = 500;

	// if the array is empty, anybody with a pilot uniform and headgear can fly (if the latter is enabled)
	// if you add the string name of playable units (var name in the editor) only those players get a pilot uniform and headgear
	// makes only sense when only pilots can fly is enabled
	// for example: ["pilot_1","pilot_2"];, case sensitiv
	// PLEASE DO NOT CHANGE THIS FOR THE TT VERSION, IT SHOULD BE AN EMPTY ARRAY!!!!
	d_only_pilots_can_fly = [];

	// internal variables
	d_flag_vec = objNull;
	d_rscspect_on = false;
	d_player_can_call_drop = 0;
	d_player_can_call_arti = 0;
	d_player_can_call_cas = 0;
	d_eng_can_repfuel = false;
	d_there_are_enemies_atbase = false;
	d_enemies_near_base = false;
	d_vec_end_time = -1;
	d_rscCrewTextShownTimeEnd = -1;
	d_commandingMenuIniting = false;
	d_DomCommandingMenuBlocked = false;
	d_playerInMHQ = false;
	d_player_in_vec = false;
	d_clientScriptsAr = [false, false];
	d_areArtyVecsAvailable = false;
	d_ao_arty_vecs = [];
	d_misc_hash = createHashMap;
	d_mhqvec_create_cooldown_time = -1;
	d_scoreadd_qeue = [];
	d_scoreadd_script = scriptNull;
	d_weap_hash = createHashMap;
	d_cur_inv_o_gear = [];

	d_virtual_entities = ["d_virt_man_1", "d_virt_man_2", "d_virt_man_3", "d_virt_man_4", "d_virt_man_5"];

	d_last_beam_target = "";

	d_misc_sc_hash = createHashMap;
	d_misc_sc_hash2 = createHashMap;
	
	d_i_r_hash = createHashMapFromArray [
		[0, getText(configFile>>"CfgRanks">>"0">>"texture")],
		[1, getText(configFile>>"CfgRanks">>"1">>"texture")],
		[2, getText(configFile>>"CfgRanks">>"2">>"texture")],
		[3, getText(configFile>>"CfgRanks">>"3">>"texture")],
		[4, getText(configFile>>"CfgRanks">>"4">>"texture")],
		[5, getText(configFile>>"CfgRanks">>"5">>"texture")],
		[6, getText(configFile>>"CfgRanks">>"6">>"texture")],
		[7, getText(configFile>>"CfgRanks">>"7">>"texture")],
		[8, getMissionPath "pics\8star.paa"],
		[9, getMissionPath "pics\6star.paa"],
		[10, getMissionPath "pics\5star.paa"],
		[11, getMissionPath "pics\9star.paa"]
	];
	
	d_num_hash = createHashMapFromArray [
		[0, "00"],
		[1, "01"],
		[2, "02"],
		[3, "03"],
		[4, "04"],
		[5, "05"],
		[6, "06"],
		[7, "07"],
		[8, "08"],
		[9, "09"]
	];
	
	// If you want to add additional non MHQ respawn points like additional bases for example
	// Usage: Each point array needs a unique name, position or marker name, description and a side (side is only valid for the TT version), optional: add create atv action menue entry(true/false; default false)
	// please note, markerPos "somemarker" does not work in prenit, same for getPos some_object, it always returns [0,0,0] as position, so only use the marker name or the object name as string (with "")
	// Example:
	//d_additional_respawn_points = [
	//	["D_UNIQUE_NAME_1", [1023, 5000, 4000], "My Cool Base", blufor, true],
	//	["D_UNIQUE_NAME_2", "myevencoolerbase", "My Even Cooler Base", blufor, false],
	//	["D_UNIQUE_NAME_3", "opforbase", "The Opfor Base", opfor],
	//	["D_UNIQUE_NAME_2", "myevencoolerbase", "My Even Cooler Base", blufor]
	//];
	d_additional_respawn_points = [];

#ifdef __CARRIER__
	d_additional_respawn_points pushBack ["d_air_base", "d_flag_airfield", localize "STR_DOM_MISSIONSTRING_1760", blufor, true, getPosASL D_FLAG_BASE];
#endif

	d_add_resp_points_uni = [];
	d_add_resp_points_pos = [];

	d_earplugs_fitted = false;
	
	d_deploy_mhq_camo = true;
	
	d_near_player_flag = objNull;

	d_player_jescape = 0;
	d_player_canu = true;
	
	d_current_ai_units = [];

	d_phud_loc883 = localize "STR_DOM_MISSIONSTRING_883";
	d_phud_loc884 = localize "STR_DOM_MISSIONSTRING_884";
	d_phud_loc493 = localize "STR_DOM_MISSIONSTRING_493";
	d_yt_loc2037 = localize "STR_DOM_MISSIONSTRING_2037";
	
	d_top10_db_players_client = [];

	d_mt_marker_triggers = [];

	// pre build in are:
	// "CUP_"
	// "rhs_", "rhsgref_", "rhsusf_", "rhssaf_"
	// "uns_"
	// "ace_"
	// "gm_"
	// if you use CUP then only CUP stuff will be shown in Virtual Arsenal
	d_arsenal_mod_prestrings = [];

	// same as above but will remove specific mods
	// for example: "gm_" will remove Global Mobilization
	d_arsenal_mod_remove_strings = [];

	// can either be a class name (string) or code
	// if code then _this is the classname
	d_remove_from_arsenal = [
		[], // PRIMARYWEAPON
		[], // SECONDARYWEAPON
		[], // HANDGUN
		[{getText (configFile>>"CfgWeapons">>_this>>"ItemInfo">>"containerClass") == "Supply500"}, {d_player_side == blufor && {_this in ["u_o_v_soldier_viper_f", "u_o_v_soldier_viper_hex_f"]}}, {_this select [0, 4] == "u_c_" || {_this select [0, 6] == "u_i_c_"}}, "U_OrestesBody", "U_Marshal", "U_Rangemaster", "U_Competitor", {"paradeuniform" in _this}], // uniforms
		[{_this isKindOf ["V_DeckCrew_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["V_EOD_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["V_Safety_base_F", configFile >> "CfgWeapons"]}, "V_Press_F", {_this select [0, 7] == "v_plain"}], // VEST
		[{_this isKindOf "B_HMG_01_weapon_F"}, {_this isKindOf "B_HMG_01_support_F"}, {_this isKindOf "B_HMG_02_support_F"}, {_this select [1, 15] == "_AA_01_weapon_F"}, {_this select [1, 15] == "_AT_01_weapon_F"}, {getText (configFile>>"CfgVehicles">>_this>>"vehicleclass") == "Respawn"}, {"uav_" in _this || {"ugv_" in _this}}, {_this select [1, 11] == "_messenger_"}, {"_everyday_" in _this}, {"_sport_" in _this}], // BACKPACK
		[{d_player_side == blufor && {_this == "H_HelmetO_ViperSP_ghex_F" || {_this == "H_HelmetO_ViperSP_hex_F"}}}, {_this isKindOf ["H_Hat_blue", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_HeadBandage_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_RacingHelmet_1_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_Construction_headset_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_Construction_earprot_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_Construction_basic_base_F", configFile >> "CfgWeapons"]}, {"paradedresscap" in _this}], // HEADGEAR
		[], // GOGGLES
		[], // NVGS
		[], // BINOCULARS
		[], // MAP
		[], // GPS, UAV Terminal
		[], // RADIO
		[], // COMPASS
		[], // WATCH
		[], // FACE
		[], // VOICE
		[], // INSIGNIA
		[], // ITEMOPTIC
		[], // ITEMACC
		[], // ITEMMUZZLE
		[], // CARGOMAG
		[], // CARGOTHROW
		["APERSMineDispenser_Mag"], // CARGOPUT
		[], // CARGOMISC
		[], // ITEMBIPOD
		[] // CARGOMAGALL
	];

#ifdef __CUP__
	(d_remove_from_arsenal # 4) append [{_this select [0, 15] == "CUP_V_B_LHDVest"}];
#endif
#ifdef __GMCWG__
	(d_remove_from_arsenal # 1) pushBack "gm_p2a1_launcher_blk";
	(d_remove_from_arsenal # 0) pushBack "gm_c7a1_oli";
	(d_remove_from_arsenal # 0) pushBack "gm_c7a1_blk";
	(d_remove_from_arsenal # 0) pushBack "gm_gvm95_blk";
#endif
#ifdef __VN__
	if (d_no_mortar_ar == 1) then {
		(d_remove_from_arsenal # 5) append [{"_static_" in _this}, "vn_c_pack_01", "vn_c_pack_02"];
	};
#endif
#ifdef __PRACS__
	(d_remove_from_arsenal # 3) append [{"_Dress_" in _this}];
#endif

	// add here the class names of the weapons which you want to add to Virtual Arsenal
	d_add_to_arsenal = [
		[], // PRIMARYWEAPON
		[], // SECONDARYWEAPON
		[], // HANDGUN
		[], // uniforms
		[], // VEST
		[], // BACKPACK
		[], // HEADGEAR
		[], // GOGGLES
		[], // NVGS
		[], // BINOCULARS
		[], // MAP
		[], // GPS, UAV Terminal
		[], // RADIO
		[], // COMPASS
		[], // WATCH
		[], // FACE
		[], // VOICE
		[], // INSIGNIA
		[], // ITEMOPTIC
		[], // ITEMACC
		[], // ITEMMUZZLE
		[], // CARGOMAG
		[], // CARGOTHROW
		[], // CARGOPUT
		[], // CARGOMISC
		[], // ITEMBIPOD
		[] // CARGOMAGALL
	];

	d_color_hash = createHashMap;

	{
		private _col = getArray(_x>>"color");
		if (_col isNotEqualTo []) then {
			for "_e" from 0 to 3 do {
				if ((_col # _e) isEqualType "") then {
					_col set [_e, call compile (_col # _e)];
				};
			};
		} else {
			_col = [0, 0, 0, 1];
		};
		d_color_hash set [configName _x, _col];
	} forEach ("true" configClasses (configFile >> "CfgMarkerColors"));

	d_prl_fin_id = addMissionEventHandler ["PreloadFinished", {
		d_preloaddone = true;
		diag_log [diag_frameno, diag_ticktime, time, "Preload finished"];
		removeMissionEventHandler ["PreloadFinished", d_prl_fin_id];
		d_prl_fin_id = nil;
	}];

	addMissionEventhandler ["EachFrame", {
		if (!isNull player) then {
			if (isMultiplayer && {isNil "xr_phd_invulnerable"}) then {
				xr_phd_invulnerable = true;
				player setVariable ["d_p_ev_hd_last", time];
			};
			if (!isNil "d_init_processed" && {time > 0}) then {
				if (!isNil "d_preloaddone" && {!isNull (findDisplay 46)}) then {
					diag_log [diag_frameno, diag_tickTime, time, "Executing Dom local player pre start"];
					if !(player isKindOf "VirtualSpectator_F") then {
						call d_fnc_setupplayer;
					};
					removeMissionEventHandler ["EachFrame", _thisEventHandler];
				};
			};
		};
	}];
} else {
	if (!isDedicated) then {
		execVM "setuphc.sqf";
	};
};

if (d_WithVoicesDisabled == 1) then {
	_vn_AI_Group = createGroup sideLogic;
	_vn_AI_Module = _vn_AI_Group createUnit ["vn_module_situationalawarenessmodule_disable", [0, 0, 0], [], 0, "NONE"];
};


// support enemy overrides with server settings (enemy factions)
if (d_enemy_factions > 0) then {
	
	switch (d_enemy_factions) do {
		case 1: {
			d_veh_a_E = [
				#include "d_veh_a_O_faction1-taliban.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","CFP_O_TBAN","Infantry","CFP_O_TBAN_infantry_8man_team"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","CFP_O_TBAN","SpecOps","CFP_O_TBAN_infantry_sniper_team"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["EAST","CFP_O_TBAN","SpecOps","CFP_O_TBAN_infantry_sniper_team"] call d_fnc_GetConfigGroup];
			d_faction_independent_array = [["WEST","CFP_B_AFARMY","Infantry","cfp_b_afarmy_infantry_squad"] call d_fnc_GetConfigGroup];
		};
		case 2: {
			d_veh_a_E = [
				#include "d_veh_a_O_faction2-eastasia.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","CUP_INS_ASIA","Infantry","cupinsasia_infantry_8man_team_a"] call d_fnc_GetConfigGroup,
				["EAST","CUP_INS_ASIA","Infantry","cupinsasia_infantry_8man_team_b"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","CUP_INS_ASIA","Infantry","cupinsasia_infantry_2man_team_b"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["EAST","CUP_INS_ASIA","Infantry","cupinsasia_infantry_2man_team_b"] call d_fnc_GetConfigGroup];
			d_faction_independent_array = [["Indep","CUP_ARMY_ASIA","Infantry","cuparmyasia_infantry_rifle_squad"] call d_fnc_GetConfigGroup];
		};
		case 3: {
			d_veh_a_E = [
				#include "d_veh_a_O_faction3-centralafrica.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["East","CFP_O_CFRebels","Infantry","cfp_o_cfrebels_infantry_squad"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["East","CFP_O_CFRebels","SpecOps","cfp_o_cfrebels_specops_ex_military_fireteam"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["East","CFP_O_CFRebels","SpecOps","o_cfpocfrebels_specops_sniper_team"] call d_fnc_GetConfigGroup];
			d_faction_independent_array = [["Indep","CFP_I_SSArmy","Infantry","CFP_I_SSArmy_infantry_squad"] call d_fnc_GetConfigGroup];
		};
		case 4: {
			d_veh_a_E = [
				#include "d_veh_a_O_faction4-islamicstate.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [["EAST","CFP_O_IS","Infantry","cfp_o_grp_is_inf_squad"] call d_fnc_GetConfigGroup];
			d_specops_E = [
				["EAST","CFP_O_IS","Infantry","cfp_o_grp_is_wpn_squad"] call d_fnc_GetConfigGroup,
				["EAST","CFP_O_IS","Infantry","cfp_o_grp_is_hq_squad"] call d_fnc_GetConfigGroup
			];
			//d_sniper_E = // no sniper class
			d_faction_independent_array = [["WEST","CFP_B_IQARMY","Infantry","cfp_b_grp_ia_inf_squad"] call d_fnc_GetConfigGroup];
		};
		case 5: {
			d_veh_a_E = [
				#include "d_veh_a_O_faction5-sudanarmedforces.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","CFP_O_SDARMY","Infantry","CFP_O_SDARMY_infantry_squad"] call d_fnc_GetConfigGroup,
				["EAST","CFP_O_SDARMY","Infantry","CFP_O_SDARMY_infantry_riot_squad"] call d_fnc_GetConfigGroup,
				["EAST","CFP_O_SDARMY","SpecOps","CFP_O_SDARMY_infantry_at_team"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","CFP_O_SDARMY","SpecOps","CFP_O_SDARMY_specops_paratrooper_squad"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["EAST","CFP_O_SDARMY","SpecOps","CFP_O_SDARMY_infantry_sniper_team"] call d_fnc_GetConfigGroup];
			d_faction_independent_array = [["INDEP","CFP_I_SDRebelsrf","Infantry","CFP_I_SDRebelsrf_infantry_squad"] call d_fnc_GetConfigGroup];
		};
		case 6: {
			d_veh_a_E = [
				#include "d_veh_a_O_faction6-russiangroundforces_desert.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","CFP_O_RUARMY_DES","Infantry","cfp_o_ruarmy_infantry_msv_infantry_squad_emr_des"] call d_fnc_GetConfigGroup,
				["EAST","CFP_O_RUARMY_DES","Infantry","cfp_o_ruarmy_infantry_vdv_infantry_squad_emr_des"] call d_fnc_GetConfigGroup,
				["EAST","CFP_O_RUARMY_DES","Infantry","InfSquad_DES"] call d_fnc_GetConfigGroup,
				["EAST","CFP_O_RUARMY_DES","Infantry","InfTeam_AT_DES"] call d_fnc_GetConfigGroup,
				["EAST","CFP_O_RUARMY_DES","Infantry","O_InfTeam_AT_Heavy_DES"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","CFP_O_RUARMY_DES","SpecOps","cfp_o_ruarmy_specops_spetsnaz_team_des"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["EAST","CFP_O_RUARMY_DES","Infantry","cfp_o_ruarmy_infantry_msv_sniper_team_emr_des"] call d_fnc_GetConfigGroup];
			d_faction_independent_array = [["INDEP","CFP_I_SDRebelsrf","Infantry","CFP_I_SDRebelsrf_infantry_squad"] call d_fnc_GetConfigGroup];
		};
		case 7: {
			d_veh_a_E = [
				#include "d_veh_a_O_faction7-russiangroundforces_winter.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","RWR_ru_winter","RWR_ru_infantry_winter","RWR_group_inf_group"] call d_fnc_GetConfigGroup,
				["EAST","RWR_ru_winter","RWR_ru_infantry_winter","RWR_group_inf_groupmg"] call d_fnc_GetConfigGroup,
				["EAST","RWR_ru_winter","RWR_ru_infantry_winter","RWR_group_inf_teamat"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","RWR_ru_winter","RWR_ru_infantry_winter","RWR_group_inf_groupmg"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["EAST","RWR_ru_winter","RWR_ru_infantry_winter","RWR_group_inf_teamdm"] call d_fnc_GetConfigGroup];
			d_faction_independent_array = [["Indep","IND_F","Infantry","HAF_InfSquad"] call d_fnc_GetConfigGroup];
		};
		case 8: {
			// African Desert Civilian Militia (ADG)
			d_veh_a_E = [
				#include "d_veh_a_O_faction8-african-desert-civil-miltia.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","UK3CB_ADG_O","Infantry","UK3CB_ADG_O_RIF_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_ADG_O","Infantry","UK3CB_ADG_O_AR_ISL_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_ADG_O","Infantry","UK3CB_ADG_O_AT_Squad"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","UK3CB_ADG_O","Infantry","UK3CB_ADG_O_RIF_Squad"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["EAST","UK3CB_ADG_O","Infantry","UK3CB_ADG_O_MK_Sentry"] call d_fnc_GetConfigGroup];
			d_faction_independent_array = [["WEST","UK3CB_ADG_I","Infantry","UK3CB_ADG_I_AR_ISL_Squad"] call d_fnc_GetConfigGroup];
		};
		case 9: {
			// ION Urban
			d_veh_a_E = [
				#include "d_veh_a_O_faction9-ion-urban.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","UK3CB_ION_O_Urban","Infantry","UK3CB_ION_O_Urban_AR_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_ION_O_Urban","Infantry","UK3CB_ION_O_Urban_MG_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_ION_O_Urban","Infantry","UK3CB_ION_O_Urban_RIF_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_ION_O_Urban","Infantry","UK3CB_ION_O_Urban_AT_Squad"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","UK3CB_ION_O_Urban","SpecOps","UK3CB_ION_O_Urban_DEM_SpecTeam"] call d_fnc_GetConfigGroup];
			d_sniper_E = [["EAST","UK3CB_ION_O_Urban","Infantry","UK3CB_ION_O_Urban_MK_Sentry"] call d_fnc_GetConfigGroup];
			//d_faction_independent_array = [["WEST","UK3CB_ADG_I","Infantry","UK3CB_ADG_I_AR_ISL_Squad"] call d_fnc_GetConfigGroup];
		};
		case 10: {
			// Karzeghistan Royal Guard
			d_veh_a_E = [
				#include "d_veh_a_O_faction10-karzeghistan-royal-guard.sqf"
			];
			d_veh_a_W =+ d_veh_a_E;
			d_allmen_E = [
				["EAST","UK3CB_KRG_O","Infantry","UK3CB_KRG_O_AR_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_KRG_O","Infantry","UK3CB_KRG_O_MG_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_KRG_O","Infantry","UK3CB_KRG_O_RIF_Squad"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_KRG_O","Infantry","UK3CB_KRG_O_AT_Squad"] call d_fnc_GetConfigGroup
			];
			d_specops_E = [["EAST","UK3CB_KRG_O","SpecOps","UK3CB_KRG_O_Recon_SpecSquad"] call d_fnc_GetConfigGroup];
			d_sniper_E = [
				["EAST","UK3CB_KRG_O","Infantry","UK3CB_KRG_O_SniperTeam"] call d_fnc_GetConfigGroup,
				["EAST","UK3CB_KRG_O","SpecOps","UK3CB_KRG_O_SF_SniperTeam"] call d_fnc_GetConfigGroup
			];
			//d_faction_independent_array = [["WEST","UK3CB_ADG_I","Infantry","UK3CB_ADG_I_AR_ISL_Squad"] call d_fnc_GetConfigGroup];
		};
	};
	
};


diag_log [diag_frameno, diag_ticktime, time, "Dom fn_preinit.sqf processed"];
