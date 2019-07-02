// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_serverinit.sqf"
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
d_mt_radio_down = false;
d_mt_barracks_down = false;
d_mt_mobile_hq_down = false;

// start air AI after some time
#ifndef __TT__
if (d_MissionType != 2 && d_disable_airai != 1) then {
	0 spawn {
		scriptName "spawn_x_init_airai";
		__TRACE("spawn_x_init_airai start")
		sleep 30;
		__TRACE("spawn_x_init_airai 30 secs over")
		if !(d_light_attack_chopper isEqualTo []) then {
			sleep 1200;
			__TRACE("spawn_x_init_airai 30 exec LAC")
			["LAC"] spawn d_fnc_airai; // LAC = Ligh Attack Chopper
		};
		if !(d_airai_attack_chopper isEqualTo []) then {
			sleep 1200;
			["HAC"] spawn d_fnc_airai; // HAC = Heavy Attack Chopper
		};
		if !(d_airai_attack_plane isEqualTo []) then {
			sleep 1200;
			["AP"] spawn d_fnc_airai; // AP = Attack Plane
		};
	};
};
#endif


if !(d_with_isledefense isEqualTo []) then {0 spawn d_fnc_isledefense};

#ifndef __TT__
if (!d_carrier && {!d_ifa3lite && {d_with_base_sabotage == 0 && {!(d_transport_chopper isEqualTo [])}}}) then {execFSM "fsms\fn_Infilrate.fsm"};
#endif

0 spawn d_fnc_ai_loop;
