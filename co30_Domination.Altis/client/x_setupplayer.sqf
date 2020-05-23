// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_setupplayer.sqf"
#include "..\x_setup.sqf"

#include "\A3\ui_f\hpp\defineDIKCodes.inc"

diag_log [diag_frameno, diag_ticktime, time, "Executing Dom x_setupplayer.sqf"];

d_string_player = str player;
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
	d_UAV_Terminal = "B_UavTerminal";
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
	d_UAV_Terminal = "O_UavTerminal";
};
d_side_player = d_player_side;
#endif

d_arsenal_opened = false;

player disableConversation true;
if (!d_with_ai) then {
	enableSentences false;
};
[player, "NoVoice"] remoteExecCall ["setSpeaker", -2, false];

player setVariable ["d_tk_cutofft", time + 3];
player setVariable ["xr_pluncon", false];
d_player_in_base = true;
d_player_in_air = false;

d_player_vecs = [];

disableMapIndicators [true, true, false, false];

d_actionkeys_teamswitch = actionKeys "TeamSwitch";

if !(d_additional_respawn_points isEqualTo []) then {
	private _helparrp = [];
	{
		_helparrp pushBack [_x # 2, _forEachIndex];
	} forEach d_additional_respawn_points;
	_helparrp sort true;

	private _tempar =+ d_additional_respawn_points;
	d_additional_respawn_points = [];
	private "_ele";
	{
		_ele = _tempar select (_x # 1);
		d_additional_respawn_points pushBack _ele;
		d_add_resp_points_uni pushBack (_ele # 0);
	} forEach _helparrp;

	{
		if (_x # 1 isEqualType "") then {
			if !(markerPos (_x # 1) isEqualTo [0,0,0]) then {
#ifdef __TT__
				if (d_player_side != _x # 3) then {
					(_x # 1) setMarkerAlphaLocal 0;
					d_additional_respawn_points set [_forEachIndex, -1];
					d_add_resp_points_uni set [_forEachIndex, -1];
				} else {
					_x set [1, markerPos (_x # 1)];
				};
#else
				_x set [1, markerPos (_x # 1)];
#endif
			} else {
#ifdef __TT__
				if (d_player_side != _x # 3) then {
					d_additional_respawn_points set [_forEachIndex, -1];
					d_add_resp_points_uni set [_forEachIndex, -1];
				} else {
					private _dadao = missionNamespace getVariable (_x # 1);
					_x set [1, getPos _dadao];
					_dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {_this call d_fnc_teleportx}];
					if (d_ParaAtBase == 0) then {
						_dadao setVariable ["d_jf_id", _dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0]];
					};
					if (count _x > 4 && {_x # 4}) then {
						_dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1816"], {[0, 0, 0, [d_create_bike # 0, 1]] spawn d_fnc_bike}];
					};
				};
#else
				private _dadao = missionNamespace getVariable (_x # 1);
				_x set [1, getPos _dadao];
				_dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {_this call d_fnc_teleportx}];
				if (d_ParaAtBase == 0) then {
					_dadao setVariable ["d_jf_id", _dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0]];
				};
				if (count _x > 4 && {_x # 4}) then {
					_dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1816"], {[0, 0, 0, [d_create_bike # 0, 1]] spawn d_fnc_bike}];
				};
#endif
			};
		};
	} forEach d_additional_respawn_points;
#ifdef __TT__
	d_additional_respawn_points = d_additional_respawn_points - [-1];
	d_add_resp_points_uni = d_add_resp_points_uni - [-1];

	private _whichm = ["d_farp_marker_b", "d_farp_marker_o"] select (d_player_side == blufor);

	{
		deleteMarkerLocal _x;
	} forEach (allMapMarkers select {_x select [0, 15] == _whichm});
#endif
	d_add_resp_points_pos pushBack (getPos D_FLAG_BASE);
	{
		d_add_resp_points_pos pushBack (_x # 1);
	} forEach d_additional_respawn_points;
};

if (d_WithRevive == 1 && {!d_with_ace}) then {
	player setVariable ["xr_hd_eh_i", player addEventHandler ["handleDamage", {_this call xr_fnc_ClientHD}]];
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
#ifdef __IFA3LITE__
		d_withsandstorm = 1;
#endif
#ifdef __ROSCHE__
		d_withsandstorm = 1;
#endif
#ifdef __GMCWG__
		d_withsandstorm = 1;
#endif
#ifdef __LIVONIA__
		d_withsandstorm = 1;
#endif
#ifdef __TANOATT__
		d_withsandstorm = 1;
#endif
		if (d_withsandstorm == 0) then {0 spawn d_fnc_sandstorm};
	};
};

if (d_with_ranked) then {
	// basic rifle at start
	private _weapp = "";
	private _magp = "";
	switch (d_own_side) do {
		case "WEST": {
			if (d_rhs) exitWith {
				_weapp = "rhs_weap_m16a4";
				_magp = "rhs_mag_30Rnd_556x45_M855_Stanag";
			};
			if (d_cup) exitWith {
				_weapp = "CUP_arifle_M16A2";
				_magp = "CUP_30Rnd_556x45_Stanag";
			};
			if (d_ifa3lite) exitWith {
				_weapp = "LIB_K98";
				_magp = "LIB_5Rnd_792x57";
			};
			if (d_gmcwg) exitWith {
				_weapp = "gm_g3a3_oli";
				_magp = "gm_20rnd_762x51mm_b_t_dm21_g3_blk";
			};
			_weapp = "arifle_MX_F";
			_magp = "30Rnd_65x39_caseless_mag";
		};
		case "EAST": {
			if (d_rhs) exitWith {
				_weapp = "rhs_weap_ak74";
				_magp = "rhs_30Rnd_545x39_AK";
			};
			if (d_cup) exitWith {
				_weapp = "CUP_arifle_AK74";
				_magp = "CUP_30Rnd_545x39_AK_M";
			};
			if (d_ifa3lite) exitWith {
				_weapp = "LIB_M1903A3_Springfield";
				_magp = "LIB_5Rnd_762x63";
			};
			if (d_gmcwg) exitWith {
				_weapp = "gm_mpiak74n_brn";
				_magp = "gm_30rnd_545x39mm_b_7n6_ak74_prp";
			};
			_weapp = "arifle_MX_F";
			_magp = "30Rnd_65x39_caseless_mag";
		};
		case "GUER": {
			_weapp = "arifle_MX_F";
			_magp = "30Rnd_65x39_caseless_mag";
		};
	};
	removeAllWeapons player;
	player addMagazines [_magp, 6];
	player addWeapon _weapp;

	player setVariable ["d_pprimweap", primaryWeapon player];
	player setVariable ["d_psecweap", secondaryWeapon player];
	player setVariable ["d_phandgweap", handgunWeapon player];
	player setVariable ["d_pprimweapitems", primaryWeaponItems player];
	player setVariable ["d_psecweapitems", secondaryWeaponItems player];
	player setVariable ["d_phandgweapitems", handgunItems player];
	player addEventhandler ["Put", {call d_fnc_store_rwitems}];

	player addEventhandler ["SeatSwitchedMan", {_this call d_fnc_seatswitchedman}];
};

if (d_with_ranked || {d_database_found}) then {
	d_sm_p_pos = nil;
	if (!d_with_ace) then {
		player addEventHandler ["handleHeal", {_this call d_fnc_handleheal}];
	} else {
		["ace_treatmentSucceded", {_this call d_fnc_handleheal}] call CBA_fnc_addEventHandler;
	};

	inGameUISetEventHandler ["Action", "_this call d_fnc_healatmash; false"];
};

// available in non ranked versions too, removes nvg if without nvg is activated to avoid cheating
player addEventhandler ["Take", {_this call d_fnc_ptakeweapon}];

if (d_MissionType != 2) then {
	if !(d_resolved_targets isEqualTo []) then {
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
	if (d_current_target_index != -1 && {!d_target_clear && {!(d_cur_tgt_pos isEqualTo [])}}) then {
		d_current_seize = d_cur_tgt_name;
		"d_dummy_marker" setMarkerPosLocal d_cur_tgt_pos;
		private _tname = format ["d_obj%1", d_current_target_index + 2];
		[true, _tname, [format [localize "STR_DOM_MISSIONSTRING_202", d_current_seize], format [localize "STR_DOM_MISSIONSTRING_203", d_current_seize], format [localize "STR_DOM_MISSIONSTRING_203", d_current_seize]], d_cur_tgt_pos, true, 2, false, "Attack", false] call d_fnc_taskcreate;
		d_current_task = _tname;
		if (!isNil "d_obj00_task") then {
			d_obj00_task = nil;
			["d_obj00", "Succeeded", false] call d_fnc_taskSetState;
		};

		call d_fnc_cmakemtgmarker;
	};
};

if (d_ParaAtBase == 0) then {
#ifndef __TT__
	if (isNil {d_FLAG_BASE getVariable "d_jf_id"}) then {
		d_FLAG_BASE setVariable ["d_jf_id", d_FLAG_BASE addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0]];
	};
#else
	private _base_flag = [d_EFLAG_BASE, d_WFLAG_BASE] select (d_player_side == blufor);
	if (isNil {_base_flag getVariable "d_jf_id"}) then {
		_base_flag setVariable ["d_jf_id", _base_flag addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0]];
	};
#endif
};

#ifndef __TT__
if (d_MissionType != 2) then {
	{
		if (d_jumpflag_vec == "") then {
			_x setVariable ["d_jf_id", _x addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 1]];
		} else {
			_x setVariable ["d_jf_id", _x addAction [format ["<t color='#AAD9EF'>%1</t>", format [localize "STR_DOM_MISSIONSTRING_297", [d_jumpflag_vec, "CfgVehicles"] call d_fnc_GetDisplayName]], {_this spawn d_fnc_bike},[d_jumpflag_vec,1]]];
		};
	} forEach ((allMissionObjects d_flag_pole) select {!isNil {_x getVariable "d_is_jf"} && {isNil {_x getVariable "d_jf_id"}}});
};
#endif

if (d_all_sm_res) then {d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_522"} else {[false] spawn d_fnc_getsidemissionclient};

#ifndef __TT__
player addEventHandler ["Killed", {_this call d_fnc_pkilledeh}];
#else
if (d_player_side == blufor) then {
	player addEventHandler ["Killed", {[_this, 0] call d_fnc_pkilledeh}];
} else {
	player addEventHandler ["Killed", {[_this, 1] call d_fnc_pkilledeh}];
};
#endif
player addEventHandler ["respawn", {_this call d_fnc_prespawned}];

player setVariable ["d_currentvisionmode", 0];

// one entry: [box_object, color as array (R, G, B, Alpha), "Text to show above box"]
d_all_p_a_boxes = [];

if !(d_ammo_boxes isEqualTo []) then {
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

0 spawn {
	scriptName "spawn_setupplayer1";
	while {true} do {
		sleep 0.3;
		if (!d_still_in_intro) exitWith {};
	};
	d_d3d_locs4a = localize "STR_DOM_MISSIONSTRING_1718";
#ifndef __TT__
	d_3draw_ar = [
		[d_FLAG_BASE, localize "STR_DOM_MISSIONSTRING_1644", 2.5, 0]
	];
	if (!isNil "d_vecre_trigger") then {
		d_3draw_ar pushBack [d_vecre_trigger, localize "STR_DOM_MISSIONSTRING_524", 5, 1];
	};
	if (!isNil "d_jet_trigger") then {
		d_3draw_ar pushBack [d_jet_trigger, localize "STR_DOM_MISSIONSTRING_526", 5, 1];
	};
	private _allmhs = (allMissionObjects "Land_HelipadSquare_F") + (allMissionObjects "Land_HelipadEmpty_F");
	{
		d_3draw_ar pushBack [_x, localize "STR_DOM_MISSIONSTRING_0", 5, 1];
	} forEach (_allmhs select {(str _x) select [0, 11] == "d_wreck_rep"});

	if (!d_ifa3lite && {!isNil "d_chopper_trigger"}) then {
		d_3draw_ar pushBack [d_chopper_trigger, localize "STR_DOM_MISSIONSTRING_528", 5, 1];
	};
	if (d_carrier) then {
		d_3draw_ar pushBack [d_flag_airfield, localize "STR_DOM_MISSIONSTRING_1760", 5, 0];
	};
	{
		d_3draw_ar pushBack [_x, localize "STR_DOM_MISSIONSTRING_1761", 5, 1];
	} forEach (_allmhs select {(str _x) select [0, 20] == "d_serviceall_trigger"});
	if (d_with_ai) then {
		d_d3d_locsaire = localize "STR_DOM_MISSIONSTRING_314";
		d_allai_recruit_objs = [d_AI_HUT] + d_additional_recruit_buildings;
	};
#else
	d_3draw_ar = [
		[[d_EFLAG_BASE, d_WFLAG_BASE] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_1644", 2.5, 0]
	];

	if (!isNil "d_vecre_trigger") then {
		d_3draw_ar pushBack [[d_vecre_trigger2, d_vecre_trigger] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_524", 5, 1];
	};
	if (!isNil "d_jet_trigger") then {
		d_3draw_ar pushBack [[d_jet_trigger2, d_jet_trigger] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_526", 5, 1];
	};
	if (!isNil "d_chopper_trigger") then {
		d_3draw_ar pushBack [[d_chopper_triggerR, d_chopper_trigger] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_528", 5, 1];
	};
	if (!isNil "d_wreck_rep") then {
		d_3draw_ar pushBack [[d_wreck_rep2, d_wreck_rep] select (d_player_side == blufor), localize "STR_DOM_MISSIONSTRING_0", 5, 1];
	};
#endif
	{
		d_3draw_ar pushBack [_x, localize "STR_DOM_MISSIONSTRING_531", 5, 2];
	} forEach d_all_ammoloads;

	addMissionEventHandler ["Draw3D", {call d_fnc_draw3dstuff}];

	"d_fpsresource" cutRsc ["d_fpsresource", "PLAIN"];
	if (d_player_can_call_arti > 0 || {d_player_can_call_drop > 0 || {d_string_player in d_can_call_cas || {!d_no_ai}}}) then {
		"d_RscSupportL" cutRsc ["d_RscSupportL", "PLAIN"];
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

diag_log ["Internal D Version: 4.27"];

if (!d_no_ai) then {
	if (d_with_ai) then {
		if (isNil "d_AI_HUT") then {
			0 spawn {
				scriptName "spawn_wait_for_ai_hut";
				while {true} do {
					sleep 0.512;
					if (!isNil "d_AI_HUT") exitWith {};
				};
				call compile preprocessFileLineNumbers "client\x_recruitsetup.sqf";
			};
		} else {
			call compile preprocessFileLineNumbers "client\x_recruitsetup.sqf";
		};

		private _grpp = group player;
		private _leader = leader _grpp;
		if (!(_leader call d_fnc_isplayer) || {player == _leader}) then {
			{
				if (isNull objectParent _x) then {
					deleteVehicle _x;
				} else {
					(vehicle _x) deleteVehicleCrew _x;
				};
			} forEach ((units _grpp) select {!(_x call d_fnc_isplayer)});
		};
	};

	d_player_can_call_arti = 1;
	d_player_can_call_drop = 1;
	d_player_can_call_cas = 1;
	player setUnitTrait ["Medic", true];
	player setUnitTrait ["engineer", true];
} else {
	if (d_string_player in d_can_use_artillery) then {
		d_player_can_call_arti = 1;
	} else {
		enableEngineArtillery false;
	};
	if (d_string_player in d_can_call_drop_ar) then {
		d_player_can_call_drop = 1;
	};
	if (d_string_player in d_can_call_cas) then {
		d_player_can_call_cas = 1;
	};
};
player setUnitTrait ["explosiveSpecialist", true];

private _respawn_marker = "";
private _base_spawn_m = "base_spawn_1";
switch (d_own_side) do {
	case "GUER": {
		_respawn_marker = "respawn_guerrila";
		deleteMarkerLocal "respawn_west";
		deleteMarkerLocal "respawn_east";
	};
	case "WEST": {
		_respawn_marker = "respawn_west";
		deleteMarkerLocal "respawn_guerrila";
		deleteMarkerLocal "respawn_east";
	};
	case "EAST": {
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
#ifdef __IFA3LITE__
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
		{_x addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_513"], {_this call d_fnc_restoreeng}]} forEach d_farps;
	};
};

{
	_x addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_286a"], {_this call d_fnc_healatmash}, 0, -1, false, false, "", "damage player > 0 && {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable 'd_isinaction')}}}}"];
} forEach d_mashes;

{
	private _farpc = _x getVariable ["d_objcont", []];
	if !(_farpc isEqualTo []) then {
		_farpc params ["_trig"];
		_trig setTriggerActivation ["ANY", "PRESENT", true];
		_trig setTriggerStatements ["[thislist, thisTrigger] call d_fnc_tallservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""];
	};
} forEach d_farps;

#ifndef __TT__
// Enemy at base
"d_enemy_base" setMarkerPosLocal (d_base_array # 0);
"d_enemy_base" setMarkerDirLocal (d_base_array # 3);
[d_base_array # 0, [d_base_array # 1, d_base_array # 2, d_base_array # 3, true, 2], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || {'Tank' countType thislist > 0 || {'Car' countType thislist > 0}}", "[0] call d_fnc_BaseEnemies;'d_enemy_base' setMarkerSizeLocal [d_base_array select 1,d_base_array select 2];d_there_are_enemies_atbase = true", "[1] call d_fnc_BaseEnemies;'d_enemy_base' setMarkerSizeLocal [0,0];d_there_are_enemies_atbase = false"]] call d_fnc_createtriggerlocal;
[d_base_array # 0, [(d_base_array # 1) + 300, (d_base_array # 2) + 300, d_base_array # 3, true, 2], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || {'Tank' countType thislist > 0 || {'Car' countType thislist > 0}}", "if (!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false])}) then {hint (localize 'STR_DOM_MISSIONSTRING_1409')};d_enemies_near_base = true", "d_enemies_near_base = false"]] call d_fnc_createtriggerlocal;
#endif

if (player getUnitTrait "Medic") then {
	player setVariable ["d_medtent", []];
};

d_x_loop_end = false;
if (d_WithMHQTeleport == 0) then {
#ifndef __TT__
	d_FLAG_BASE addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {_this call d_fnc_teleportx}];
#else
	private _base_flag = [d_EFLAG_BASE, d_WFLAG_BASE] select (d_player_side == blufor);
	_base_flag addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {_this call d_fnc_teleportx}];
#endif
};

#ifndef __TT__
d_FLAG_BASE addaction [format ["<t color='#3F3F3F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1745"], {_this call d_fnc_playerspectate}];
#endif

if (d_ParaAtBase == 1) then {
	"d_Teleporter" setMarkerTextLocal (localize "STR_DOM_MISSIONSTRING_534");
#ifdef __TT__
	"d_teleporter_1" setMarkerTextLocal (localize "STR_DOM_MISSIONSTRING_534");
#endif
};

if (!d_with_ace) then {
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
		//d_pnhudgroupcolor = [0.96, 1, 0, 0.7];
		//d_pnhudothercolor = [0.86, 0.89, 0.1, 0.7];
		d_pnhudgroupcolor = [0, 1, 0, 0.9];
		d_pnhudothercolor = [1, 1, 1, 0.8];
		d_pnhuddeadcolor = [0, 0, 0, 0];

		d_pnhuddo2_prevCT = objNull;
		d_showPlayerNameRSC_shown = false;
		d_pnhuddo2_frskip = 0;

		if (d_show_pname_hud) then {
			d_pl_name_huddo_ar = [];
			["dom_fillname_huddo", {call d_fnc_fillname_huddo}] call d_fnc_eachframeadd;
			d_phudraw3d = addMissionEventHandler ["Draw3D", {call d_fnc_player_name_huddo}];
		} else {
			["dom_player_hud2", {call d_fnc_player_name_huddo2}] call d_fnc_eachframeadd;
		};
	};
};

private _primw = primaryWeapon player;
if (_primw != "") then {
	player selectWeapon _primw;
};

if (d_MissionType != 2) then {
	if !(d_currentcamps isEqualTo []) then {
		call d_fnc_curcampsclient;
	};

	if (!isNil "d_searchbody" && {!isNull d_searchbody && {isNil {d_searchbody getVariable "d_search_id"}}}) then {
		call d_fnc_s_b_client;
	};
};

player setVariable ["d_p_f_b", 0];

player addEventHandler ["firedMan", {_this call d_fnc_playerfiredeh}];

if (d_no_3rd_person == 0) then {
	execFSM "fsms\fn_3rdperson.fsm";
};

d_mark_loc280 = localize "STR_DOM_MISSIONSTRING_280";
d_mark_loc261 = localize "STR_DOM_MISSIONSTRING_261";
d_mark_loc1825 = localize "STR_DOM_MISSIONSTRING_1825";

d_map_ameh = addMissionEventHandler ["Map", {
	if (_this select 0) then {
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
	player reveal _x;
	[_x] call d_fnc_weaponcargo;
	_x enableRopeAttach false;
	_x allowDamage false;
	[format ["d_pab_%1", _x], _x, "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_523", 0, d_dropped_box_marker] call d_fnc_CreateMarkerLocal;
#ifndef __TT__
} forEach d_player_ammoboxes;
#else
} forEach (d_player_ammoboxes select ([0, 1] select (d_player_side == opfor)));
#endif

private _dsp46 = findDisplay 46;

_dsp46 displayAddEventHandler ["MouseZChanged", {_this call d_fnc_MouseWheelRec}];

if (d_WithRevive == 0) then {
	call compile preprocessFileLineNumbers "revive.sqf";
};

0 spawn d_fnc_dcmcc;

if (d_with_bis_dynamicgroups == 0) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
	0 spawn {
		scriptName "spawn_setupplayer3";
		waitUntil {!isNil {missionNamespace getVariable "BIS_dynamicGroups_key"}};
		(findDisplay 46) displayAddEventHandler ["KeyDown", {_this call d_fnc_keydown_dyng}];
		(findDisplay 46) displayAddEventHandler ["KeyUp", {_this call d_fnc_keyup_dyng}];
	};
} else {
	_dsp46 displayAddEventHandler ["KeyDown", {_this call d_fnc_keydown_dyng}];
	_dsp46 displayAddEventHandler ["KeyUp", {_this call d_fnc_keyup_dyng}];
};

_dsp46 displayAddEventHandler ["KeyDown", {_this call d_fnc_earplugs}];
#ifndef __TT__
if (!d_with_ace) then {
	_dsp46 displayAddEventHandler ["KeyDown", {_this call d_fnc_toggle3dm}];
} else {
	d_showallnearusermarkers = false;
};
#endif

// by R34P3R
d_p_isju = false;
if (!d_with_ace) then {
	_dsp46 displayAddEventHandler ["KeyDown", {_this call d_fnc_jumpover}];
};

d_vec_role_pl = [];
player addEventhandler ["getInMan", {_this call d_fnc_getinmaneh}];
player addEventhandler ["getOutMan", {_this call d_fnc_getoutmaneh}];

player addEventhandler ["SeatSwitchedMan", {_this call d_fnc_seatswitchedmanvs}];

d_pisadminp = false;
if (d_AutoKickTime == 0 || {d_with_ranked || {d_MissionType == 2}}) then {
	d_clientScriptsAr set [1, true];
} else {
	if (d_database_found) then {
		0 spawn {
			scriptName "spawn_setupplayer5";
			sleep 30;
			if (score player > 500) then {
				d_clientScriptsAr set [1, true];
				if (!isNil "d_player_autokick_time") then {d_player_autokick_time = nil};
			};
		};
	};
};

0 spawn d_fnc_startClientScripts;

#ifdef __TT__
if (d_player_side == blufor) then {
#endif
if !(markerPos "d_runwaymarker" isEqualTo [0,0,0]) then {
	private _msize = markerSize "d_runwaymarker";
	[[markerPos "d_runwaymarker" # 0, markerPos "d_runwaymarker" # 1, 1.9], [_msize # 0, _msize # 1, markerDir "d_runwaymarker", true, 2], ["ANY", "PRESENT", true], ["!((thislist unitsBelowHeight 1) isEqualTo [])", "'d_runwaymarker' setMarkerColorLocal 'ColorRed'", "'d_runwaymarker' setMarkerColorLocal 'ColorGreen'"]] call d_fnc_createtriggerlocal;
};
#ifdef __TT__
};
if (d_player_side == opfor && {!(markerPos "d_runwaymarker_o" isEqualTo [0,0,0])}) then {
	private _msize = markerSize "d_runwaymarker_o";
	[[markerPos "d_runwaymarker_o" # 0, markerPos "d_runwaymarker_o" # 1, 1.9], [_msize # 0, _msize # 1, markerDir "d_runwaymarker_o", true, 2], ["ANY", "PRESENT", true], ["!((thislist unitsBelowHeight 1) isEqualTo [])", "'d_runwaymarker_o' setMarkerColorLocal 'ColorRed'", "'d_runwaymarker_o' setMarkerColorLocal 'ColorGreen'"]] call d_fnc_createtriggerlocal;
};
#endif

player call d_fnc_removenvgoggles_fak;
#ifndef __IFA3LITE__
if (d_without_nvg == 1 && {!d_gmcwg && {!(player call d_fnc_hasnvgoggles)}}) then {
	player linkItem (switch (d_player_side) do {
		case opfor: {"NVGoggles_OPFOR"};
		case independent: {"NVGoggles_INDEP"};
		default {"NVGoggles"};
	});
};
private _bino = binocular player;
if (!d_gmcwg) then {
	if (d_string_player in d_can_use_artillery || {d_string_player in d_can_mark_artillery || {d_string_player in d_can_call_cas}}) then {
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
} else {
	if (_bino == "") then {
		player addWeapon "gm_ferod16_oli";
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
	if !(_ar isEqualTo []) then {
		d_areArtyVecsAvailable = true;
		d_ao_arty_vecs append _ar;
	};
};
#ifndef __TT__
[10, "d_artyvec_"] call _fnc_artvec;
#else
[11, ["d_artyvecb_", "d_artyveco_"] select (d_player_side == opfor)] call _fnc_artvec;
#endif

if (!d_no_ai || {d_string_player in d_can_use_artillery || {d_string_player in d_can_mark_artillery}}) then {
	if (!d_ifa3lite && {!d_gmcwg}) then {
		player setVariable ["d_ld_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1520"], {_this call d_fnc_mark_artillery} , 0, 9, true, false, "", "alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}"]];
	} else {
		player setVariable ["d_ld_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1520"], {_this call d_fnc_mark_artillery} , 0, 9, true, false, "", "alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}}}"]];
	};
};

if (isNil "d_cas_plane_avail") then {
	if (!d_no_ai || {d_string_player in d_can_call_cas}) then {
#ifndef __TT__
		if (!d_ifa3lite && {!d_gmcwg}) then {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea d_base_array) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}}}"]];
		} else {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!(screenToWorld [0.5, 0.5] inArea d_base_array) && {currentWeapon player isKindOf ['Binocular', configFile >> 'CfgWeapons']}}}}}}}}"]];
		};
#else
		if (d_player_side == blufor) then {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available_w && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea (d_base_array select 0)) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}}}"]];
		} else {
			player setVariable ["d_ccas_action", player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_1711"], {_this call d_fnc_call_cas} , 0, 9, true, false, "", "d_cas_available_e && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable ['d_isinaction', false]) && {!d_player_in_vec && {cameraView == 'GUNNER' && {!isNull (laserTarget player) && {!((laserTarget player) inArea (d_base_array select 0)) && {currentWeapon player isKindOf ['LaserDesignator', configFile >> 'CfgWeapons']}}}}}}}}}"]];
		};
#endif
	};
};

player addEventhandler["InventoryOpened", {_this call d_fnc_inventoryopened}];
player addEventhandler["InventoryClosed", {_this call d_fnc_inventoryclosed}];

if (!d_with_ace || {d_with_ranked}) then {
	[missionNamespace, "arsenalOpened", {
		_this call d_fnc_arsenalopened;
	}] call BIS_fnc_addScriptedEventHandler;

	[missionNamespace, "arsenalClosed", {
		call d_fnc_arsenalclosed;
	}] call BIS_fnc_addScriptedEventHandler;
} else {
	["ace_arsenal_displayOpened", {
		_this call d_fnc_arsenalopened;
	}] call CBA_fnc_addEventHandler;

	["ace_arsenal_displayClosed", {
		_this call d_fnc_arsenalopened;
	}] call CBA_fnc_addEventHandler;
};

player addEventhandler ["HandleRating", {
	if ((_this select 1) < 0) then {0} else {_this select 1}
}];

["d_scacheck", {call d_fnc_SCACheck}] call d_fnc_eachframeadd;

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
			[_x, ["xr_isleader", false]] remoteExecCall ["setVariable", _x];
		} forEach ((units (group player)) - [player]);
	};
};

player addEventhandler ["WeaponAssembled", {
	["aw", d_string_player, _this # 1] remoteExecCall ["d_fnc_p_o_ar", 2];
}];

{
	_x call d_fnc_initvec;
	if (unitIsUAV _x && {isClass (configFile>>"CfgVehicles">>(typeOf _x)>>"Components">>"TransportPylonsComponent")}) then {
		_x call d_fnc_addpylon_action;
	};
} forEach _vehicles;

["Preload"] call bis_fnc_arsenal;

if (!d_gmcwg) then {
	d_arsenal_mod_remove_strings pushBack "gm_";
};

if (d_arsenal_mod_remove_strings isEqualTo []) then {
	d_arsenal_mod_remove_strings call d_fnc_arsenal_mod_rem;

	d_arsenal_mod_remove_strings = nil;
};

if (d_arsenal_mod == 0) then {
	if (d_ifa3lite) then {
		["WW2_"] call d_fnc_arsenal_mod;
	} else {
		if (d_cup) then {
			d_arsenal_mod_prestrings pushBack "CUP_";
		};
		if (d_rhs) then {
			d_arsenal_mod_prestrings append ["rhs_", "rhsgref_", "rhsusf_", "rhssaf_"];
		};
		if (d_gmcwg) then {
			d_arsenal_mod_prestrings pushBack "gm_";
		};
		if (d_with_ace && {!(d_arsenal_mod_prestrings isEqualTo [])}) then {
			d_arsenal_mod_prestrings pushBack "ace_";
		};
		if !(d_arsenal_mod_prestrings isEqualTo []) then {
			d_arsenal_mod_prestrings call d_fnc_arsenal_mod;
		};
	};
	d_arsenal_mod_prestrings = nil;
};

for "_i" from 0 to (count d_remove_from_arsenal - 1) do {
	private _proceed = true;
	if (d_with_ranked && {!(_i in [5, 22, 23, 26])}) then {
		_proceed = false;
	};
	if (_proceed && {!((d_remove_from_arsenal # _i) isEqualTo []) && {!((bis_fnc_arsenal_data # _i) isEqualTo [])}}) then {
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

		if !(_classes isEqualTo []) then {
			_classes = _classes apply {toLowerANSI _x};
		};

		__TRACE_2("","_i","_codes")
		__TRACE_2("","_i","_classes")

		__TRACE_2("1","count _badar","_badar")

		private ["_changed"];
		{
			_changed = false;
			if !(_codes isEqualTo []) then {
				private _curnum = _forEachIndex;
				private _curele = _x;
				__TRACE_1("","_codes")
				{
					if (_curele call _x) then {
						_badar set [_curnum, -1];
						_changed = true;
					};
				} forEach _codes;
			};
			if (!_changed && {!(_classes isEqualTo []) && {toLowerANSI _x in _classes}}) then {
				__TRACE("in second")
				_badar set [_forEachIndex, -1];
			};
		} forEach _badar;
		_badar = _badar - [-1];
		__TRACE_2("2","count _badar","_badar")
		bis_fnc_arsenal_data set [_i, _badar];
	};
};

if (d_with_ranked) then {
	0 spawn d_fnc_weaponcargo_ranked;
};

missionNamespace setVariable ["BIS_dynamicGroups_allowInterface", false];

0 spawn d_fnc_allplayers;

if (d_with_ace) then {
	addMissionEventHandler ["Draw3D", {call d_fnc_draw3d_ace}];
};

d_last_placed_zeus_obj = objNull;
{
	_x addEventhandler ["CuratorObjectPlaced", {
		_this call d_fnc_place;
#ifndef __TT__
		addToRemainsCollector [_this select 1];
		private _grp = group (_this select 1);
		if (!isNull _grp) then {
			if (!isGroupDeletedWhenEmpty _grp) then {
				_grp deleteGroupWhenEmpty true;
			};
			if (d_with_ai && {side _grp in d_own_sides_o && {isNil {_grp getVariable "d_do_not_delete"}}}) then {
				[_grp, ["d_do_not_delete", true]] remoteExecCall ["setVariable", 2];
				_grp setVariable ["d_do_not_delete", true];
			};
		};
#endif
		_this select 1
	}];
} forEach allCurators;

if (d_with_ai) then {
	d_hchelperhandle = scriptNull;
	addMissionEventHandler ["CommandModeChanged", {_this call d_fnc_cmchanged}];
};

#ifndef __IFA3LITE__
0 spawn d_fnc_uav_check;
#endif

if (d_WithAmbientRadio == 1) then {
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

#ifndef __IFA3__
if (d_without_nvg == 0 || {d_without_vec_ti == 0}) then {
	0 spawn d_fnc_blockthermalnv;
};
#endif

d_isvdreduced = false;
#ifndef __TT__
0 spawn d_fnc_vdhandler;
#endif

call d_fnc_initservicepoints;

if (isMultiplayer) then {
	execVM "client\x_intro2.sqf";
} else {
	{_x enableSimulation false} forEach (switchableUnits select {_x != player});
	0 spawn {
		scriptName "spawn_setupplayer7";
		while {true} do {
			sleep 0.3;
			if (time > 0) exitWith {
				enableEnvironment [false, true];
			};
		};
	};
	0 spawn d_fnc_statusbar;
};

diag_log [diag_frameno, diag_ticktime, time, "Dom x_setupplayer.sqf processed"];
