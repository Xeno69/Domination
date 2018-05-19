// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getsidemission.sqf"
#include "..\x_setup.sqf"

if (!isServer || {d_all_sm_res}) exitWith{};

{
	_x setDamage 0;
} forEach d_house_objects2;
d_house_objects2 = [];

if (d_current_mission_counter >= d_number_side_missions) exitWith {
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

#ifndef __SMDEBUG__
if (d_MissionType != 2) then {
	while {!d_main_target_ready} do {sleep 2.321};
};
#endif

private _cur_sm_idx = d_side_missions_random # d_current_mission_counter;
d_current_mission_counter = d_current_mission_counter + 1;

__TRACE_1("","_cur_sm_idx")

d_x_sm_rem_ar = [];
d_x_sm_vec_rem_ar = [];

//_cur_sm_idx = _this select 0;
//_cur_sm_idx = 24;

if (isNil "d_HC_CLIENT_OBJ_OWNER") then {
	if (_cur_sm_idx < 50000) then {
		execVM format ["x_missions\%3\%2%1.sqf", _cur_sm_idx, d_sm_fname, d_sm_folder];
	} else {
		[_cur_sm_idx] spawn d_fnc_getbymarkersm;
	};
	sleep 7.012;
	__TRACE("Calling in getsidemission")
	[_cur_sm_idx, d_x_sm_pos, d_x_sm_type] remoteExecCall ["d_fnc_s_sm_up", 2];
} else {
	[_cur_sm_idx] remoteExec ["d_fnc_hcsmexec", d_HC_CLIENT_OBJ_OWNER];
};
