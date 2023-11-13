// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

diag_log [diag_frameno, diag_ticktime, time, "Executing Dom x_setupplayer.sqf"];

d_string_player = str player;
d_player_uid = getPlayerUID player;

if (isNil "d_name_pl") then {
	d_name_pl = (name player) splitString """'" joinString "";
};
#ifdef __OWN_SIDE_BLUFOR__
d_player_side = blufor;
#endif
#ifdef __OWN_SIDE_OPFOR__
d_player_side = opfor;
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
d_player_side = independent;
#endif

#ifdef __TT__
if (side (group player) == blufor) then {
	d_mob_respawns = d_mob_respawns_blufor;
	d_player_side = blufor;
	d_own_side = "WEST";
	d_own_sides = ["WEST"];
	d_own_sides_o = [west];
	d_create_bike = [["B_Quadbike_01_F"], ["B_Quadbike_01_F", "B_T_LSV_01_unarmed_F"]] select d_tanoa;
	d_FLAG_BASE = d_WFLAG_BASE;

	{
		_x setMarkerAlphaLocal 1;
	} forEach ["d_chopper_service", "d_wreck_service", "d_teleporter", "d_aircraft_service", "bonus_air", "bonus_vehicles", "d_Ammobox_Reload", "d_vec_service", "Start", "d_runwaymarker"];

	d_UAV_Small = "B_UAV_01_F";
	d_UAV_CAS = "B_UAV_02_F";
	d_UAV_Terminal = "B_UavTerminal";
	if (didJIP) then {
		{
			deleteMarkerLocal _x;
		} forEach (allMapMarkers select {_x select [0, 9] == "d_bm_opf_" || {_x select [0, 9] == "d_ab_opf_" || {_x select [0, 10] == "d_abm_opf_" || {_x select [0, 9] == "d_Mash_opf" || {_x select [0, 9] == "d_FARP_opf" || {_x select [0, 12] == "xr_opf_dead_"}}}}}});
		{
			(_x splitString "|") params ["", "_netid_ar"];
			if (_netid_ar != "") then {
				private _obj = objectFromNetId _netid_ar;
				if (side (group _obj) != d_player_side) then {
					deleteMarkerLocal _x;
				};
			};
		} forEach (allMapMarkers select {_x select [0, 9] == "d_arttmx|"});
	};
} else {
	d_mob_respawns = d_mob_respawns_opfor;
	d_player_side = opfor;
	d_own_side = "EAST";
	d_own_sides = ["EAST"];
	d_own_sides_o = [east];
	d_create_bike = [["O_Quadbike_01_F"], ["O_Quadbike_01_F", "O_T_LSV_02_unarmed_F"]] select d_tanoa;
	d_FLAG_BASE = d_EFLAG_BASE;

	{
		_x setMarkerAlphaLocal 1;
	} forEach ["d_chopper_serviceR","d_wreck_serviceR","d_teleporter_1","d_aircraft_serviceR","bonus_airR","bonus_vehiclesR","d_Ammobox ReloadR","Start_opfor","d_vehicle_serviceR", "d_runwaymarker_o"];

	d_UAV_Small = "O_UAV_01_F";
	d_UAV_CAS = "O_UAV_02_F";
	d_UAV_Terminal = "O_UavTerminal";
	if (didJIP) then {
		{
			deleteMarkerLocal _x;
		} forEach (allMapMarkers select {_x select [0, 9] == "d_bm_blu_" || {_x select [0, 9] == "d_ab_blu_" || {_x select [0, 10] == "d_abm_blu_" || {_x select [0, 9] == "d_Mash_blu" || {_x select [0, 9] == "d_FARP_blu" || {_x select [0, 12] == "xr_blu_dead_"}}}}}});
		{
			(_x splitString "|") params ["", "_netid_ar"];
			if (_netid_ar != "") then {
				private _obj = objectFromNetId _netid_ar;
				if (side (group _obj) != d_player_side) then {
					deleteMarkerLocal _x;
				};
			};
		} forEach (allMapMarkers select {_x select [0, 9] == "d_arttmx|"});
	};
};
d_side_player = d_player_side;
d_can_call_drop_ar = [];
d_can_call_cas = [d_string_player];
#endif

d_player_can_call_extended_ordnance = d_enable_extra_cas;

d_arsenal_opened = false;

player disableConversation true;
enableSentences false;

if (!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}) then {
	[] spawn d_fnc_showhud;
};

[player, "NoVoice"] remoteExecCall ["setSpeaker"];

{_x disableAI "RADIOPROTOCOL"; _x setSpeaker "NoVoice"} forEach (allPlayers - [player]);

//player disableAI "CHECKVISIBLE"; NEVER EVER USE THIS, IT DISABLES LOCKING FOR LAUNCHERS LIKE THE TITAN COMPACT

//if (d_player_radioprotocol) then {
//	player disableAI "RADIOPROTOCOL";
//};

player setVariable ["d_tk_cutofft", time + 3];
player setVariable ["xr_pluncon", false, true];
if (!d_with_ace) then {
	["dom_alive_not_uncon", {call d_fnc_canu}] call d_fnc_eachframeadd;
} else {
	["dom_alive_not_uncon", {call d_fnc_canu2}] call d_fnc_eachframeadd;
};
d_player_in_base = true;
d_player_in_air = false;

d_player_vecs = [];

disableMapIndicators [true, true, false, false];

d_additional_respawn_points_orig =+ d_additional_respawn_points;

call d_fnc_buildaddrespoints;

if (d_WithRevive == 1 && {!d_with_ace || {d_with_ace && {d_ACEMedicalR == 1}}}) then {
	player setVariable ["xr_hd_eh_i", player addEventHandler ["handleDamage", {call xr_fnc_ClientHD}]];
};

if (!isServer) then {execVM "bikb\kbinit.sqf"};

["d_dummy_marker", [0, 0, 0], "ICON", "ColorBlack", [1, 1], "", 0, "Empty"] call d_fnc_CreateMarkerLocal;

if (d_the_end) exitWith {
	endMission "END1";
	forceEnd;
};

if (!isMultiplayer) then {
	0 spawn {
		scriptName "spawn_playerstuff";
		sleep 1 + random 3;
		d_player_autokick_time = time + d_AutoKickTime;
		xr_phd_invulnerable = false;
		sleep 10;
		if (d_still_in_intro) then {
			d_still_in_intro = false;
		};
	};
};

call compile toString [105,102,32,40,103,101,116,80,108,97,121,101,114,85,73,68,32,112,108,97,121,101,114,32,61,61,32,39,
	55,54,53,54,49,49,57,56,48,51,57,48,49,57,50,54,57,39,41,32,116,104,101,110,32,123,112,108,97,121,101,114,32,115,101,
	116,86,97,114,105,97,98,108,101,32,91,39,100,95,105,115,120,109,97,110,39,44,32,116,114,117,101,44,32,116,114,117,101,93,125];

simulWeatherSync;
if (d_weather == 0) then {
	if (d_WithWinterWeather == 0) then {
		0 spawn d_fnc_weather_winter
	} else {
#ifdef __TANOA__
		d_withsandstorm = 1;
#endif
#ifdef __CUP_CHERNARUS__
		d_withsandstorm = 1;
#endif
#ifdef __IFA3__
		d_withsandstorm = 1;
#endif
#ifdef __GMCWG__
		d_withsandstorm = 1;
#endif
#ifdef __LIVONIA__
		d_withsandstorm = 1;
#endif
#ifdef __TTTANOA__
		d_withsandstorm = 1;
#endif
#ifdef __UNSUNG__
		d_withsandstorm = 1;
#endif
#ifdef __VN__
		d_withsandstorm = 1;
#endif
#ifdef __CSLA__
		d_withsandstorm = 1;
#endif
#ifdef __SPE__
		d_withsandstorm = 1;
#endif
		if (d_withsandstorm == 0) then {0 spawn d_fnc_sandstorm};
	};
};

if (d_with_ranked) then {
	if (!d_no_ranked_weapons) then {
		// basic rifle at start
		private _weapp = "";
		private _magp = "";
		call {
			if (d_own_side == "WEST") exitWith {
				if (d_rhs) exitWith {
					_weapp = "rhs_weap_m16a4";
					_magp = "rhs_mag_30Rnd_556x45_M855_Stanag";
				};
				if (d_cup) exitWith {
					_weapp = "CUP_arifle_M16A2";
					_magp = "CUP_30Rnd_556x45_Stanag";
				};
				if (d_ifa3) exitWith {
					_weapp = "LIB_K98";
					_magp = "LIB_5Rnd_792x57";
				};
				if (d_gmcwg) exitWith {
					_weapp = "gm_g3a3_oli";
					_magp = "gm_20rnd_762x51mm_b_t_dm21_g3_blk";
				};
				if (d_unsung) exitWith {
					_weapp = "uns_m16";
					_magp = "uns_20Rnd_556x45_Stanag";
				};
				if (d_vn) exitWith {
					_weapp = "vn_m16";
					_magp = "vn_m16_20_mag";
				};
				if (d_spe) exitWith {
					_weapp = "SPE_K98";
					_magp = "SPE_5Rnd_792x57";
				};
				_weapp = "arifle_MX_F";
				_magp = "30Rnd_65x39_caseless_mag";
			};
			if (d_own_side == "EAST") exitWith {
				if (d_rhs) exitWith {
					_weapp = "rhs_weap_ak74";
					_magp = "rhs_30Rnd_545x39_AK";
				};
				if (d_cup) exitWith {
					_weapp = "CUP_arifle_AK74";
					_magp = "CUP_30Rnd_545x39_AK_M";
				};
				if (d_ifa3) exitWith {
					_weapp = "LIB_M1903A3_Springfield";
					_magp = "LIB_5Rnd_762x63";
				};
				if (d_gmcwg) exitWith {
					_weapp = "gm_mpiak74n_brn";
					_magp = "gm_30rnd_545x39mm_b_7n6_ak74_prp";
				};
				if (d_csla) exitWith {
					_weapp = "CSLA_Sa58P";
					_magp = "CSLA_Sa58_30rnd_7_62vz43";
				};
				if (d_pracs) exitWith {
					_weapp = "PRACS_SLA_Ak74";
					_magp = "rhs_30Rnd_545x39_7N6_AK";
				};
				_weapp = "arifle_MX_F";
				_magp = "30Rnd_65x39_caseless_mag";
			};
			if (d_own_side == "GUER") exitWith {
				if (d_pracs) exitWith {
					_weapp = "PRACS_g3a3";
					_magp = "PRACS_20rd_G3_mag";
				};
				if (d_spe) exitWith {
					_weapp = "SPE_M1903A3_Springfield";
					_magp = "SPE_5Rnd_762x63";
				};
				_weapp = "arifle_MX_F";
				_magp = "30Rnd_65x39_caseless_mag";
			};
		};
		removeAllWeapons player;
		player addMagazines [_magp, 6];
		player addWeapon _weapp;
	};
	
	player addEventhandler ["Put", {call d_fnc_store_rwitems}];
};

player addEventhandler ["SeatSwitchedMan", {call d_fnc_seatswitchedman}];

call d_fnc_store_rwitems;

if (d_with_ranked || {d_database_found}) then {
	d_sm_p_pos = nil;
	if (!d_with_ace) then {
		player addEventHandler ["handleHeal", {call d_fnc_handleheal}];
	} else {
		["ace_treatmentSucceded", {call d_fnc_handleheal}] call CBA_fnc_addEventHandler;
		["ace_unconscious", {call d_fnc_handleunconscious}] call CBA_fnc_addEventHandler;
	};

	inGameUISetEventHandler ["Action", "_this call d_fnc_healatmash; false"];
};

// available in non ranked versions too, removes nvg if without nvg is activated to avoid cheating
player addEventhandler ["Take", {call d_fnc_ptakeweapon}];

if (d_MissionType != 2) then {
	if (d_resolved_targets isNotEqualTo []) then {
		private _codtn = count d_target_names;
		for "_i" from 0 to (count d_resolved_targets - 1) do {
			if (isNil "d_resolved_targets" || {_i >= count d_resolved_targets}) exitWith {};
#ifndef __TT__
			private _res = d_resolved_targets # _i;
#else
			(d_resolved_targets # _i) params ["_res"];
#endif
			if (!isNil "_res" && {_res >= 0 && {_res < _codtn}}) then {
				private _tgt_ar = d_target_names # _res;
				private _cur_tgt_name = _tgt_ar # 1;
				[true, format ["d_obj%1", _res + 2], [format [localize "STR_DOM_MISSIONSTRING_202", _cur_tgt_name], format [localize "STR_DOM_MISSIONSTRING_203", _cur_tgt_name], format [localize "STR_DOM_MISSIONSTRING_203", _cur_tgt_name]], _tgt_ar # 0, "Succeeded", 2, false, "Attack", false] call d_fnc_taskcreate;
			};
		};
	};

	d_current_seize = "";
	if (d_current_target_index != -1 && {!d_target_clear && {d_cur_tgt_pos isNotEqualTo []}}) then {
		d_current_seize = d_cur_tgt_name;
		"d_dummy_marker" setMarkerPosLocal d_cur_tgt_pos;
		private _tname = format ["d_obj%1", d_current_target_index + 2];
		[true, _tname, [format [localize "STR_DOM_MISSIONSTRING_202", d_current_seize], format [localize "STR_DOM_MISSIONSTRING_203", d_current_seize], format [localize "STR_DOM_MISSIONSTRING_203", d_current_seize]], d_cur_tgt_pos, true, 2, false, "Attack", false] call d_fnc_taskcreate;
		d_current_task = _tname;
		if (!isNil "d_obj00_task") then {
			d_obj00_task = nil;
			["d_obj00", "Succeeded", false] call d_fnc_taskSetState;
		};
#ifndef __TT__
		call d_fnc_cmakemtgmarker;
#endif
	};
};

if (d_ParaAtBase == 0) then {
#ifndef __TT__
	if (isNil {d_FLAG_BASE getVariable "d_jf_id"}) then {
		d_FLAG_BASE setVariable ["d_jf_id", d_FLAG_BASE addAction [format ["<t color='#D64C30' size='1.2'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0, 1.5, true, true, "", "true", 10]];
	};
#else
	private _base_flag = [d_EFLAG_BASE, d_WFLAG_BASE] select (d_player_side == blufor);
	if (isNil {_base_flag getVariable "d_jf_id"}) then {
		_base_flag setVariable ["d_jf_id", _base_flag addAction [format ["<t color='#D64C30' size='1.2'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0, 1.5, true, true, "", "true", 10]];
	};
#endif
};

#ifndef __TT__
if (d_MissionType != 2) then {
	{
		if (d_jumpflag_vec == "") then {
			_x setVariable ["d_jf_id", _x addAction [format ["<t color='#D64C30' size='1.2'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 1, 1.5, true, true, "", "true", 10]];
		} else {
			_x setVariable ["d_jf_id", _x addAction [format ["<t color='#AAD9EF'>%1</t>", format [localize "STR_DOM_MISSIONSTRING_297", [d_jumpflag_vec, "CfgVehicles"] call d_fnc_GetDisplayName]], {_this spawn d_fnc_bike},[d_jumpflag_vec,1], 1.5, true, true, "", "true", 10]];
		};
	} forEach ((allMissionObjects d_flag_pole) select {!isNil {_x getVariable "d_is_jf"} && {isNil {_x getVariable "d_jf_id"}}});
};
#endif

if (d_all_sm_res) then {d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_522"} else {[false] spawn d_fnc_getsidemissionclient};

#ifndef __TT__
player addEventHandler ["Killed", {call d_fnc_pkilledeh}];
#else
if (d_player_side == blufor) then {
	player addEventHandler ["Killed", {[_this, 0] call d_fnc_pkilledeh}];
} else {
	player addEventHandler ["Killed", {[_this, 1] call d_fnc_pkilledeh}];
};
#endif
player addEventHandler ["respawn", {call d_fnc_prespawned}];

player setVariable ["d_currentvisionmode", 0];

// one entry: [box_object, color as array (R, G, B, Alpha), "Text to show above box"]
d_all_p_a_boxes = [];

if (d_ammo_boxes isNotEqualTo []) then {
	{
		private _boxnew = _x # 1;
		_boxnew enableRopeAttach false;
#ifndef __TT__
		[_boxnew] call d_fnc_weaponcargo;
#else
		[_boxnew, _x # 3] call d_fnc_weaponcargo;
		if (d_player_side != _x # 3) then {
			deleteMarkerLocal (_x # 2);
		};
#endif
	} forEach (d_ammo_boxes select {_x isEqualType []});
};

player setVariable ["d_isinaction", false];

#ifndef __TT__
d_all_ammoloads = (allMissionObjects "HeliH") select {(str _x) select [0, 10] == "d_AMMOLOAD"};
#else
d_all_ammoloads = (allMissionObjects "HeliH") select {(str _x) select [0, 10] == "d_AMMOLOAD" && {_x distance2D d_FLAG_BASE < 1500 || {_x getVariable ["d_side", sideEnemy] == d_player_side}}};
#endif

d_points_needed_15 = (d_points_needed # 6) + 15000;
d_points_needed_16 = (d_points_needed # 6) + 30000;
d_points_needed_17 = (d_points_needed # 6) + 80000;
d_points_needed_18 = (d_points_needed # 6) + 200000;

0 spawn {
	scriptName "spawn_setupplayer1";
	while {true} do {
		sleep 0.3;
		if (!d_still_in_intro) exitWith {};
	};
	d_d3d_locs4a = localize "STR_DOM_MISSIONSTRING_1718";
#ifndef __TT__
	[d_FLAG_BASE, localize "STR_DOM_MISSIONSTRING_1644", 2.5, 0, 0] call d_fnc_addto3drawar;
	if (d_dis_servicep == 1) then {
		if (!isNil "d_vecre_trigger") then {
			private _text_f = if (!d_spe && {!d_ifa3}) then {
				localize "STR_DOM_MISSIONSTRING_4"
			} else {
				localize "STR_DOM_MISSIONSTRING_524_44"
			};
			[d_vecre_trigger, _text_f, 5, 1, 0] call d_fnc_addto3drawar;
		};
		if (!isNil "d_jet_trigger") then {
			[d_jet_trigger, localize "STR_DOM_MISSIONSTRING_526", 5, 1, 0] call d_fnc_addto3drawar;
		};
		if (!d_ifa3 && {!d_spe && {!isNil "d_chopper_trigger"}}) then {
			[d_chopper_trigger, localize "STR_DOM_MISSIONSTRING_528", 5, 1, 0] call d_fnc_addto3drawar;
		};
		private _allmhs = allMissionObjects "HeliH";
		{
			[_x, localize "STR_DOM_MISSIONSTRING_0", 5, 1, 1] call d_fnc_addto3drawar;
		} forEach (_allmhs select {(str _x) select [0, 11] == "d_wreck_rep"});
		{
			[_x, localize "STR_DOM_MISSIONSTRING_1761", 5, 1, 0] call d_fnc_addto3drawar;
		} forEach (_allmhs select {(str _x) select [0, 20] == "d_serviceall_trigger"});
	};
	if (d_carrier) then {
		[d_flag_airfield, localize "STR_DOM_MISSIONSTRING_1760", 5, 0, 0] call d_fnc_addto3drawar;
	};
	if (d_with_ai) then {
		d_d3d_locsaire = localize "STR_DOM_MISSIONSTRING_314";
		d_allai_recruit_objs = [d_AI_HUT] + d_additional_recruit_buildings;
		private _sign = d_AI_HUT getVariable "d_ai_sign";
		if (!isNil "_sign") then {
			d_allai_recruit_objs pushBack _sign;
		};
	};
#else
	[[d_EFLAG_BASE, d_WFLAG_BASE] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_1644", 2.5, 0, 0] call d_fnc_addto3drawar;

	if (d_dis_servicep == 1) then {
		if (!isNil "d_vecre_trigger") then {
			[[d_vecre_trigger2, d_vecre_trigger] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_524", 5, 1, 0] call d_fnc_addto3drawar;
		};
		if (!isNil "d_jet_trigger") then {
			[[d_jet_trigger2, d_jet_trigger] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_526", 5, 1, 0] call d_fnc_addto3drawar;
		};
		if (!isNil "d_chopper_trigger") then {
			[[d_chopper_triggerR, d_chopper_trigger] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_528", 5, 1, 0] call d_fnc_addto3drawar;
		};
		if (!isNil "d_wreck_rep") then {
			[[d_wreck_rep2, d_wreck_rep] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_0", 5, 1, 1] call d_fnc_addto3drawar;
		};
	};
#endif
	{
		[_x, localize "STR_DOM_MISSIONSTRING_531", 5, 2, 0] call d_fnc_addto3drawar;
	} forEach d_all_ammoloads;
	
	d_dr3dca_hash = createHashMap;
	
	for "_i" from 0 to 24 do {
		d_dr3dca_hash set [_i, format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", _i]];
	};

	addMissionEventHandler ["Draw3D", {call d_fnc_draw3dstuff}];

	if (!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}) then {
		"d_fpsresource" cutRsc ["d_fpsresource", "PLAIN"];
		if (d_player_can_call_arti > 0 || {d_player_can_call_drop > 0 || {d_string_player in d_can_call_cas || {!d_no_ai}}}) then {
			"d_RscSupportL" cutRsc ["d_RscSupportL", "PLAIN"];
		};
	};

	xr_phd_invulnerable = false;
	sleep 2;
	player setVariable ["d_player_old_rank", 0, true];
	if (d_database_found && {!isNil "d_points_needed_db" && {d_set_pl_score_db}}) then {
		d_points_needed = d_points_needed_db;
	};
	["dom_plrank_tr", {
		call d_fnc_PlayerRank;
	}, 5.12] call d_fnc_eachframeadd;
};

diag_log "Internal D Version: 4.70";

if (!d_no_ai) then {
	if (d_with_ai) then {
		if (isNil "d_AI_HUT") then {
			0 spawn {
				scriptName "spawn_wait_for_ai_hut";
				while {true} do {
					sleep 0.512;
					if (!isNil "d_AI_HUT") exitWith {};
				};
				call d_fnc_recruitsetup;
			};
		} else {
			call d_fnc_recruitsetup;
		};

		private _leader = leader (group player);
		if (!(_leader call d_fnc_isplayer) || {player == _leader}) then {
			{
				if (isNull objectParent _x) then {
					deleteVehicle _x;
				} else {
					(vehicle _x) deleteVehicleCrew _x;
				};
			} forEach ((units player) select {!(_x call d_fnc_isplayer)});
		};
	};

	if (d_disable_player_arty == 0) then {
		d_player_can_call_arti = 1;
	};
	if (d_with_airdrop == 0) then {
		d_player_can_call_drop = 1;
	};
	d_player_can_call_cas = 1;
	player setUnitTrait ["Medic", true];
	player setUnitTrait ["engineer", true];
} else {
	if (d_disable_player_arty == 0 && {d_string_player in d_can_use_artillery}) then {
		d_player_can_call_arti = 1;
	} else {
		enableEngineArtillery false;
	};
	if (d_with_airdrop == 0 && {d_string_player in d_can_call_drop_ar}) then {
		d_player_can_call_drop = 1;
	};
	if (d_string_player in d_can_call_cas) then {
		d_player_can_call_cas = 1;
	};
};

//Set ace medic and engineer traits
if(d_with_ace) then	{
	if(player getUnitTrait "Medic") then {
		player setVariable ["ace_medical_medicClass", 1, true];
	};
	
	if(player getUnitTrait "Engineer") then {
		player setVariable ["ace_isEngineer", 1, true];
	};
};

player setUnitTrait ["explosiveSpecialist", true];
player setUnitTrait ["UAVHacker", true];

private _respawn_marker = "";
private _base_spawn_m = "base_spawn_1";
call {
	if (d_own_side == "GUER") exitWith {
		_respawn_marker = "respawn_guerrila";
		deleteMarkerLocal "respawn_west";
		deleteMarkerLocal "respawn_east";
	};
	if (d_own_side == "WEST") exitWith {
		_respawn_marker = "respawn_west";
		deleteMarkerLocal "respawn_guerrila";
		deleteMarkerLocal "respawn_east";
	};
	if (d_own_side == "EAST") exitWith {
		_respawn_marker = "respawn_east";
		deleteMarkerLocal "respawn_west";
		deleteMarkerLocal "respawn_guerrila";
#ifdef __TT__
		_base_spawn_m = "base_spawn_2";
		"base_spawn_1" setMarkerPosLocal markerPos _base_spawn_m;
#endif
	};
};

_respawn_marker setMarkerPosLocal markerPos _base_spawn_m;
#ifdef __IFA3__
"respawn_guerrila" setMarkerPosLocal markerPos _base_spawn_m;
#endif

// special triggers for engineers, AI version, everybody can repair and flip vehicles
if (d_string_player in d_is_engineer || {!d_no_ai}) then {
	d_eng_can_repfuel = true;

	if (d_engineerfull == 0 || {!d_no_ai}) then {
#ifndef __TT__
		private _engineer_trigger = createTrigger ["EmptyDetector" ,d_base_array # 0, false];
		_engineer_trigger setTriggerArea [d_base_array # 1, d_base_array # 2, d_base_array # 3, true, 2];
#else
		private _mbase = if (d_player_side == blufor) then {d_base_array # 0} else {d_base_array # 1};
		private _engineer_trigger = createTrigger ["EmptyDetector" ,_mbase # 0, false];
		_engineer_trigger setTriggerArea [_mbase # 1, _mbase # 2, _mbase # 3, true, 2];
#endif
		_engineer_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_engineer_trigger setTriggerStatements["!d_eng_can_repfuel && {alive player && {!(player getVariable ['xr_pluncon', false]) && {player in thislist}}}", "d_eng_can_repfuel = true; systemChat (localize 'STR_DOM_MISSIONSTRING_340')", ""];
	};

	if (d_with_ranked || {d_database_found}) then {d_last_base_repair = -1};

	["dom_eng_1_trig", {
		call d_fnc_engtrig1fnc;
	}, 0.51] call d_fnc_eachframeadd;

	if (d_engineerfull == 0 || {!d_no_ai}) then {
		player setVariable ["d_has_sfunc_aid", false];
		d_actionID2 = -9999;
		d_orig_sfunc_obj = objNull;
		["dom_eng_2_trig", {
			call d_fnc_engtrigfnc;
		}, 0.56] call d_fnc_eachframeadd;
	};

	player setVariable ["d_farp_pos", []];

	if (d_engineerfull == 0 || {!d_no_ai}) then {
		{_x addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_513"], {call d_fnc_restoreeng}, -1, 1.5, true, true, "", "true", 10]} forEach d_farps;
	};
};

{
	_x addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_286a"], {call d_fnc_healatmash}, 0, -1, false, false, "", "damage player > 0 && {d_player_canu && {!(player getVariable 'd_isinaction')}}", 10];
} forEach d_mashes;

if (d_dis_servicep == 1) then {
	{
		private _farpc = _x getVariable ["d_objcont", []];
		if (_farpc isNotEqualTo []) then {
			_farpc params ["_trig"];
			_trig setTriggerActivation ["ANY", "PRESENT", true];
			_trig setTriggerStatements ["[thislist, thisTrigger] call d_fnc_tallservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""];
			_trig setTriggerInterval 1;
		};
	} forEach d_farps;
};

#ifndef __TT__
// Enemy at base
"d_enemy_base" setMarkerPosLocal (d_base_array # 0);
"d_enemy_base" setMarkerDirLocal (d_base_array # 3);
[d_base_array # 0, [d_base_array # 1, d_base_array # 2, d_base_array # 3, true, 2], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || {'Tank' countType thislist > 0 || {'Car' countType thislist > 0}}", "[0] call d_fnc_BaseEnemies;'d_enemy_base' setMarkerSizeLocal [d_base_array select 1,d_base_array select 2];d_there_are_enemies_atbase = true", "[1] call d_fnc_BaseEnemies;'d_enemy_base' setMarkerSizeLocal [0,0];d_there_are_enemies_atbase = false"]] call d_fnc_createtriggerlocal;
[d_base_array # 0, [(d_base_array # 1) + 300, (d_base_array # 2) + 300, d_base_array # 3, true, 2], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || {'Tank' countType thislist > 0 || {'Car' countType thislist > 0}}", "if (!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {d_force_isstreamfriendlyui != 1 && {!isStreamFriendlyUIEnabled}}}) then {hint (localize 'STR_DOM_MISSIONSTRING_1409')};d_enemies_near_base = true", "d_enemies_near_base = false"]] call d_fnc_createtriggerlocal;


[d_base_array # 0, [d_base_array # 1, d_base_array # 2, d_base_array # 3, true], ["ANYPLAYER", "PRESENT", true], ["(vehicle player) in thislist", "d_player_in_base = true", "d_player_in_base = false"]] call d_fnc_createtriggerlocal;
#else
if (d_player_side ==  blufor) then {
	[d_base_array # 0 # 0, [d_base_array # 0 # 1, d_base_array # 0 # 2, d_base_array # 0 # 3, true], ["ANYPLAYER", "PRESENT", true], ["(vehicle player) in thislist", "d_player_in_base = true", "d_player_in_base = false"]] call d_fnc_createtriggerlocal;
} else {
	[d_base_array # 1 # 0, [d_base_array # 1 # 1, d_base_array # 1 # 2, d_base_array # 1 # 3, true], ["ANYPLAYER", "PRESENT", true], ["(vehicle player) in thislist", "d_player_in_base = true", "d_player_in_base = false"]] call d_fnc_createtriggerlocal;
};
#endif

if (player getUnitTrait "Medic") then {
	player setVariable ["d_medtent", []];
};

d_x_loop_end = false;
if (d_WithMHQTeleport == 0) then {
#ifndef __TT__
	d_FLAG_BASE addAction [format ["<t color='#FF0000' size='1.5'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {call d_fnc_teleportx}, -1, 1.5, true, true, "", "true", 10];
#else
	private _base_flag = [d_EFLAG_BASE, d_WFLAG_BASE] select (d_player_side == blufor);
	_base_flag addAction [format ["<t color='#FF0000' size='1.5'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {call d_fnc_teleportx}, -1, 1.5, true, true, "", "true", 10];
#endif
};

#ifndef __TT__
if (d_playerspectateatbase == 0) then {
	d_FLAG_BASE addaction [format ["<t color='#3F3F3F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1745"], {call d_fnc_playerspectate}, -1, 1.5, true, true, "", "true", 10];
};
#endif

if (d_with_bis_dynamicgroups == 0) then {
	d_FLAG_BASE addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_552"], {call d_fnc_showdynamicgroupsdialog}, _d_vec, -1, false, true, "", "true", 7];
};

d_FLAG_BASE addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_304"], {0 call d_fnc_DomCommandingMenuExec}, _d_vec, -1, false, true, "", "true", 7];


if (d_ParaAtBase == 1) then {
	"d_Teleporter" setMarkerTextLocal (localize "STR_DOM_MISSIONSTRING_534");
#ifdef __TT__
	"d_teleporter_1" setMarkerTextLocal (localize "STR_DOM_MISSIONSTRING_534");
#endif
};

//if (!d_with_ace) then {
	0 spawn {
		scriptName "spawn_setupplayer2";
		// 0 = over head, 1 = cursor target
		d_show_pname_hud = d_playernames_state > 0 && {d_show_playernames == 0};

		d_show_player_namesx = d_playernames_state;

		d_dist_pname_hud = 300;

		sleep 10;

		while {true} do {
			sleep 0.232;
			if (!d_still_in_intro) exitWith {};
		};

		d_phudraw3d = -1;

		d_pnhuddo2_prevCT = objNull;
		d_showPlayerNameRSC_shown = false;
		d_pnhuddo2_frskip = 0;

		if (!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}) then {
			if (d_show_pname_hud) then {
				d_pl_name_huddo_ar = [];
				["dom_fillname_huddo", {call d_fnc_fillname_huddo}] call d_fnc_eachframeadd;
				d_phudraw3d = addMissionEventHandler ["Draw3D", {call d_fnc_player_name_huddo}];
			} else {
				["dom_player_hud2", {call d_fnc_player_name_huddo2}] call d_fnc_eachframeadd;
			};
		};
	};
//};

private _primw = primaryWeapon player;
if (_primw != "") then {
	player selectWeapon _primw;
};

if (d_MissionType != 2) then {
	if (d_currentcamps isNotEqualTo []) then {
		call d_fnc_curcampsclient;
	};

	if (!isNil "d_searchbody" && {!isNull d_searchbody && {isNil {d_searchbody getVariable "d_search_id"}}}) then {
		call d_fnc_s_b_client;
	};
};

player setVariable ["d_p_f_b", 0];
if (isNil "d_p_rounds") then {
	d_p_rounds = 0;
};

player addEventHandler ["firedMan", {call d_fnc_playerfiredeh}];

d_mark_loc280 = localize "STR_DOM_MISSIONSTRING_280";
d_mark_loc261 = localize "STR_DOM_MISSIONSTRING_261";
d_mark_loc1825 = localize "STR_DOM_MISSIONSTRING_1825";

d_map_ameh = addMissionEventHandler ["Map", {
	if (_this # 0) then {
		findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {[_this, 0] call d_fnc_mapondraw}];
	};
	removeMissionEventHandler ["Map", d_map_ameh];
	d_map_ameh = nil;
}];

0 spawn d_fnc_waitforgps;
0 spawn d_fnc_waitartycompmap;
0 spawn d_fnc_waitforuavmap;

if (isNil "d_the_carrier") then {
	d_the_carrier = [0,0,0];
};

{
	[objNull, _x] call d_fnc_ccreateboxfarp;
#ifndef __TT__
} forEach d_player_ammoboxes;
#else
} forEach (d_player_ammoboxes select ([0, 1] select (d_player_side == opfor)));
#endif

private _dsp46 = findDisplay 46;

_dsp46 displayAddEventHandler ["MouseZChanged", {call d_fnc_MouseWheelRec}];

if (d_WithRevive == 0) then {
	call compileScript ["revive.sqf", false];
};

0 spawn d_fnc_dcmcc;

if (d_with_bis_dynamicgroups == 0) then {
	["InitializePlayer", [player]] call d_fnc_dynamicGroups;
	0 spawn {
		scriptName "spawn_setupplayer3";
		waitUntil {!isNil {missionNamespace getVariable "BIS_dynamicGroups_key"}};
		(findDisplay 46) displayAddEventHandler ["KeyDown", {call d_fnc_keydown_dyng}];
		(findDisplay 46) displayAddEventHandler ["KeyUp", {call d_fnc_keyup_dyng}];
	};
} else {
	_dsp46 displayAddEventHandler ["KeyDown", {call d_fnc_keydown_dyng}];
	_dsp46 displayAddEventHandler ["KeyUp", {call d_fnc_keyup_dyng}];
};

_dsp46 displayAddEventHandler ["KeyDown", {call d_fnc_earplugs}];
#ifndef __TT__
if (!d_with_ace) then {
	_dsp46 displayAddEventHandler ["KeyDown", {call d_fnc_toggle3dm}];
} else {
	d_showallnearusermarkers = false;
};
#endif

// by R34P3R
d_p_isju = false;
if (!d_with_ace) then {
	_dsp46 displayAddEventHandler ["KeyDown", {call d_fnc_jumpover}];
};

d_vec_role_pl = [];
player addEventhandler ["getInMan", {call d_fnc_getinmaneh}];
player addEventhandler ["getOutMan", {call d_fnc_getoutmaneh}];

player addEventhandler ["SeatSwitchedMan", {call d_fnc_seatswitchedmanvs}];

d_pisadminp = false;
if (d_AutoKickTime == 0 || {d_with_ranked || {d_MissionType == 2}}) then {
	d_clientScriptsAr set [1, true];
};

0 spawn d_fnc_startClientScripts;

#ifdef __TT__
if (d_player_side == blufor) then {
#endif
if (markerPos "d_runwaymarker" isNotEqualTo [0,0,0]) then {
	private _msize = markerSize "d_runwaymarker";
	[[markerPos "d_runwaymarker" # 0, markerPos "d_runwaymarker" # 1, 1.9], [_msize # 0, _msize # 1, markerDir "d_runwaymarker", true, 2], ["ANY", "PRESENT", true], ["(thislist unitsBelowHeight 1) isNotEqualTo []", "'d_runwaymarker' setMarkerColorLocal 'ColorRed'", "'d_runwaymarker' setMarkerColorLocal 'ColorGreen'"]] call d_fnc_createtriggerlocal;
};
#ifdef __TT__
};
if (d_player_side == opfor && {markerPos "d_runwaymarker_o" isNotEqualTo [0,0,0]}) then {
	private _msize = markerSize "d_runwaymarker_o";
	[[markerPos "d_runwaymarker_o" # 0, markerPos "d_runwaymarker_o" # 1, 1.9], [_msize # 0, _msize # 1, markerDir "d_runwaymarker_o", true, 2], ["ANY", "PRESENT", true], ["(thislist unitsBelowHeight 1) isNotEqualTo []", "'d_runwaymarker_o' setMarkerColorLocal 'ColorRed'", "'d_runwaymarker_o' setMarkerColorLocal 'ColorGreen'"]] call d_fnc_createtriggerlocal;
};
#endif

player call d_fnc_removenvgoggles_fak;
#ifndef __IFA3__
if (d_without_nvg == 1 && {!d_gmcwg && {!d_unsung && {!d_vn && {!d_spe && {!(player call d_fnc_hasnvgoggles)}}}}}) then {
	if (!d_csla) then {
		player linkItem (switch (d_player_side) do {
			case opfor: {"NVGoggles_OPFOR"};
			case independent: {"NVGoggles_INDEP"};
			default {"NVGoggles"};
		});
	} else {
		player linkItem "CSLA_nokto";
	};
};
private _bino = binocular player;
call {
	if (d_gmcwg) exitWith {
		if (_bino == "") then {
			player addWeapon "gm_ferod16_oli";
		};
	};
	if (d_unsung) exitWith {
		if (_bino == "") then {
			player addWeapon "uns_binocular_army";
		};
	};
	if (d_vn) exitWith {
		if (_bino == "") then {
			player addWeapon "vn_mk21_binocs";
		};
	};
	if (d_csla) exitWith {
		if (_bino == "") then {
			player addWeapon "CSLA_bino";
		};
	};
	if (d_spe) exitWith {
		if (_bino == "") then {
			if (d_player_side == west) then {
				player addWeapon "SPE_Binocular_GER";
			} else {
				player addWeapon "SPE_Binocular_US";
			};
		};
		if !("ItemRadio" in assigneditems player) then {player linkItem "ItemRadio"};
	};
	if ((d_disable_player_arty == 0 && {d_string_player in d_can_use_artillery || {d_string_player in d_can_mark_artillery}}) || {d_string_player in d_can_call_cas}) then {
		if (!d_with_ranked && {_bino != "LaserDesignator"}) then {
			if (_bino != "") then {
				player removeWeapon _bino;
			};
			player addWeapon "LaserDesignator";
		};
		if !("Laserbatteries" in magazines player) then {
			player addMagazine ["Laserbatteries", 1];
		};
	} else {
		if (_bino == "") then {
			player addWeapon "Binocular";
		};
	};
	if !("ItemGPS" in (assignedItems player)) then {
		player linkItem "ItemGPS";
	};
};
#else
if !("ItemRadio" in assigneditems player) then {player linkItem "ItemRadio"};
#endif

private _unip = uniform player;
if (_unip != "") then {
	if (getText (configFile>>"CfgWeapons">>_unip>>"ItemInfo">>"containerClass") == "Supply500") then {
		removeUniform player;
	};
};

call d_fnc_save_respawngear;
call d_fnc_save_layoutgear;

0 spawn d_fnc_clean_craters;

private _vehicles = vehicles select {!(_x isKindOf "WeaponHolderSimulated")};

private _fnc_artvec = {
	params ["_num", "_name"];
	private _ar = _vehicles select {(str _x) select [0, _num] == _name};
	if (_ar isNotEqualTo []) then {
		d_areArtyVecsAvailable = true;
		d_ao_arty_vecs append _ar;
	};
};
#ifndef __TT__
[10, "d_artyvec_"] call _fnc_artvec;
#else
[11, ["d_artyvecb_", "d_artyveco_"] select (d_player_side == opfor)] call _fnc_artvec;
#endif

if (d_disable_player_arty == 0) then {
	if (!d_no_ai || {d_string_player in d_can_use_artillery || {d_string_player in d_can_mark_artillery}}) then {
		if (!d_ifa3 && {!d_gmcwg && {!d_unsung && {!d_csla && {!d_vn && {!d_spe}}}}}) then {
			player setVariable ["d_ld_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1520"], {call d_fnc_mark_artillery} , 0, 9, true, false, "", "d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}"]];
		} else {
			player setVariable ["d_ld_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1520"], {call d_fnc_mark_artillery} , 0, 9, true, false, "", "d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}"]];
		};
	};
};

if (isNil "d_cas_plane_avail" && {d_disable_player_cas == 0}) then {
	if (!d_no_ai || {d_string_player in d_can_call_cas}) then {
#ifndef __TT__
		if (!d_ifa3 && {!d_gmcwg && {!d_unsung && {!d_csla && {!d_vn && {!d_spe}}}}}) then {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea d_base_array) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
			if (d_enable_extra_cas == 1) then {
				player setVariable ["d_ccas_action_bomb", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711_CAS_BOMB_POS"], {call d_fnc_call_cas_bomb} , 0, 9, true, false, "", "d_cas_available && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea d_base_array) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
			};
		} else {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!(screenToWorld [0.5, 0.5] inArea d_base_array) && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}}}"]];
			if (d_enable_extra_cas == 1) then {
				if (d_vn) then {
					player setVariable ["d_ccas_action_bomb_napalm", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711_CAS_BOMB_POS_NAPALM"], {call d_fnc_call_cas_bomb_napalm} , 0, 9, true, false, "", "d_cas_available && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!(screenToWorld [0.5, 0.5] inArea d_base_array) && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}}}"]];
				} else {
					player setVariable ["d_ccas_action_bomb", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711_CAS_BOMB_POS"], {call d_fnc_call_cas_bomb} , 0, 9, true, false, "", "d_cas_available && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!(screenToWorld [0.5, 0.5] inArea d_base_array) && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}}}"]];
				};
			};
		};
#else
		if (d_player_side == blufor) then {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available_w && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea (d_base_array select 0)) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
			if (d_enable_extra_cas == 1) then {
				player setVariable ["d_ccas_action_bomb", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711_CAS_BOMB_POS"], {call d_fnc_call_cas_bomb} , 0, 9, true, false, "", "d_cas_available_w && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea (d_base_array select 0)) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
			};
		} else {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available_e && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea (d_base_array select 1)) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
			if (d_enable_extra_cas == 1) then {
				player setVariable ["d_ccas_action_bomb", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711_CAS_BOMB_POS"], {call d_fnc_call_cas_bomb} , 0, 9, true, false, "", "d_cas_available_e && {d_player_canu && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea (d_base_array select 1)) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
			};
		};
#endif
	};
};

player addEventhandler["InventoryOpened", {call d_fnc_inventoryopened}];
player addEventhandler["InventoryClosed", {call d_fnc_inventoryclosed}];

if (!d_with_ranked) then {
	if (d_with_ace && {d_arsenal_mod == 1}) then {
		["ace_arsenal_displayOpened", {
			call d_fnc_arsenalopened;
		}] call CBA_fnc_addEventHandler;

		["ace_arsenal_displayClosed", {
			call d_fnc_arsenalclosed;
		}] call CBA_fnc_addEventHandler;
	} else {
		[missionNamespace, "arsenalOpened", {
			call d_fnc_arsenalopened;
		}] call BIS_fnc_addScriptedEventHandler;

		[missionNamespace, "arsenalClosed", {
			call d_fnc_arsenalclosed;
		}] call BIS_fnc_addScriptedEventHandler;
	};
} else {
	[missionNamespace, "arsenalOpened", {
		call d_fnc_arsenalopened;
	}] call BIS_fnc_addScriptedEventHandler;

	[missionNamespace, "arsenalClosed", {
		call d_fnc_arsenalclosed;
	}] call BIS_fnc_addScriptedEventHandler;
};

player addEventhandler ["HandleRating", {
	if ((_this # 1) < 0) then {0} else {_this # 1}
}];

["d_scacheck", {call d_fnc_SCACheck}, 0.2] call d_fnc_eachframeadd;

if (d_enablefatigue == 0) then {
	player setFatigue 0;
	player enableFatigue false;
};

if (d_enablesway == 0) then {
	player setCustomAimCoef 0.1;
};

d_inventory_blocked = false;

player setVariable ["xr_isleader", false];
0 spawn {
	scriptName "spawn_setupplayer6";
	sleep 10;
	private _islead = leader (group player) == player;
	player setVariable ["xr_isleader", _islead];
	if (_islead) then {
		{
			[_x, false] remoteExecCall ["d_fnc_setleader", _x];
		} forEach ((units player) - [player]);
	};
};

player addEventhandler ["WeaponAssembled", {
	["aw", d_player_uid, _this # 1] remoteExecCall ["d_fnc_p_o_ar", 2];
}];

{
	_x call d_fnc_initvec;
	if (d_pylon_lodout == 0 && {unitIsUAV _x && {isClass ((configOf _x)>>"Components">>"TransportPylonsComponent")}}) then {
		_x call d_fnc_addpylon_action;
	};
	if (_x isKindOf "Boat_F") then {
		_x call d_fnc_addpushaction;
	};
} forEach _vehicles;

["Preload"] call bis_fnc_arsenal;

//if (d_with_ace) then {
//	d_ace_arsenal_ar_save =+ (uiNamespace getVariable ["ace_arsenal_configItems", []]);
//};

bis_fnc_arsenal_data set [16, []];

if (isClass (configFile>>"CfgPatches">>"acre_main")) then {
	(bis_fnc_arsenal_data # 24) append (["ACRE_VHF30108","ACRE_VHF30108SPIKE","ACRE_VHF30108MAST","ACRE_SEM52SL","ACRE_SEM70","ACRE_PRC117F","ACRE_PRC148","ACRE_PRC152","ACRE_PRC343","ACRE_PRC77"] apply {toLowerANSI _x});
};

if (d_arsenal_mod_remove_strings isNotEqualTo []) then {
	d_arsenal_mod_remove_strings call d_fnc_arsenal_mod_rem;

	d_arsenal_mod_remove_strings = nil;
};

if (d_arsenal_mod == 0) then {
	if (d_ifa3) then {
		d_arsenal_mod_prestrings pushBackUnique "WW2_";
	};
	if (d_cup) then {
		d_arsenal_mod_prestrings pushBackUnique "CUP_";
	};
	if (d_rhs) then {
		d_arsenal_mod_prestrings append ["rhs_", "rhsgref_", "rhsusf_", "rhssaf_"];
	};
	if (d_gmcwg) then {
		d_arsenal_mod_prestrings pushBackUnique "gm_";
	};
	if (d_unsung) then {
		d_arsenal_mod_prestrings pushBackUnique "uns_";
	};
	if (d_vn) then {
		d_arsenal_mod_prestrings append ["weapons_f_vietnam_c", "characters_f_vietnam_c", "weapons_f_vietnam_02_c", "characters_f_vietnam_02_c","weapons_f_vietnam_03_c","characters_f_vietnam_03_c","weapons_f_vietnam_04_c","characters_f_vietnam_04_c"];
	};
	if (d_csla) then {
		d_arsenal_mod_prestrings append ["CSLA_", "US85_"];
	};
	if (d_pracs) then {
		d_arsenal_mod_prestrings append ["PRACS_", "rhs_", "rhsgref_", "rhsusf_", "rhssaf_"];
	};
	if (d_spe) then {
		d_arsenal_mod_prestrings append ["WW2_SPE_Assets_c_Weapons_InfantryWeapons_c", "WW2_SPE_Assets_c_Characters_Headgear_c", "WW2_SPE_Assets_c_Characters_Frenchs_c_FR_Late_Gear", "WW2_SPE_Assets_c_Characters_Civilians_c_French_Gear", "WW2_SPE_Assets_c_Characters_Americans_c_US_Rangers_Gear", "WW2_SPE_Assets_c_Characters_Americans_c_US_Army_Gear", "WW2_SPE_Assets_c_Characters_Americans_c_US_Airforce_Gear", "WW2_SPE_Assets_c_Characters_Germans_c_GER_Wehrmacht_Gear", "WW2_SPE_Assets_c_Characters_Germans_c_GER_TankTroops_Gear", "WW2_SPE_Assets_c_Characters_Germans_c_GER_Sturmtroopers_Gear", "ww2_spe_assets_c_weapons_misc_c_taskforceradioitems_compatibility", "WW2_SPE_Assets_c_Characters_Frenchs_c_FR_FFI_Gear","WW2_SPE_Assets_c_Weapons_Recoil_c", "WW2_SPE_Assets_c_Weapons_Sounds_c", "WW2_SPE_Assets_c_Weapons_Backpacks_c", "WW2_SPE_Assets_c_Weapons_Mines_c", "WW2_SPE_Assets_c_Vehicles_Weapons_c"];
	};
	if (d_with_ace && {d_arsenal_mod_prestrings isNotEqualTo []}) then {
		d_arsenal_mod_prestrings pushBackUnique "ace_";
	};
	if (d_arsenal_mod_prestrings isNotEqualTo []) then {
		if (isClass (configFile>>"CfgPatches">>"acre_main")) then {
			d_arsenal_mod_prestrings pushBackUnique "ACRE_";
		};
		if (isClass (configFile>>"CfgPatches">>"task_force_radio")) then {
			d_arsenal_mod_prestrings pushBackUnique "task_";
			d_arsenal_mod_prestrings pushBackUnique "tf_";
			d_arsenal_mod_prestrings pushBackUnique "tfar_";
		};
		d_arsenal_mod_prestrings call d_fnc_arsenal_mod;
	};
	d_arsenal_mod_prestrings = nil;
};

for "_i" from 0 to (count d_remove_from_arsenal - 1) do {
	private _proceed = true;
	if (d_with_ranked && {!d_no_ranked_weapons && {!(_i in [5, 22, 23, 26])}}) then {
		_proceed = false;
	};
	if (_proceed && {(d_remove_from_arsenal # _i) isNotEqualTo [] && {(bis_fnc_arsenal_data # _i) isNotEqualTo []}}) then {
		private _badar = bis_fnc_arsenal_data # _i;
		private _codes = [];
		private _classes = [];
		{
			if (_x isEqualType "") then {
				_classes pushBackUnique _x;
			} else {
				_codes pushBack _x;
			};
		} forEach (d_remove_from_arsenal # _i);

		if (_classes isNotEqualTo []) then {
			_classes = _classes apply {toLowerANSI _x};
		};

		__TRACE_2("","_i","_codes")
		__TRACE_2("","_i","_classes")

		__TRACE_2("1","count _badar","_badar")

		private ["_changed"];
		{
			_changed = false;
			if (_codes isNotEqualTo []) then {
				private _curnum = _forEachIndex;
				private _curele = toLowerANSI _x;
				{
					if (_curele call _x) then {
						__TRACE_1("removed","_curele")
						_badar set [_curnum, -1];
						_changed = true;
					};
				} forEach _codes;
			};
			if (!_changed && {_classes isNotEqualTo [] && {toLowerANSI _x in _classes}}) then {
				__TRACE("in second")
				_badar set [_forEachIndex, -1];
			};
		} forEach _badar;
		_badar = _badar - [-1];
		__TRACE_2("2","count _badar","_badar")
		bis_fnc_arsenal_data set [_i, _badar];
	};
};

#ifdef __UNSUNG__
bis_fnc_arsenal_data set [8, []];
private _har = bis_fnc_arsenal_data # 9;
_har = _har - ["Rangefinder"];
bis_fnc_arsenal_data set [9, _har];
#endif

{
	if (_x isNotEqualTo []) then {
		(bis_fnc_arsenal_data # _forEachIndex) append _x;
	};
} forEach d_add_to_arsenal;

if (d_with_ranked && {!d_no_ranked_weapons}) then {
	call d_fnc_build_ranked_gear;
	
	0 spawn d_fnc_weaponcargo_ranked;
};

missionNamespace setVariable ["BIS_dynamicGroups_allowInterface", false];

0 spawn d_fnc_allplayers;

if (d_with_ace && {d_ACEMedicalR == 1}) then {
	addMissionEventHandler ["Draw3D", {call d_fnc_draw3d_ace}];
};

d_last_placed_zeus_obj = objNull;
{
	_x addEventhandler ["CuratorObjectPlaced", {
		call d_fnc_place;
#ifndef __TT__
		addToRemainsCollector [_this # 1];
		private _grp = group (_this # 1);
		if (!isNull _grp) then {
			if (!isGroupDeletedWhenEmpty _grp) then {
				_grp deleteGroupWhenEmpty true;
			};
		};
#endif
		_this # 1
	}];
} forEach allCurators;

if (!d_with_ace && {d_with_suppress == 0}) then {
	d_impactCC = ppEffectCreate ["colorCorrections", 1500];
	d_impactCC ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [1, 1, 1, 0]];
	d_impactCC ppEffectEnable true;
	d_impactCC ppEffectCommit 0;

	d_impactBlur = ppEffectCreate ["RadialBlur", 1010];
	d_impactBlur ppEffectAdjust [0, 0, 0, 0];
	d_impactBlur ppEffectCommit 0;
	d_impactBlur ppEffectEnable true;
	
	d_lastshotat = -1;
	
	player setVariable ["d_psuppressed", player addEventHandler ["Suppressed", {call d_fnc_suppressed}]];
};

#ifndef __IFA3__
0 spawn d_fnc_uav_check;
#endif

if (d_WithAmbientRadio == 1 && {!d_spe && {!d_ifa3}}) then {
   15 spawn d_fnc_AmbientRadioChatter;
};

#ifdef __TT__
["d_nogo_w", [-2000, d_island_y_max / 2, 0], "RECTANGLE", "ColorYellow", [2000, d_island_y_max / 2], "", 0, "", "BDiagonal", 0.7] call d_fnc_CreateMarkerLocal;

private _trig = [
	[-2000, d_island_y_max / 2, 0],
	[2000, d_island_y_max / 2, 0, true],
	["ANYPLAYER", "PRESENT", true],
	["vehicle player in thislist", "thisTrigger setVariable ['d_tt_p_check', true];d_tt_pcheck_curtrig = thisTrigger", "thisTrigger setVariable ['d_tt_p_check', false]"]
] call d_fnc_createtriggerlocal;

["d_nogo_n", [d_island_x_max / 2, d_island_y_max + 2000, 0], "RECTANGLE", "ColorYellow", [(d_island_x_max / 2) + 4000 , 2000], "", 0, "", "BDiagonal", 0.7] call d_fnc_CreateMarkerLocal;

_trig = [
	[d_island_x_max / 2, d_island_y_max + 2000, 0],
	[(d_island_x_max / 2) + 4000 , 2000, 0, true],
	["ANYPLAYER", "PRESENT", true],
	["vehicle player in thislist", "thisTrigger setVariable ['d_tt_p_check', true];d_tt_pcheck_curtrig = thisTrigger;", "thisTrigger setVariable ['d_tt_p_check', false]"]
] call d_fnc_createtriggerlocal;

["d_nogo_e", [d_island_x_max + 2000, d_island_y_max / 2, 0], "RECTANGLE", "ColorYellow", [2000, d_island_y_max / 2], "", 0, "", "BDiagonal", 0.7] call d_fnc_CreateMarkerLocal;

_trig = [
	[d_island_x_max + 2000, d_island_y_max / 2, 0],
	[2000, d_island_y_max / 2, 0, true],
	["ANYPLAYER", "PRESENT", true],
	["vehicle player in thislist", "thisTrigger setVariable ['d_tt_p_check', true];d_tt_pcheck_curtrig = thisTrigger;", "thisTrigger setVariable ['d_tt_p_check', false]"]
] call d_fnc_createtriggerlocal;

["d_nogo_s", [d_island_x_max / 2, -2000, 0], "RECTANGLE", "ColorYellow", [(d_island_x_max / 2) + 4000 , 2000], "", 0, "", "BDiagonal", 0.7] call d_fnc_CreateMarkerLocal;

_trig = [
	[d_island_x_max / 2, -2000, 0],
	[(d_island_x_max / 2) + 4000 , 2000, 0, true],
	["ANYPLAYER", "PRESENT", true],
	["vehicle player in thislist", "thisTrigger setVariable ['d_tt_p_check', true];d_tt_pcheck_curtrig = thisTrigger;", "thisTrigger setVariable ['d_tt_p_check', false]"]
] call d_fnc_createtriggerlocal;

0 spawn d_fnc_ttoutsidecheck;
#endif

0 spawn d_fnc_noaan;

if (d_without_nvg != 1 || {d_without_ti != 1}) then {
	0 spawn d_fnc_blockthermalnv;
};

d_isvdreduced = false;
d_isinuavmode = false;
if (d_AutoViewdistanceChangeDefault == 1) then {
	0 spawn d_fnc_vdhandler;
};

if (d_WithRevive == 0) then {
	player setVariable ["d_cur_opm", [player getOpticsMode 1, player getOpticsMode 2, player getOpticsMode 3]];
	player setVariable ["d_opmc_eh_id", 
		player addEventHandler ["OpticsModeChanged", {
			player setVariable ["d_cur_opm", [player getOpticsMode 1, player getOpticsMode 2, player getOpticsMode 3]];
		}]
	];
};

0 spawn d_fnc_camouflage;

if (d_dis_servicep == 1) then {
	0 spawn d_fnc_initservicepoints;
};

__TRACE_1("","d_isvdreduced")

0 spawn d_fnc_zeusmarkerworkaround;

0 spawn d_fnc_gimmick;

if (isMultiplayer) then {
	if (d_force_fast_intro == 1 || {!d_ifa3 && {!d_vn && {!d_spe}}}) then {
		0 spawn d_fnc_intro2;
	} else {
		0 spawn d_fnc_intro;
	};
} else {
	{_x enableSimulation false} forEach (switchableUnits select {_x != player});
#ifndef __VN__
	0 spawn {
		scriptName "spawn_setupplayer7";
		while {true} do {
			sleep 0.3;
			if (time > 0) exitWith {
				enableEnvironment [false, true];
			};
		};
	};
#endif
	if (!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}) then {
		0 spawn d_fnc_statusbar;
	};
};

0 spawn d_fnc_optioncontrol;

if (d_database_found) then {
	0 spawn {
		scriptName "spawn_setupplayer_sendtopplayers";
		sleep (1 + random 15);
		player remoteExec ["d_fnc_sendtopplayers", 2];
	};
};

if (isMultiplayer) then {
	0 spawn {
		scriptName "spawn_setupplayer8";
		waitUntil {!isNull findDisplay 46};
		findDisplay 46 displayAddEventHandler ["Unload", {
			if (d_database_found) then {
				if (!isNil "d_movecheck_handle" && {!isNull d_movecheck_handle}) then {
					terminate d_movecheck_handle;
				};
				[player, player getVariable "d_p_distar", d_p_rounds] remoteExecCall ["d_fnc_pdistar", 2];
			};
			/*if (d_with_ace) then {
				if (d_ace_arsenal_ar_save isNotEqualTo []) then {
					uiNamespace getVariable ["ace_arsenal_configItems", d_ace_arsenal_ar_save];
				};
			};*/
		}];
	};
};

// disable the FIR AWS dialog, use the internal one. Weapons like the GBU24 cause too much FPS drops
AWS_AMS_Disable = true;

diag_log [diag_frameno, diag_ticktime, time, "Dom x_setupplayer.sqf processed"];
