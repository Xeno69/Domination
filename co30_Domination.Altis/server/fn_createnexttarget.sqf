// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

sleep 3;
while {true} do {
	sleep 0.2;
	if ((isMultiplayer && {getClientStateNumber >= 10}) || {!isMultiplayer}) exitWith {};
};

__TRACE("start")

if (d_first_time_after_start) then {
	d_first_time_after_start = false;
	if (isMultiplayer) then {
		sleep 22.123;
	} else {
		sleep 1;
	};
};

if (d_with_targetselect_count > 0 && {!d_tt_ver}) then {
	call d_fnc_selectnexttarget;
};

__TRACE_1("before delete","d_maintargets_list")
d_current_target_index = d_maintargets_list # 0;
publicVariable "d_current_target_index";
d_maintargets_list deleteAt 0;

__TRACE_1("","d_current_target_index")
__TRACE_1("after delete","d_maintargets_list")

private _d_t_n_c_t_i = d_target_names # d_current_target_index;
d_cur_tgt_pos = _d_t_n_c_t_i # 0;
publicVariable "d_cur_tgt_pos";
d_cur_tgt_name = _d_t_n_c_t_i # 1;
publicVariable "d_cur_tgt_name";
if (d_ao_radius_override > 0) then {
	d_cur_target_radius = d_ao_radius_override;
} else {
	d_cur_target_radius = _d_t_n_c_t_i # 2;
};
publicVariable "d_cur_target_radius";
d_mttarget_radius_patrol = d_cur_target_radius + 200 + random 200;
publicVariable "d_mttarget_radius_patrol";

sleep 1.0123;

d_update_target = false;
d_main_target_ready = false;
d_side_main_done = false;
if (isNil "d_sum_camps") then {0 spawn d_fnc_campshelper};
d_sum_camps = -91;

#ifdef __TT__
d_mt_barracks_down = false;
d_lastchanceover = false;
d_lastchancerunning = false;
d_recapturedcamp = false;
#endif

d_pl_mt_score_hash = createHashMap;
__TRACE("filling d_pl_mt_score_hash")
{
	__TRACE_1("","_x")
#ifdef __DEBUG__
	private _uid = getPlayerUID _x;
	private _score = score _x;
	private _name = name _x;
	__TRACE_3("","_uid","_score","_name")
#endif
	d_pl_mt_score_hash set [getPlayerUID _x, [score _x, _x, name _x, -11211]];
} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x && {!(_x isKindOf "VirtualMan_F")}});

#ifndef __TT__
private _tsar = ["'Man' countType thislist >= (d_man_count_for_target_clear + 5)", "d_target_clear = false; publicVariable 'd_target_clear';d_update_target=true;call d_fnc_makemtgmarker;remoteExec ['d_fnc_createnexttargetclient', [0, -2] select isDedicated];d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'Attack',['1','','" + d_cur_tgt_name + "',['" + d_cur_tgt_name + "']],d_kbtel_chan];deleteVehicle d_check_trigger", ""];
#else
private _tsar = ["'Man' countType thislist >= (d_man_count_for_target_clear + 5)", "d_target_clear = false; publicVariable 'd_target_clear';d_update_target=true;call d_fnc_makemtgmarker;remoteExec ['d_fnc_createnexttargetclient', [0, -2] select isDedicated];d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,'HQ_W','Attack',['1','','" + d_cur_tgt_name + "',['" + d_cur_tgt_name + "']],'SIDE'];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,'HQ_E','Attack',['1','','" + d_cur_tgt_name + "',['" + d_cur_tgt_name + "']],'SIDE'];deleteVehicle d_check_trigger;", ""];
#endif

d_check_trigger = [d_cur_tgt_pos, [d_cur_target_radius + 200, d_cur_target_radius + 200, 0, false], [d_enemy_side, "PRESENT", false], _tsar] call d_fnc_createtriggerlocal;

0 spawn d_fnc_docreatenexttarget;

__TRACE("!d_update_target")
while {!d_update_target} do {sleep 2.123};
__TRACE("!d_update_target done")

#ifndef __TT__
_tsar = call {
	if (d_ao_check_for_ai == 0) exitWith {
		["d_mt_radio_down && {d_sum_camps > 0 && {d_campscaptured == d_sum_camps}}", "0 = 0 spawn d_fnc_target_clear", ""]
	};
	if (d_ao_check_for_ai == 1) exitWith {
		["d_mt_radio_down && {d_sum_camps > 0 && {d_campscaptured == d_sum_camps && {'Car' countType thislist <= d_car_count_for_target_clear && {'Tank' countType thislist <= d_tank_count_for_target_clear && {'Man' countType thislist <= d_man_count_for_target_clear}}}}}", "0 = 0 spawn d_fnc_target_clear", ""]
	};
	if (d_ao_check_for_ai == 2) exitWith {
		["d_mt_radio_down && {'Car' countType thislist <= d_car_count_for_target_clear && {'Tank' countType thislist <= d_tank_count_for_target_clear && {'Man' countType thislist <= d_man_count_for_target_clear}}}", "0 = 0 spawn d_fnc_target_clear", ""]
	};
};
#else
//_tsar = ["d_mt_radio_down && {d_sum_camps > 0 && {d_campscaptured_w == d_sum_camps || {d_campscaptured_e == d_sum_camps}}} && {('Car' countType thislist <= d_car_count_for_target_clear)} && {('Tank' countType thislist <= d_tank_count_for_target_clear)} && {('Man' countType thislist <= d_man_count_for_target_clear)}", "0 = 0 spawn d_fnc_target_clear", ""];
private _tsar1 = ["d_mt_radio_down && {!d_lastchancerunning && {!d_lastchanceover && {d_mt_barracks_down && {d_sum_camps > 0 && {d_campscaptured_w == d_sum_camps || {d_campscaptured_e == d_sum_camps}}}}}}", "d_lastchancerunning = true; 0 = 0 spawn d_fnc_lastchance", ""];
_tsar = ["d_mt_radio_down && {d_sum_camps > 0 && {d_lastchanceover && {d_mt_barracks_down && {d_campscaptured_w == d_sum_camps || {d_campscaptured_e == d_sum_camps}}}}}", "0 = 0 spawn d_fnc_target_clear", ""];
#endif

__TRACE_1("","_tsar")
#ifndef __TT__
if (d_ao_check_for_ai < 2) then {
	private _helpertrigt = ["d_mt_radio_down && {d_mt_barracks_down && {'Car' countType thislist <= d_car_count_for_target_clear && {'Tank' countType thislist <= d_tank_count_for_target_clear && {'Man' countType thislist <= d_man_count_for_target_clear}}}}", "d_camps_workaround_handle = 0 spawn d_fnc_camps_workaround", ""];
	d_current_trigger_helper = [d_cur_tgt_pos, [d_cur_target_radius  + 50, d_cur_target_radius + 50, 0, false], [d_enemy_side, "PRESENT", false], _helpertrigt] call d_fnc_createtriggerlocal;
};
#endif
d_current_trigger = [d_cur_tgt_pos, [d_cur_target_radius  + 50, d_cur_target_radius + 50, 0, false], [d_enemy_side, "PRESENT", false], _tsar] call d_fnc_createtriggerlocal;
__TRACE_1("","d_current_trigger")
#ifdef __TT__
d_current_triggerTT = [d_cur_tgt_pos, [d_cur_target_radius  + 50, d_cur_target_radius + 50, 0, false], [d_enemy_side, "PRESENT", true], _tsar1] call d_fnc_createtriggerlocal;
#endif
