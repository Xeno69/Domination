// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"
#define THIS_FILE "fn_createnexttarget.sqf"

if (!isServer) exitWith{};

sleep 3;

waitUntil {sleep 0.2; (isMultiplayer && {getClientStateNumber >= 10}) || {!isMultiplayer}};

__TRACE("start")

if (d_first_time_after_start) then {
	d_first_time_after_start = false;
	sleep 18.123;
};

if (d_with_targetselect == 0) then {
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
d_cur_target_radius = _d_t_n_c_t_i # 2;
publicVariable "d_cur_target_radius";
d_mttarget_radius_patrol = d_cur_target_radius + 200 + random 200;
publicVariable "d_mttarget_radius_patrol";

sleep 1.0123;

d_update_target = false;
d_main_target_ready = false;
d_side_main_done = false;
d_sum_camps = -91;

#ifndef __TT__
private _tsar = ["'Man' countType thislist >= (d_man_count_for_target_clear + 6)", "d_target_clear = false; publicVariable 'd_target_clear';d_update_target=true;call d_fnc_makemtgmarker;remoteExec ['d_fnc_createnexttargetclient', [0, -2] select isDedicated];d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'Attack',['1','','" + d_cur_tgt_name + "',['" + d_cur_tgt_name + "']],d_kbtel_chan];deleteVehicle d_check_trigger", ""];
#else
private _tsar = ["'Man' countType thislist >= (d_man_count_for_target_clear + 6)", "d_target_clear = false; publicVariable 'd_target_clear';d_update_target=true;call d_fnc_makemtgmarker;remoteExec ['d_fnc_createnexttargetclient', [0, -2] select isDedicated];d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,'HQ_W','Attack',['1','','" + d_cur_tgt_name + "',['" + d_cur_tgt_name + "']],'SIDE'];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,'HQ_E','Attack',['1','','" + d_cur_tgt_name + "',['" + d_cur_tgt_name + "']],'SIDE'];deleteVehicle d_check_trigger;", ""];
#endif

d_check_trigger = [d_cur_tgt_pos, [d_cur_target_radius + 200, d_cur_target_radius + 200, 0, false], [d_enemy_side, "PRESENT", false], _tsar] call d_fnc_createtriggerlocal;

0 spawn d_fnc_docreatenexttarget;

__TRACE("!d_update_target")
while {!d_update_target} do {sleep 2.123};
__TRACE("!d_update_target done")

#ifndef __TT__
_tsar = if (d_ao_check_for_ai == 1) then {
	["d_mt_radio_down && {d_campscaptured == d_sum_camps && {'Car' countType thislist <= d_car_count_for_target_clear && {'Tank' countType thislist <= d_tank_count_for_target_clear && {'Man' countType thislist <= d_man_count_for_target_clear}}}}", "0 = 0 spawn d_fnc_target_clear", ""]
} else {
	["d_mt_radio_down && {d_campscaptured == d_sum_camps}", "0 = 0 spawn d_fnc_target_clear", ""]
};
#else
//_tsar = ["d_mt_radio_down && {d_campscaptured_w == d_sum_camps || {d_campscaptured_e == d_sum_camps}} && {('Car' countType thislist <= d_car_count_for_target_clear)} && {('Tank' countType thislist <= d_tank_count_for_target_clear)} && {('Man' countType thislist <= d_man_count_for_target_clear)}", "0 = 0 spawn d_fnc_target_clear", ""];
_tsar = ["d_mt_radio_down && {d_campscaptured_w == d_sum_camps || {d_campscaptured_e == d_sum_camps}}", "0 = 0 spawn d_fnc_target_clear", ""];
#endif

__TRACE_1("","_tsar")
d_current_trigger = [d_cur_tgt_pos, [d_cur_target_radius  + 50, d_cur_target_radius + 50, 0, false], [d_enemy_side, "PRESENT", false], _tsar] call d_fnc_createtriggerlocal;
__TRACE_1("","d_current_trigger")
if (!isNil "d_HC_CLIENT_OBJ_OWNER") then {
	[d_cur_tgt_pos, [d_cur_target_radius  + 50, d_cur_target_radius + 50, 0, false], [d_enemy_side, "PRESENT", false], ["this", "", ""]] remoteExecCall ["d_fnc_mct", d_HC_CLIENT_OBJ_OWNER];
};
