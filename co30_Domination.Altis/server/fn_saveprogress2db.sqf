// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_saveprogress2db.sqf"
#include "..\x_setup.sqf"

if (!isNil "d_saveprogess2db_inprogress") exitWith {};

d_saveprogess2db_inprogress = true;

params ["_sname", "_sender"];

__TRACE_2("","_sname","_sender")

_sname = toLower _sname;

#ifndef __TT__
d_bonus_vecs_db = d_bonus_vecs_db - [objNull];
private _bonus_vecs_db = d_bonus_vecs_db apply {typeOf _x};
#else
d_bonus_vecs_db_w = d_bonus_vecs_db_w - [objNull];
private _bonus_vecs_db_w = d_bonus_vecs_db_w apply {typeOf _x};
d_bonus_vecs_db_e = d_bonus_vecs_db_e - [objNull];
private _bonus_vecs_db_e = d_bonus_vecs_db_e apply {typeOf _x};
#endif

if (isNil "d_maintargets_list") then {
	d_maintargets_list = [];
};

private _maintargets_list =+ d_maintargets_list;

#ifndef __TT__
if (d_current_target_index != -1 && {!(d_current_target_index in d_resolved_targets) && {!(d_current_target_index in d_maintargets_list)}}) then {
	_maintargets_list = [d_current_target_index] + _maintargets_list;
};
#else
if (d_current_target_index != -1 && {!(d_current_target_index in d_maintargets_list)}) then {
	if (d_resolved_targets findIf {_x # 0 == d_current_target_index} == -1) then {
		_maintargets_list = [d_current_target_index] + _maintargets_list;
	};
};
#endif

private _current_mission_counter = if (d_cur_sm_idx == -1) then {
	d_current_mission_counter
} else {
	d_current_mission_counter - 1
};
if (_current_mission_counter < 0) then {_current_mission_counter = 0};

__TRACE_1("","_maintargets_list")
__TRACE_1("","d_current_target_index")
__TRACE_1("","d_maintargets_list")
__TRACE_1("","d_resolved_targets")

if (isNil "d_db_savegames") then {
	d_db_savegames = [];
};

if !(_sname in d_db_savegames) then {
	d_db_savegames pushBack _sname;
	publicVariable "d_db_savegames";
	private _recapgone = [];
#ifndef __INTERCEPTDB__
	if (!d_tt_ver) then {
		"extdb3" callExtension format ["1:dom:missionInsert:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14", _sname, d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db, tolower worldname, tolower (worldName + _sname), tolower (worldName + _sname + briefingname)];
	} else {
		"extdb3" callExtension format ["1:dom:missionttInsert:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:%18:%19:%20", _sname, d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db_w, _bonus_vecs_db_e, tolower worldname, d_points_blufor, d_points_opfor, d_kill_points_blufor, d_kill_points_opfor, d_points_array, tolower (worldName + _sname), tolower (worldName + _sname + briefingname)];
	};
#else
	if (d_interceptdb) then {
		private "_iquery";
		if (!d_tt_ver) then {
			_iquery = ["missionInsert", [_sname, d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db, tolower worldname, tolower (worldName + _sname), tolower (worldName + _sname + briefingname)]];
		} else {
			_iquery = ["missionttInsert", [_sname, d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db_w, _bonus_vecs_db_e, tolower worldname, d_points_blufor, d_points_opfor, d_kill_points_blufor, d_kill_points_opfor, d_points_array, tolower (worldName + _sname), tolower (worldName + _sname + briefingname)]];
		};
		_iquery call dsi_fnc_queryconfigasync;
	};
#endif
} else {
	private _recapgone = [];
#ifndef __INTERCEPTDB__
	if (!d_tt_ver) then {
		"extdb3" callExtension format ["1:dom:missionUpdate:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11", d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db, tolower (worldName + _sname)];
	} else {
		"extdb3" callExtension format ["1:dom:missionTTUpdate:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17", d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db_w, _bonus_vecs_db_e, d_points_blufor, d_points_opfor, d_kill_points_blufor, d_kill_points_opfor, d_points_array, tolower (worldName + _sname)];
	};
#else
	if (d_interceptdb) then {
		private "_iquery";
		if (!d_tt_ver) then {
			_iquery = ["missionUpdate", [d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db, tolower (worldName + _sname)]];
		} else {
			_iquery = ["missionTTUpdate", [d_maintargets, _maintargets_list, d_current_target_index, d_cur_sm_idx, d_resolved_targets, _recapgone, d_side_missions_random, _current_mission_counter, d_searchintel, _bonus_vecs_db_w, _bonus_vecs_db_e, d_points_blufor, d_points_opfor, d_kill_points_blufor, d_kill_points_opfor, d_points_array, tolower (worldName + _sname)]];
		};
		_iquery call dsi_fnc_queryconfigasync;
	};
#endif
};

if (!isNull _sender) then {
	[format [localize "STR_DOM_MISSIONSTRING_1749", _sname], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", _sender];
};

d_saveprogess2db_inprogress = nil;