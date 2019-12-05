// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_preinit.sqf"
#include "..\x_setup.sqf"
#include "..\x_dbsetup.sqf"
diag_log format ["############################# %1 #############################", missionName];
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

#ifdef __TANOATT__
d_tt_tanoa = true;
d_tanoa = true;
#else
d_tt_tanoa = false;
#endif

#ifndef __IFA3LITE__
d_ifa3lite = false;
d_kbtel_chan = "SIDE";
#else
d_ifa3lite = true;
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

d_HeliHEmpty = "Land_HelipadEmpty_F";

// BLUFOR, OPFOR or INDEPENDENT for own side, setup in x_setup.sqf
#ifdef __OWN_SIDE_BLUFOR__
d_own_side = "WEST";
d_own_sides = ["WEST"];
d_own_sides_o = [blufor];
d_enemy_side = "EAST";
d_enemy_side_short = "E";
d_rhs_blufor = true;
#endif
#ifdef __OWN_SIDE_OPFOR__
d_own_side = "EAST";
d_own_sides = [["EAST", "GUER"], ["EAST"]] select (!d_ifa3lite);
d_own_sides_o = [[opfor, independent], [opfor]] select (!d_ifa3lite);
d_enemy_side = "WEST";
d_enemy_side_short = "W";
d_rhs_blufor = false;
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
d_own_side = "GUER";
d_own_sides = ["GUER"];
d_own_sides_o = [independent];
d_enemy_side = "EAST";
d_enemy_side_short = "E";
#endif
#ifdef __TT__
d_own_side = "WEST";
d_own_sides = ["WEST"];
d_enemy_side = "GUER";
d_enemy_side_short = "G";
#endif

d_side_enemy = call {
	if (d_enemy_side_short == "E") exitWith {opfor};
	if (d_enemy_side_short == "W") exitWith {blufor};
	if (d_enemy_side_short == "G") exitWith {independent};
};

d_side_player =
#ifdef __OWN_SIDE_OPFOR__
	opfor;
#endif
#ifdef __OWN_SIDE_BLUFOR__
	blufor;
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	independent;
#endif
#ifdef __TT__
	blufor;
#endif

d_version_string =
#ifdef __OWN_SIDE_OPFOR__
	"Opfor";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"Blufor";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"GUER";
#endif
#ifdef __TT__
	"Two Teams";
#endif

#ifdef __IFA3LITE__
d_version_string = "IFA3Lite";
#endif

#ifdef __CARRIER__
d_version_string = "Carrier";
#endif

#ifdef __RHS__
d_version_string = ["RHS Opfor", "RHS Blufor"] select d_rhs_blufor;
#endif

d_e_marker_color =
#ifdef __OWN_SIDE_OPFOR__
	"ColorBLUFOR";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"ColorOPFOR";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"ColorGUER";
#endif
#ifdef __TT__
	"ColorYellow";
#endif

#ifdef __IFA3LITE__
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
#ifdef __IFA3LITE__
#include "sm_bonus_vec_ar_ifa3.sqf"
#endif
#ifdef __ROSCHE__
#include "sm_bonus_vec_ar_altis.sqf"
#endif
#ifdef __GMCWG__
#include "sm_bonus_vec_ar_gmcwg.sqf"
#endif
#ifdef __LIVONIA__
#include "sm_bonus_vec_ar_tanoa.sqf"
#endif
#ifdef __TT__
if (!d_tt_tanoa) then {
#include "sm_bonus_vec_ar_tt.sqf"
} else {
#include "sm_bonus_vec_ar_tt_tanoa.sqf"
};
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

#ifdef __ALTIS__
#include "mt_bonus_vec_ar_altis.sqf"
#endif
#ifdef __LIVONIA__
#include "mt_bonus_vec_ar_tanoa.sqf"
#endif
#ifdef __ROSCHE__
#include "mt_bonus_vec_ar_altis.sqf"
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
#ifdef __IFA3LITE__
#include "mt_bonus_vec_ar_ifa3.sqf"
#endif
#ifdef __TT__
if (!d_tt_tanoa) then {
#include "mt_bonus_vec_ar_tt.sqf"
} else {
#include "mt_bonus_vec_ar_tt_tanoa.sqf"
};
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

#ifndef __TT__
d_sm_bonus_vehicle_array = d_sm_bonus_vehicle_array apply {toLowerANSI _x};
d_mt_bonus_vehicle_array = d_mt_bonus_vehicle_array apply {toLowerANSI _x};
#else
d_sm_bonus_vehicle_array set [0, (d_sm_bonus_vehicle_array # 0) apply {toLowerANSI _x}];
d_sm_bonus_vehicle_array set [1, (d_sm_bonus_vehicle_array # 1) apply {toLowerANSI _x}];
d_mt_bonus_vehicle_array set [0, (d_mt_bonus_vehicle_array # 0) apply {toLowerANSI _x}];
d_mt_bonus_vehicle_array set [1, (d_mt_bonus_vehicle_array # 1) apply {toLowerANSI _x}];
#endif

d_x_drop_array =
#ifdef __OWN_SIDE_INDEPENDENT__
	[[], [localize "STR_DOM_MISSIONSTRING_22", "I_MRAP_03_F"], [localize "STR_DOM_MISSIONSTRING_20", "Box_IND_Ammo_F"]];
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
		[[], [localize "STR_DOM_MISSIONSTRING_22", ["B_MRAP_01_F", "B_T_LSV_01_unarmed_F"] select (d_tanoa || {d_livonia})], [localize "STR_DOM_MISSIONSTRING_20", "Box_NATO_Ammo_F"]]
	};
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_rhs) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "rhs_tigr_m_3camo_vdv"], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]]
		};
		if (d_ifa3lite) exitWith {
			[[], [localize "STR_DOM_MISSIONSTRING_22", "LIB_US_Willys_MB"], [localize "STR_DOM_MISSIONSTRING_20", "LIB_BasicWeaponsBox_SU"]]
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
d_jumpflag_vec = call {
	if (d_gmcwg) exitWith {
		if (d_gmcwgwinter) exitWith {
			"gm_ge_army_iltis_cargo_win"
		};
		"gm_ge_army_iltis_cargo"
	};
	""
};

d_servicepoint_building = "Land_Cargo_House_V2_F";

d_illum_tower = "Land_TTowerBig_2_F";
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
#ifdef __IFA3LITE__
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
#ifdef __ROSCHE__
	"Land_Cargo_Patrol_V4_F";
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

d_mash = "Land_FirstAidKit_01_closed_F";

d_dropped_box_marker = "mil_marker";

d_strongpointmarker = "mil_objective";

d_flag_str_blufor = "\a3\data_f\flags\flag_blue_co.paa";
d_flag_str_opfor = "\a3\data_f\flags\flag_red_co.paa";
d_flag_str_independent = "\a3\data_f\flags\flag_green_co.paa";

d_sm_store = createSimpleObject [d_HeliHEmpty, [0,0,0], true];
d_ef_store = createSimpleObject [d_HeliHEmpty, [0,0,0], true];
d_ef_running = -1;

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
d_farp_classes = ["Land_HelipadSquare_F", "Land_Cargo40_military_green_F"];

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

#ifdef __TT__
if (isNil "d_tt_points") then {
	d_tt_points = [
		30, // points for the main target winner team
		7, // points if draw (main target)
		15, // points for destroying main target radio tower
		5, // points for main target mission
		10, // points for sidemission
		5, // points for capturing a camp (main target)
		10, // points that get subtracted when loosing a mt camp again
		4, // points for destroying a vehicle of the other team
		2 // points for killing a member of the other team
	];
};
#endif

if (isNil "d_cas_available_time") then {
	d_cas_available_time = 600; // time till CAS is available again!
};

d_non_steer_para = "NonSteerable_Parachute_F";

d_the_box = switch (d_own_side) do {
	case "GUER": {"Box_IND_Wps_F"};
	case "EAST": {"Box_East_Wps_F"};
	case "WEST": {"Box_NATO_Wps_F"};
};
d_the_base_box = switch (d_own_side) do {
	case "GUER": {"I_supplyCrate_F"};//Box_IND_WpsSpecial_F
	case "EAST": {"O_supplyCrate_F"};//Box_East_WpsSpecial_F
	case "WEST": {"B_supplyCrate_F"};//Box_NATO_WpsSpecial_F
};

private _confmapsize = call {
	if !(markerPos "d_whole_island" isEqualTo [0,0,0]) exitWith {
		private _ret = (markerSize "d_whole_island" # 0) * 2;
		deleteMarkerLocal "d_whole_island";
		_ret
	};
	getNumber(configFile>>"CfgWorlds">>worldName>>"mapSize")
};
if (_confmapsize == 0) then {_confmapsize = worldSize};
d_island_center = [_confmapsize / 2, _confmapsize / 2, 300];

d_island_x_max = _confmapsize;
d_island_y_max = _confmapsize;

if (isServer) then {
	d_player_store = createSimpleObject [d_HeliHEmpty, [0,0,0], true];
	d_placed_objs_store = createSimpleObject [d_HeliHEmpty, [0,0,0], true];
	d_placed_objs_store2 = createSimpleObject [d_HeliHEmpty, [0,0,0], true];
	d_placed_objs_store3 = createSimpleObject [d_HeliHEmpty, [0,0,0], true];
	d_misc_s_store = createSimpleObject [d_HeliHEmpty, [0,0,0], true];

	d_hc_array = [];
	d_hc_counter = 0;
	d_virtual_spectators = [];
	
	d_fifo_counter = 0;

	d_with_ace = isClass (configFile>>"CfgPatches">>"ace_main");
	publicVariable "d_with_ace";
	d_database_found = false;
	
#ifdef __INTERCEPTDB__
	if (d_interceptdb) then {
		call dsi_fnc_createdbconn;
	};
#else
	if (!isNil "extDB3_var_loaded") then {
		private _extdb3laoded = if (extDB3_var_loaded isEqualType {}) then {
			call extDB3_var_loaded
		} else {
			extDB3_var_loaded
		};
		if (_extdb3laoded) then {
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
				d_database_found = true;
			} else {
				d_database_found = true;
			};
		};
	};
#endif
	publicVariable "d_database_found";
	
	if (d_database_found) then {
		d_use_sql_settings = false;
		
		private _dbresult = [];
#ifndef __INTERCEPTDB__
		_dbresult = parseSimpleArray ("extdb3" callExtension "0:dom:getDomSettings");
		if (_dbresult # 0 != 1) then {
			_dbresult = [];
		} else {
			_dbresult = _dbresult # 1;
		};
#else
		if (isNil "d_interceptdb") then {d_interceptdb = false};
		if (d_interceptdb) then {
			_dbresult = ["getDomSettings"] call dsi_fnc_queryconfig;
		};
#endif
		diag_log "Dom Database result loading dom_settings:";
		{
			diag_log _x;
		} forEach _dbresult;
		if !(_dbresult isEqualTo []) then {
			{
				call {
					if (toLowerANSI (_x # 0) in ["d_reserved_slot", "d_uid_reserved_slots", "d_uids_for_reserved_slots"]) exitWith {
						if !((_x # 1) isEqualTo []) then {
							missionNamespace setVariable [_x # 0, _x # 1, true];
						};
					};
					if (toLowerANSI (_x # 0) in ["d_use_sql_settings", "d_db_auto_save", "d_set_pl_score_db", "d_cas_available_time", "d_ranked_a", "d_points_needed", "d_points_needed_db", "d_ai_groups_respawn_time", "d_launcher_cooldown"]) exitWith {
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
#ifndef __INTERCEPTDB__
			_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:getDomParams2:%1", __DOMDBPARAMNAME]);
			if (_dbresult # 0 != 1) then {
				_dbresult = [];
			} else {
				_dbresult = _dbresult # 1;
			};
#else
			if (d_interceptdb) then {
				_dbresult = ["getDomParams2", [__DOMDBPARAMNAME]] call dsi_fnc_queryconfig
			};
#endif
			diag_log "Dom Database result standard params:";
			{
				diag_log _x;
			} forEach _dbresult;
			if !(_dbresult isEqualTo []) then {
				if (isClass (getMissionConfig "Params")) then {
					private _conf = getMissionConfig "Params";
					if (paramsArray isEqualTo []) then {
						paramsArray resize (count _conf);
					};
					for "_i" from 0 to (count _conf - 1) do {
						private _cname = configName (_conf select _i);
						private _fidx = _dbresult findIf {_x # 0 == _cname};
						if (_fidx != -1) then {
							paramsArray set [_i, _dbresult # _fidx # 1];							
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
						if (_paramval != -99999) then {
							"extdb3" callExtension format ["1:dom:domParamsInsertN:%1:%2:%3", __DOMDBPARAMNAME, _paramName, _paramval];
						};
					};
				};
			};
		};
		if (!isMultiplayer && {!isNil "paramsArray"}) then {
			paramsArray = nil;
		};
	};
	call compile preprocessFileLineNumbers "init\initcommon.sqf";
	
	d_house_objects = [];
	d_house_objects2 = [];
	
	calculatePlayerVisibilityByFriendly false;
	
	if (d_weather == 0) then {
		0 setOvercast (random 1);
		if (d_enable_fog == 0) then {
			private _fog = if (random 100 > 90) then {
				[random 0.1, 0.2, 20 + (random 40)]
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
		forceWeatherChange;
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
#ifdef __ROSCHE__
#include "d_allmen_O_default.sqf"
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
#ifdef __IFA3LITE__
#include "d_allmen_O_default.sqf"
#endif
#ifdef __TT__
if (!d_tt_tanoa) then {
#include "d_allmen_O_default.sqf"
} else {
#include "d_allmen_O_tanoa.sqf"
}
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
	];
	d_allmen_W = [
#ifndef __IFA3LITE__
		#include "d_allmen_B_default.sqf"
#else
		#include "d_allmen_B_ifa3.sqf"
#endif
	];
#ifdef __RHS__
	d_allmen_W = [
		#include "d_allmen_B_RHS.sqf"
	];
	d_allmen_E = [
		#include "d_allmen_O_RHS.sqf"
	];
#endif
#ifdef __IFA3LITE__
	{
		if (count _x > 6) then {
			private _ran = floor random 7;
			if (_ran < 4) then {_ran = 4};
			_x resize _ran;
		};
	} forEach d_allmen_W;
#endif
	d_allmen_G = [
		#include "d_allmen_G_default.sqf"
	];

	d_specops_E = [
#ifdef __ALTIS__
#include "d_specops_O_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_specops_O_livonia.sqf"
#endif
#ifdef __ROSCHE__
#include "d_specops_O_default.sqf"
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
#include "d_specops_O_CUP_SLA.sqf"
#endif
#ifdef __IFA3LITE__
#include "d_specops_O_default.sqf"
#endif
#ifdef __TT__
if (!d_tt_tanoa) then {
#include "d_specops_O_default.sqf"
} else {
#include "d_specops_O_tanoa.sqf"
}
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
	];	

	d_specops_W = call {
		if (d_rhs) exitWith {
			[["West","rhs_faction_socom_marsoc","rhs_group_nato_marsoc_infantry","rhs_group_nato_marsoc_infantry_squad"] call d_fnc_GetConfigGroup, ["West","rhs_faction_socom_marsoc","rhs_group_nato_marsoc_infantry","rhs_group_nato_marsoc_infantry_team"] call d_fnc_GetConfigGroup]
		};
		if (d_ifa3lite) exitWith {
			[["West","SG_STURM","Infantry","SG_GER_AT_squad"] call d_fnc_GetConfigGroup, ["West","SG_STURM","Infantry","SG_GER_infantry_squad"] call d_fnc_GetConfigGroup]
		};
		[["West","BLU_F","Infantry","BUS_ReconTeam"] call d_fnc_GetConfigGroup]
	};
	
	if (d_tanoa || {d_livonia}) then {
		d_sniper_E = [["East","OPF_T_F","Infantry","O_T_SniperTeam"] call d_fnc_GetConfigGroup];
		d_sniper_W = [["West","BLU_T_F","Infantry","B_T_SniperTeam"] call d_fnc_GetConfigGroup];
		d_sniper_I = [["Indep","IND_F","Infantry","HAF_SniperTeam"] call d_fnc_GetConfigGroup];
	} else {
		d_sniper_E = [["East","OPF_F","Infantry","OI_SniperTeam"] call d_fnc_GetConfigGroup];
		d_sniper_W = [["West","BLU_F","Infantry","BUS_SniperTeam"] call d_fnc_GetConfigGroup];
		d_sniper_I = [["Indep","IND_F","Infantry","HAF_SniperTeam"] call d_fnc_GetConfigGroup];
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
	d_sniper_E = [["East","CUP_O_RU","Infantry","CUP_O_RU_SniperTeam_VDV_M_EMR"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","CUP_B_USMC","Infantry","CUP_B_USMC_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","CUP_I_NAPA","Infantry","CUP_I_NAPA_GrpInf_TeamSniper"] call d_fnc_GetConfigGroup];
#endif
#ifdef __CUP_TAKISTAN__
	d_sniper_E = [["East","CUP_O_TK","Infantry","CUP_O_TK_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","CUP_B_US_Army","Infantry","CUP_B_US_Army_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","CUP_I_TK_GUE","Infantry","CUP_I_TK_GUE_SniperTeam"] call d_fnc_GetConfigGroup];
#endif
#ifdef __CUP_SARA__
	d_sniper_E = [["East","CUP_O_SLA","Infantry","CUP_O_SLA_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","CUP_B_US_Army","Infantry","CUP_B_US_Army_SniperTeam"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","CUP_I_RACS","Infantry","CUP_I_RACS_SniperTeam"] call d_fnc_GetConfigGroup];
#endif
#ifdef __IFA3LITE__
	d_sniper_E = [["East","LIB_RKKA","Infantry","LIB_SOV_sniper_team"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","LIB_WEHRMACHT","Infantry","LIB_GER_sniper_team"] call d_fnc_GetConfigGroup];
	d_sniper_I = [["Indep","LIB_US_ARMY","Infantry","LIB_US_Sniper_Team"] call d_fnc_GetConfigGroup];
#endif
#ifdef __RHS__
	d_sniper_E = [["East","rhs_faction_vmf","rhs_group_rus_vmf_infantry_recon","rhs_group_rus_vmf_infantry_recon_squad_sniper"] call d_fnc_GetConfigGroup];
	d_sniper_W = [["West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad_sniper"] call d_fnc_GetConfigGroup];
	d_sniper_G = [["Indep","rhssaf_faction_army","rhssaf_group_army_m10_digital_infantry","rhssaf_group_army_m10_digital_infantry_squad_sniper"] call d_fnc_GetConfigGroup];
#endif

	d_veh_a_E = [
#ifdef __ALTIS__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __LIVONIA__
#include "d_veh_a_O_tanoa.sqf"
#endif
#ifdef __ROSCHE__
#include "d_veh_a_O_default.sqf"
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
#ifdef __IFA3LITE__
#include "d_veh_a_O_default.sqf"
#endif
#ifdef __TT__
#include "d_veh_a_O_default.sqf"
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
	];

#ifdef __TT__
	if (d_tt_tanoa) then {
		d_veh_a_E = [
			#include "d_veh_a_O_tanoa.sqf"
		];
	};
#endif

#ifdef __GMCWG__
	if (d_gmcwgwinter) then {
		d_veh_a_E = [
			#include "d_veh_a_O_gmcwgwin.sqf"
		];
	};
#endif
	d_veh_a_W = [
#ifndef __IFA3LITE__
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
		
	d_veh_a_G = [
		#include "d_veh_a_G_default.sqf"
	];

#ifdef __ALTIS__
	d_arti_observer_E = [["O_recon_JTAC_F"]];
#endif
#ifdef __LIVONIA__
	d_arti_observer_E = [["O_T_Recon_JTAC_F"]];
#endif
#ifdef __ROSCHE__
	d_arti_observer_E = [["O_recon_JTAC_F"]];
#endif
#ifdef __GMCWG__
	d_arti_observer_E = [[["gm_gc_army_squadleader_mpiak74n_80_str"], ["gm_gc_army_squadleader_mpiak74n_80_win"]] select d_gmcwgwinter];
#endif
#ifdef __CUP_CHERNARUS__
	d_arti_observer_E = [["O_recon_JTAC_F"]];
#endif
#ifdef __CUP_TAKISTAN__
	d_arti_observer_E = [["CUP_O_RUS_SpecOps_Scout_Autumn"]];
#endif
#ifdef __CUP_SARA__
	d_arti_observer_E = [["CUP_O_sla_Officer"]];
#endif
#ifdef __IFA3LITE__
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
#ifndef __IFA3LITE__
	d_arti_observer_W = [["B_recon_JTAC_F"]];
#else
	d_arti_observer_W = [["LIB_GER_ober_lieutenant"]];
#endif
#ifdef __RHS__
	d_arti_observer_W = [["rhsusf_army_ocp_jfo"], ["rhsusf_army_ucp_fso"], ["rhsusf_usmc_marpat_d_fso"], ["rhsusf_usmc_marpat_d_jfo"]];
	d_arti_observer_E = [["rhs_vmf_recon_rifleman_scout_akm"], ["rhs_vmf_recon_rifleman_scout"]];
#endif
	d_arti_observer_G = [["I_Soldier_TL_F"]];

	d_number_attack_planes = 1;
	d_number_attack_choppers = 1;
	d_number_attack_uavs = 1;
	
	// Type of aircraft, that will air drop stuff
	d_drop_aircraft =
#ifdef __OWN_SIDE_INDEPENDENT__
		"I_Heli_Transport_02_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
		call {
			if (d_cup) exitWith {
				"CUP_B_C130J_Cargo_USMC"
			};
			if (d_gmcwg) exitWith {
				""
			};
			if (d_rhs) exitWith {
				"RHS_C130J"
			};
			"B_Heli_Transport_01_camo_F"
		};
#endif
#ifdef __OWN_SIDE_OPFOR__
		call {
			if (d_ifa3lite) exitWith {
				"LIB_Pe2"
			};
			if (d_rhs) exitWith {
				"RHS_Mi8mt_Cargo_vv"
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
		"I_Plane_Fighter_03_CAS_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
		call {
			if (d_cup) exitWith {
				"CUP_B_A10_CAS_USA"
			};
			if (d_gmcwg) exitWith {
				""
			};
			if (d_rhs) exitWith {
				"RHS_A10"
			};
			"B_Plane_CAS_01_F"
		};
#endif
#ifdef __OWN_SIDE_OPFOR__
		call {
			if (d_ifa3lite) exitWith {
				"LIB_P47"
			};
			if (d_rhs) exitWith {
				"RHS_Su25SM_vvsc"
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

	d_cas_plane_ai =
#ifdef __OWN_SIDE_INDEPENDENT__
		"";
#endif
#ifdef __OWN_SIDE_BLUFOR__
		call {
			if (d_ifa3lite) exitWith {
				"LIB_P47"
			};
			if (d_cup) exitWith {
				"CUP_O_Su25_Dyn_RU"
			};
			if (d_gmcwg) exitWith {
				""
			};
			if (d_rhs) exitWith {
				"RHS_Su25SM_vvsc"
			};
			"O_Plane_CAS_02_F"
		};
#endif
#ifdef __OWN_SIDE_OPFOR__
		call {
			if (d_ifa3lite) exitWith {
				"LIB_Ju87"
			};
			if (d_cup) exitWith {
				"CUP_B_A10_CAS_USA"
			};
			if (d_rhs) exitWith {
				"RHS_A10"
			};
			"B_Plane_CAS_01_F"
		};
#endif
#ifdef __TT__
		"I_Plane_Fighter_03_CAS_F";
#endif

	// max men for main target clear
	d_man_count_for_target_clear = 6;
	// max tanks for main target clear
	d_tank_count_for_target_clear = 1;
	// max cars for main target clear
	d_car_count_for_target_clear = 1;
		
	// time (in sec) between attack planes and choppers over main target will respawn once they were shot down (a random value between 0 and 240 will be added)
	d_airai_respawntime = 1200;

	d_side_missions_random = [];
	d_player_created = [];

	d_time_until_next_sidemission = [
		[10,300], // if player number <= 10, it'll take 300 seconds until the next sidemission
		[20,400], // if player number <= 20, it'll take 400 seconds until the next sidemission
		[30,500], // if player number <= 30, it'll take 500 seconds until the next sidemission
		[500,600] // if player number > 30, it'll take 600 seconds until the next sidemission
	];

	if (d_gmcwg) then {
		d_civilians_t = ["gm_gc_civ_man_01_80_blk","gm_gc_civ_man_01_80_blu","gm_gc_civ_man_02_80_brn","gm_gc_civ_man_02_80_gry","gm_gc_pol_officer_80_blu"];
	} else {
		d_civilians_t = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
	};

	d_base_aa_vec =
#ifdef __OWN_SIDE_INDEPENDENT__
	"I_LT_01_AA_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	call {
		if (d_cup) exitWith {
			"CUP_B_M6LineBacker_USA_W"
		};
		if (d_rhs) exitWith	{
			"RHS_M6_wd"
		};
		if (d_gmcwg) exitWith {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_gepard1a1_win"
			};
			"gm_ge_army_gepard1a1"
		};
		if (d_tanoa || {d_livonia}) exitWith {
			"B_T_APC_Tracked_01_AA_F"
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
		if (d_ifa3lite) exitWith {
			"LIB_61k"
		};
		"O_APC_Tracked_02_AA_F"
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
#ifdef __ROSCHE__
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
#ifdef __IFA3LITE__
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

	d_hd_sim_types = ["SHOTPIPEBOMB", "SHOTTIMEBOMB", "SHOTDIRECTIONALBOMB", "SHOTMINE"];
	d_hd_sim_types = d_hd_sim_types apply {toLowerANSI _x};

	d_isle_defense_marker = "n_mech_inf";

	d_air_radar = switch (d_enemy_side_short) do {
		case "W": {"Land_Radar_Small_F"};
		case "E": {"Land_Radar_Small_F"};
		case "G": {"Land_Radar_Small_F"};
	};
	
	d_air_radar2 = switch (d_enemy_side_short) do {
		case "W": {"Land_MobileRadar_01_radar_F"};
		case "E": {"Land_MobileRadar_01_radar_F"};
		case "G": {"Land_MobileRadar_01_radar_F"};
	};

	d_enemy_hq = switch (d_enemy_side_short) do {
		case "E": {"Land_Cargo_HQ_V1_F"};
		case "W": {"Land_Cargo_HQ_V1_F"};
		case "G": {"Land_Cargo_HQ_V1_F"};
	};

	// type of enemy plane that will fly over the main target
	d_airai_attack_plane = switch (d_enemy_side_short) do {
		case "E": {
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
				["O_Plane_CAS_02_F"]
			};
		};
		case "W": {
			call {
				if (d_ifa3lite) exitWith {
					["LIB_FW190F8", "LIB_FW190F8_4", "LIB_FW190F8_2", "LIB_FW190F8_5", "LIB_FW190F8_3"]
				};
				if (d_rhs) exitWith {
					["RHS_A10","rhsusf_f22"]
				};
				["B_Plane_CAS_01_F"]
			};
		};
		case "G": {["I_Plane_Fighter_03_CAS_F"]};
	};

       // type of enemy UAV that will fly over the main target
	d_airai_attack_uav = switch (d_enemy_side_short) do {
		case "E": {
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
				if (d_ifa3lite) exitWith {
					[]
				};
				["O_UAV_02_F","O_UAV_02_CAS_F","O_T_UAV_04_CAS_F"]
			};
		};
		case "W": {
			call {
				if (d_cup) exitWith {
					["CUP_B_USMC_DYN_MQ9"]
				};			
				if (d_ifa3lite) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					[]
				};
				if (d_gmcwg) exitWith {
					[]
				};
				["B_T_UAV_03_F", "B_UAV_02_F", "B_UAV_05_F"]
			};
		};
		case "G": {
			call {
				if (d_cup) exitWith {
					[]
				};			
				if (d_ifa3lite) exitWith {
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
	d_airai_attack_chopper = switch (d_enemy_side_short) do {
		case "E": {
			call {
				if (d_cup) exitWith {
					["O_Heli_Attack_02_F","CUP_O_Mi24_P_RU","CUP_O_Mi24_V_RU","CUP_O_Ka50_SLA"]
				};
				if (d_gmcwg) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					["RHS_Mi24P_vdv","RHS_Mi24V_vdv","RHS_Ka52_vvsc","RHS_Mi24P_vvsc","RHS_Mi24Vt_vvsc","rhs_mi28n_vvsc"]
				};
				["O_Heli_Attack_02_F"]
			};
		};
		case "W": {
			call {
				if (d_ifa3lite) exitWith {
					["LIB_Ju87_Italy2", "LIB_Ju87_Italy", "LIB_Ju87"]
				};
				if (d_rhs) exitWith {
					["RHS_AH64D","RHS_AH64DGrey","RHS_AH64D_wd","RHS_AH1Z","RHS_AH1Z_wd"]
				};
				["B_Heli_Attack_01_F"]
			};
		};
		case "G": {["I_Heli_light_03_F"]};
	};

#ifdef __ALTIS__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["B_T_VTOL_01_infantry_blue_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __ROSCHE__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["B_T_VTOL_01_infantry_blue_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __GMCWG__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {[]};
		case "W": {[]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
	if (d_enemy_side_short == "E" && {isClass(configFile>>"CfgVehicles">>"CUP_O_Mi8_VIV_RU")}) then {
		d_transport_chopper = ["CUP_O_Mi8_VIV_RU"];
	};
#endif
#ifdef __TANOA__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["B_T_VTOL_01_infantry_blue_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __LIVONIA__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["B_T_VTOL_01_infantry_blue_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __STRATIS__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["B_T_VTOL_01_infantry_blue_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __MALDEN__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["B_T_VTOL_01_infantry_blue_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __IFA3LITE__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["LIB_RBAF_Ju87"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __TT__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_T_VTOL_02_infantry_grey_F"]};
		case "W": {["B_T_VTOL_01_infantry_blue_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __CUP_CHERNARUS__
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["CUP_O_MI6T_RU"]};
		case "W": {["B_Heli_Light_01_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __CUP_SARA__
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["CUP_O_Mi8_SLA_1"]};
		case "W": {["B_Heli_Light_01_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __CUP_TAKISTAN__
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["CUP_O_AN2_TK"]};
		case "W": {["B_Heli_Light_01_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif
#ifdef __RHS__
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["RHS_Mi8MTV3_vvsc"]};
		case "W": {["rhsusf_CH53E_USMC"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif

	// light attack chopper (for example I_Heli_light_03_F with MG)
	d_light_attack_chopper = switch (d_enemy_side_short) do {
		case "E": {
			call {
				if (d_cup) exitWith {
					["O_Heli_Attack_02_black_F", "CUP_O_Mi8_RU"]
				};
				if (d_gmcwg) exitWith {
					[]
				};
				if (d_rhs) exitWith {
					["RHS_Mi24P_vvs"]
				};
				["O_Heli_Attack_02_black_F"]
			};
		};
		case "W": {
			call {
				if (d_ifa3lite) exitWith {
					["LIB_Ju87_Italy2"]
				};
				if (d_rhs) exitWith {
					["RHS_MELB_AH6M","RHS_UH1Y_d","RHS_UH1Y"]
				};
				["B_Heli_Light_01_armed_F"]
			};
		};
	};

	// enemy AI inf barracks in main target... As long as the building exists enemy AI inf respawns inside the building thus in the main target area!!!
	// Needs a building which can be entered by AI (as they will respawn inside)
	// can only be destroyed by satchel charges!!!
	// no marker gets created!
	d_barracks_building =
#ifdef __ALTIS__
		"Land_BagBunker_Large_F";
#endif
#ifdef __CUP_CHERNARUS__
		"Land_BagBunker_01_large_green_F";
#endif
#ifdef __CUP_TAKISTAN__
		"Land_BagBunker_Large_F";
#endif
#ifdef __CUP_SARA__
		"Land_BagBunker_Large_F";
#endif
#ifdef __IFA3LITE__
		"Land_BagBunker_01_large_green_F";
#endif
#ifdef __TANOA__
		"Land_BagBunker_01_large_green_F";
#endif
#ifdef __STRATIS__
		"Land_BagBunker_Large_F";
#endif
#ifdef __MALDEN__
		"Land_BagBunker_Large_F";
#endif
#ifdef __ROSCHE__
		"Land_BagBunker_01_large_green_F";
#endif
#ifdef __LIVONIA__
		"Land_BagBunker_01_large_green_F";
#endif
#ifdef __TT__
		"Land_BagBunker_Large_F";
#endif
#ifdef __GMCWG__
		"Land_BagBunker_01_large_green_F";
#endif
	
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
#ifdef __IFA3LITE__
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
#ifdef __ROSCHE__
		"Land_Cargo_HQ_V4_F";
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
	
	if (isNil "d_ai_groups_respawn_time") then {
		// inf base time, inf min time, vehicle base time, vehicle min time, all in seconds
		// means, inf base time minus number of players but at least wait 130 to respawn a group, same for vehicles
		// can also be put into the dom_settings in Domination sql DB
		d_ai_groups_respawn_time = [250, 150, 320, 170];
	};
};

if (hasInterface) then {
	__TRACE("preInit hasInterface")
	// d_reserved_slot gives you the ability to add reserved slots for admins
	// if you don't log in when you've chosen the slot, you'll get kicked after ~20 once the intro ended
	// default is no check, example: d_reserved_slot = ["d_artop_1"];
	if (isNil "d_reserved_slot") then {
		d_reserved_slot = [];
	};

	// d_uid_reserved_slots and d_uids_for_reserved_slots gives you the possibility to limit a slot
	// you have to add the var names of the units to d_uid_reserved_slots and in d_uids_for_reserved_slots the UIDs of valid players
	// d_uid_reserved_slots = ["d_alpha_1", "d_bravo_3"];
	// d_uids_for_reserved_slots = ["1234567", "7654321"];
	if (isNil "d_uid_reserved_slots") then {
		d_uid_reserved_slots = [];
		d_uids_for_reserved_slots = [];
	};
	
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
		["B_Quadbike_01_F", "B_LSV_01_unarmed_F"]
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
		if (d_ifa3lite) exitWith {
			["LIB_Willys_MB", "LIB_US_Willys_MB"]
		};
		["O_Quadbike_01_F", "O_LSV_02_unarmed_F"]
	};
#endif
#ifdef __TT__
	["O_Quadbike_01_F"];
#endif

	if (d_weather == 1) then {
		0 setOvercast 0;
	};
	
#ifdef __OWN_SIDE_BLUFOR__
	d_UAV_Small = "B_UAV_01_F";
	d_UAV_Terminal = "B_UavTerminal";
#endif
#ifdef __OWN_SIDE_OPFOR__
	d_UAV_Small = "O_UAV_01_F";
	d_UAV_Terminal = "O_UavTerminal";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	d_UAV_Small = "I_UAV_01_F";
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
	["B_Heli_Light_01_F", "B_MRAP_01_F", "B_APC_Tracked_01_CRV_F", "B_T_APC_Tracked_01_CRV_F","CUP_B_M1133_MEV_Woodland","CUP_B_LAV25_HQ_USMC","CUP_B_M1133_MEV_Desert","CUP_B_UH1Y_UNA_USMC","I_Heli_light_03_unarmed_F","RHS_MELB_MH6M","rhsusf_M1232_usarmy_wd","gm_ge_army_m113a1g_command","gm_ge_army_fuchsa0_command","CUP_B_UH1D_GER_KSK","I_E_Heli_light_03_unarmed_F"];
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_ifa3lite) exitWith {
			["LIB_US6_Tent"]
		};
		["O_MRAP_02_F", "O_Heli_Light_02_unarmed_F", "B_APC_Tracked_01_CRV_F", "rhsgref_BRDM2UM_vdv", "RHS_Mi8AMT_vvs"]
	};
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	["I_MRAP_03_F", "I_Heli_light_03_unarmed_F","I_E_Heli_light_03_unarmed_F"];
#endif
#ifdef __TT__
	["B_Heli_Light_01_F", "B_APC_Tracked_01_CRV_F", "O_Heli_Light_02_unarmed_F", "B_T_APC_Tracked_01_CRV_F"];
#endif
	
	d_check_ammo_load_vecs = d_check_ammo_load_vecs apply {toLowerANSI _x};

	d_weapon_respawn = true;

	// points needed to get a specific rank
	// gets even used in the unranked versions
#ifndef __TT__
	if (isNil "d_points_needed") then {
		d_points_needed = [
			20, // Corporal
			50, // Sergeant
			90, // Lieutenant
			140, // Captain
			200, // Major
			270, // Colonel
			500 // General
		];
	};
	
	if (isNil "d_points_needed_db") then {
		d_points_needed_db = [
			500, // Corporal
			2000, // Sergeant
			5000, // Lieutenant
			9000, // Captain
			14000, // Major
			20000, // Colonel
			30000 // General
		];
	};
#else
	if (isNil "d_points_needed") then {
		d_points_needed = [
			100, // Corporal
			400, // Sergeant
			800, // Lieutenant
			1600, // Captain
			3000, // Major
			5000, // Colonel
			8000 // General
		];
	};
	
	if (isNil "d_points_needed_db") then {
		d_points_needed_db = [
			500, // Corporal
			2000, // Sergeant
			5000, // Lieutenant
			9000, // Captain
			14000, // Major
			20000, // Colonel
			30000 // General
		];
	};
#endif

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

	d_jump_helo =
#ifdef __OWN_SIDE_BLUFOR__
	call {
		if (d_rhs) exitWith {
			"RHS_UH1Y_UNARMED_d"
		};
		if (d_gmcwg) exitWith {
			""
		};
		"B_Heli_Transport_01_F"
	};
#endif
#ifdef __OWN_SIDE_OPFOR__
	call {
		if (d_ifa3lite) exitWith {
			"LIB_Ju87_Italy2"
		};
		if (d_rhs) exitWith {
			"RHS_Mi8mt_vvs"
		};
		"O_Heli_Light_02_unarmed_F"
	};
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"I_Heli_light_03_unarmed_F";
#endif
#ifdef __TT__
	"I_Heli_light_03_unarmed_F";
#endif
	
	d_headbug_vehicle = "B_Quadbike_01_F";
	
	d_drop_max_dist = 500;

	// if the array is empty, anybody with a pilot uniform and headgear can fly (if the latter is enabled)
	// if you add the string name of playable units (var name in the editor) only those players get a pilot uniform and headgear
	// makes only sense when only pilots can fly is enabled
	// for example: ["pilot_1","pilot_2"];, case sensitiv
	// PLEASE DO NOT CHANGE THIS FOR THE TT VERSION, IT SHOULD BE AN EMPTY ARRAY!!!!
	d_only_pilots_can_fly = [];
	
	// array now so players can select different air taxi types
	d_taxi_aircrafts =
#ifdef __OWN_SIDE_INDEPENDENT__
		["I_Heli_Transport_02_F"];
#endif
#ifdef __OWN_SIDE_BLUFOR__
		call {
			if (d_cup) exitWith {
				["CUP_B_MV22_USMC"]
			};
			if (d_gmcwg) exitWith {
				[]
			};
			if (d_rhs) exitWith {
				["RHS_UH60M2"]
			};
			["B_T_VTOL_01_infantry_F", "B_Heli_Transport_03_unarmed_F", "B_Heli_Light_01_F", "B_Heli_Transport_01_F"]
		};
#endif
#ifdef __OWN_SIDE_OPFOR__
		call {
			if (d_rhs) exitWith {
				["RHS_Mi8mt_Cargo_vv"]
			};
			["O_T_VTOL_02_infantry_dynamicLoadout_F"]
		};
#endif
#ifdef __TT__
		["O_Heli_Light_02_unarmed_F"];
#endif

	if (isNil "d_launcher_cooldown") then {
		// player AT launcher cooldown time, means, a player can't use a guided launcher like the Titan for 60
		// The projectile gets deleted and a magazine added again to the player inventory
		// can be changed in the database dom_settings table too
		d_launcher_cooldown = d_launcher_cooldownp;
	};
	
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
	d_misc_store = createSimpleObject [d_HeliHEmpty, [0,0,0], true];
	d_mhqvec_create_cooldown_time = -1;
	d_scoreadd_qeue = [];
	d_scoreadd_script = scriptNull;
	
	d_virtual_entities = ["d_virt_man_1", "d_virt_man_2", "d_virt_man_3", "d_virt_man_4", "d_virt_man_5"];
	
	d_last_beam_target = "";
	
	d_misc_sc_store = createSimpleObject [d_HeliHEmpty, [0,0,0], true];

	// If you want to add additional non MHQ respawn points like additional bases for example
	// Usage: Each point array needs a unique name, position or marker name, description and a side (side is only valid for the TT version), optional: add create atv action menue entry(true/false; default false)
	// please note, markerPos "somemarker" does not work in prenit, same for getPos some_object, it always returns [0,0,0] as position, so only use the marker name or the object name as string (with "")
	// Example:
	//d_additional_respawn_points = [
	//	["D_UNIQUE_NAME_1", [1023, 5000, 4000], "My Cool Base", blufor],
	//	["D_UNIQUE_NAME_2", "myevencoolerbase", "My Even Cooler Base", blufor],
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
#ifndef __TT__
	d_maintarget_auto_vd = true;
#else
	d_maintarget_auto_vd = false;
#endif
	
	d_phud_loc883 = localize "STR_DOM_MISSIONSTRING_883";
	d_phud_loc884 = localize "STR_DOM_MISSIONSTRING_884";
	d_phud_loc493 = localize "STR_DOM_MISSIONSTRING_493";
	
	// pre build in are:
	// "CUP_"
	// "rhs_", "rhsgref_", "rhsusf_", "rhssaf_"
	// "uns_"
	// "ace_"
	// "gm_"
	// if you use CUP then only CUP stuff will be shown in Virtual Arsenal
	d_arsenal_mod_prestrings = [];
	
	if (isClass(configFile>>"CfgPatches">>"uns_main")) then {
		// now Virtual Arsenal will only show Unsung stuff; of course if you add other modes it will show them too
		d_arsenal_mod_prestrings pushBack "uns_";
	};
	
	// same as above but will remove specific mods
	// for example: "gm_" will remove Global Mobilization
	d_arsenal_mod_remove_strings = [];
	
	// can either be a class name (string) or code
	// if code then _this is the classname
	d_remove_from_arsenal = [
		[], // rifles
		[], // launchers
		[], // handguns
		[{getText (configFile>>"CfgWeapons">>_this>>"ItemInfo">>"containerClass") == "Supply500"}, {d_player_side == blufor && {_this == "U_O_V_Soldier_Viper_F" || {_this == "U_O_V_Soldier_Viper_hex_F"}}}, {_this select [0, 4] == "U_C_"}, {_this == "U_OrestesBody"}], // uniforms
		[{_this isKindOf ["V_DeckCrew_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["V_EOD_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["V_Safety_base_F", configFile >> "CfgWeapons"]}], // vests
		[{_this isKindOf "B_HMG_01_weapon_F"}, {_this isKindOf "B_HMG_01_support_F"}, {_this select [1, 15] == "_AA_01_weapon_F"}, {_this select [1, 15] == "_AT_01_weapon_F"}, {getText (configFile>>"CfgVehicles">>_this>>"vehicleclass") == "Respawn"}, {_this find "UAV_" != -1 || {_this find "UGV_" != -1}}], // backpacks
		[{d_player_side == blufor && {_this == "H_HelmetO_ViperSP_ghex_F" || {_this == "H_HelmetO_ViperSP_hex_F"}}}, {_this isKindOf ["H_Hat_blue", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_HeadBandage_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_RacingHelmet_1_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_Construction_headset_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_Construction_earprot_base_F", configFile >> "CfgWeapons"]}, {_this isKindOf ["H_Construction_basic_base_F", configFile >> "CfgWeapons"]}], // headgear
		[], // glasses
		[], // goggles
		[], // binoculars
		[], // ItemMap
		[], // ItemGPS, UAV Terminal
		[], // ItemRadio
		[], // ItemCompass
		[], // ItemWatch
		[], // Heads
		[], // Language?
		[], // signs
		[],
		[],
		[],
		[],
		[], // Grenades
		["APERSMineDispenser_Mag"], // Charges
		[], // MineDector, FirstAidkit, MediKit
		[],
		[] // magazines
	];
#ifdef __CUP__
	(d_remove_from_arsenal # 4) append [{_this select [0, 15] == "CUP_V_B_LHDVest"}];
#endif
#ifdef __GMCWG__
	(d_remove_from_arsenal # 1) pushBack "gm_p2a1_launcher_blk";
#endif

	if (d_no_mortar_ar == 1) then {
		(d_remove_from_arsenal # 5) append [{_this isKindOf "Weapon_Bag_Base"}];
	};
	
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
						call compile preprocessFileLineNumbers "client\x_setupplayer.sqf";
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

diag_log [diag_frameno, diag_ticktime, time, "Dom fn_preinit.sqf processed"];
