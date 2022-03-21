// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer || {d_all_sm_res}) exitWith{};

{
	_x setDamage 0;
} forEach d_house_objects2;
d_house_objects2 = [];

private _endsmfnc = {
	d_all_sm_res = true; publicVariable "d_all_sm_res";
#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "AllSMissionsResolved", d_kbtel_chan];
#else
	d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2, "HQ_W", "AllSMissionsResolved", "SIDE"];
	d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2, "HQ_E", "AllSMissionsResolved", "SIDE"];
#endif
	deleteVehicle d_sm_triggervb;
	d_sm_triggervb = nil;
};

if (d_current_mission_counter >= d_number_side_missions) exitWith {
	call _endsmfnc;
};

#ifndef __SMDEBUG__
if (d_MissionType != 2) then {
	while {!d_main_target_ready} do {sleep 2.321};
};
#endif

private _cur_sm_idx = d_side_missions_random # d_current_mission_counter;
d_current_mission_counter = d_current_mission_counter + 1;

//_cur_sm_idx = _this # 0;
//_cur_sm_idx = 50030;

__TRACE_1("","_cur_sm_idx")

private _do_exit = false;
while {!(_cur_sm_idx in (keys d_sm_hash))} do {
	_cur_sm_idx = d_side_missions_random # d_current_mission_counter;
	d_current_mission_counter = d_current_mission_counter + 1;
	if (d_current_mission_counter >= d_number_side_missions) exitWith {
		call _endsmfnc;
		_do_exit = true;
	};
};
if (_do_exit) exitWith {};


if (_cur_sm_idx < 50000) then {
	execVM format ["missions\%3\%2%1.sqf", _cur_sm_idx, d_sm_fname, d_sm_folder];
} else {
	[_cur_sm_idx] call d_fnc_getbymarkersm;
};

sleep 7.012;
[_cur_sm_idx] call d_fnc_s_sm_up;

if (random 100 > 50 && {!(toLowerANSI d_x_sm_type in ["convoy", "deliver", "prisoners", "evac", "specops"])}) then {
	d_sm_check_trigger = [d_x_sm_pos # 0, [30, 30, 0, false], ["ANYPLAYER", "PRESENT", false], ["this", "0 spawn d_fnc_smsurprise; deleteVehicle d_sm_check_trigger", ""]] call d_fnc_createtriggerlocal;
};

d_sm_check_trigger22 = [d_x_sm_pos # 0, [50, 50, 0, false], ["ANYPLAYER", "PRESENT", true], ["this", "0 spawn d_clear_smtrees", ""]] call d_fnc_createtriggerlocal;
