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

private _cur_sm_idx = nil;
private _smpos = [[0, 0, 0]];
private _smkey = "";
private _iter = 0;
private _sm_selected_size_at_start = 0;

if (!isNil "d_sm_selected" && {!(d_sm_selected isEqualTo [])}) then {
	_sm_selected_size_at_start = count d_sm_selected;
};

if (d_MissionType == 3) then {	
	
	waitUntil {
		!isNil "d_cur_tgt_pos" && {!(d_cur_tgt_pos isEqualTo []) && {!isNil "d_sm_array" && {!(d_sm_array isEqualTo [])}}}
	};
	
	{
		_smkey = "d_sm_" + str _x;
		_smpos = _smkey call d_fnc_smmapos;
		//select sidemission if within max distance from main target and not previously selected
		if ((d_cur_tgt_pos distance2D (_smpos # 0) < d_sm_max_distance_from_mt) && (d_sm_selected findIf { _x == _smkey } == -1)) exitWith {
			//add to selected array
			d_sm_selected pushBack _smkey;
			_cur_sm_idx = _x;
		};
	} forEach d_sm_array;
	
	if ((count d_sm_selected) == _sm_selected_size_at_start) then {
		//unable to find a sidemission that fits our criteria so just set cleared to true
		d_sm_nearby_cleared = true;
	};
	
} else {
	_cur_sm_idx = d_side_missions_random # d_current_mission_counter;
	d_current_mission_counter = d_current_mission_counter + 1;
};

__TRACE_1("","_cur_sm_idx")

//_cur_sm_idx = _this select 0;
//_cur_sm_idx = 50042;

if (!isNil "_cur_sm_idx") then {
	[_cur_sm_idx] spawn d_fnc_hcsmexec;
};
