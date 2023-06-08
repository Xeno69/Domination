// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_delvecsmt = [];
d_delinfsm = [];
d_no_more_observers = 0;
d_create_new_paras = false;
d_x_sm_rem_ar = [];
d_x_sm_vec_rem_ar = [];
d_check_trigger = objNull;
d_first_time_after_start = true;
d_nr_observers = 0;
d_sm_resolved = false;
d_main_target_ready = false;
d_mt_spotted = false;
d_enable_awareness = false;
d_mt_radio_down = false;
d_mt_barracks_down = false;
d_mt_event_resolved = false;
d_x_mt_event_types = [
	"PILOT_RESCUE",
	"POW_RESCUE",
	//"GUERRILLA_TANKS", //not in the random events list, guerrilla tanks event depends on presence of guerrilla infantry
	"GUERRILLA_INFANTRY",
	//"RABBIT_RESCUE", // removed for now
	"MARKED_FOR_DEATH",
	"RESCUE_DEFEND",
	"RESCUE_DEFUSE",
	"CIV_RESISTANCE_INDEPENDENT",
	"KILL_TRIGGERMAN",
	"MARKED_FOR_DEATH_VIP_ESCORT"
];
if (d_WithLessArmor == 2 && {"GUERRILLA_TANKS" in d_x_mt_event_types}) then {d_x_mt_event_types = d_x_mt_event_types - ["GUERRILLA_TANKS"]};

d_x_mt_event_ar = [];
d_x_mt_event_pos = [];

addMissionEventHandler ["EntityKilled", {call d_fnc_entitykilled}];
addMissionEventHandler ["EntityRespawned", {call d_fnc_entityrespawned}];

// start air AI after some time
// ATTENTION! KEEP AIR AI RATES LOW!!!! AIR AI EATS UP FPS
if (d_MissionType != 2 && {d_disable_airai != 1}) then {
	0 spawn {
		scriptName "spawn_init_airai";
		__TRACE("spawn_init_airai start")
#ifndef __DEBUG__
		sleep 30;
#else
		sleep 2;
#endif
		__TRACE("spawn_init_airai 30 secs over")
		private _first = false;
		if (d_number_light_attack_choppers > 0 && {d_light_attack_chopper isNotEqualTo []}) then {
#ifndef __DEBUG__
			sleep 900;
#else
			sleep 5;
#endif
			_first = true;
			__TRACE("spawn_init_airai 30 exec LAC")
			["LAC"] spawn d_fnc_airai; // LAC = Ligh Attack Chopper
		};
		if (d_number_attack_choppers > 0 && {d_airai_attack_chopper isNotEqualTo []}) then {
#ifndef __DEBUG__
			sleep ([900, 120 + random 120] select _first);
#else
			sleep 5;
#endif
			_first = true;
			["HAC"] spawn d_fnc_airai; // HAC = Heavy Attack Chopper
		};
		if (d_number_attack_planes > 0 && {d_airai_attack_plane isNotEqualTo []}) then {
#ifndef __DEBUG__
			sleep ([900, 120 + random 120] select _first);
#else
			sleep 5;
#endif
			_first = true;
			["AP"] spawn d_fnc_airai; // AP = Attack Plane
		};
		if (d_number_attack_uavs > 0 && {d_airai_attack_uav isNotEqualTo []}) then {
#ifndef __DEBUG__
			sleep ([900, 120 + random 120] select _first);
#else
			sleep 5;
#endif
			["UAV"] spawn d_fnc_airai; // UAV = Attack UAV
		};		
	};
};

if (d_with_isledefense isNotEqualTo []) then {0 spawn d_fnc_isledefense};

#ifndef __TT__
if (!d_carrier && {!d_ifa3 && {d_with_base_sabotage == 0 && {d_transport_chopper isNotEqualTo []}}}) then {execFSM "fsms\fn_Infilrate.fsm"};
#endif

0 spawn d_fnc_ai_loop;

0 spawn d_fnc_uav_loop;
