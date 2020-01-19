// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_target_clear.sqf"
#include "..\x_setup.sqf"
if (!isServer) exitWith{};

__TRACE_1("","_this")

sleep 1.123;

call d_fnc_xdelct;
d_mt_done = true;

sleep 0.01;

if (!d_side_main_done) then {
	if (alive d_fixor_var) then {
		sleep 30 + random 30;
		if (alive d_fixor_var) then {
			d_fixor_var setDamage 1;
		};	
	};
	d_side_main_done = true;
};

private _cur_tgt_name = d_cur_tgt_name;

d_old_target_pos =+ d_cur_tgt_pos;
d_old_radius = d_cur_target_radius;

if (!isNil "d_parahhandle" && {!isNull d_parahhandle}) then {
	terminate d_parahhandle;
};

[d_old_target_pos, d_mttarget_radius_patrol] spawn d_fnc_umadel;

#ifndef __TT__
d_resolved_targets pushBack d_current_target_index;
publicVariable "d_resolved_targets";
#else
private _addpblufor = 0;
private _addpopfor = 0;
private _pdist = d_old_radius + 200;
{
	_x addScore (d_tt_points # 0);
	switch (side (group _x)) do {
		case blufor: {_addpblufor = _addpblufor + (d_tt_points # 0)};
		case opfor: {_addpopfor = _addpopfor + (d_tt_points # 0)};
	};
} forEach ((allPlayers - entities "HeadlessClient_F") select {alive _x && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false]) && {_x distance2D d_old_target_pos < _pdist}}}});

d_kill_points_blufor = d_kill_points_blufor + _addpblufor;
d_kill_points_opfor = d_kill_points_opfor + _addpopfor;

if (d_kill_points_blufor > d_kill_points_opfor) then {
	d_mt_winner = 1;
	d_points_blufor = d_points_blufor + (d_tt_points # 0);
} else {
	if (d_kill_points_opfor > d_kill_points_blufor) then {
		d_mt_winner = 2;
		d_points_opfor = d_points_opfor + (d_tt_points # 0);
	} else {
		if (d_kill_points_opfor == d_kill_points_blufor) then {
			d_mt_winner = 3;
			d_points_blufor = d_points_blufor + (d_tt_points # 1);
			d_points_opfor = d_points_opfor + (d_tt_points # 1);
		};
	};
};
publicVariable "d_mt_winner";
d_points_array = [d_points_blufor, d_points_opfor, d_kill_points_blufor, d_kill_points_opfor]; 
publicVariable "d_points_array";

d_resolved_targets pushBack [d_current_target_index, d_mt_winner];
publicVariable "d_resolved_targets";
sleep 0.5;
d_public_points = false;
__TRACE_1("","d_mt_winner")
#endif
d_num_barracks_tt = 0;
publicVariable "d_num_barracks_tt";
d_num_barracks_objs = 0;
publicVariable "d_num_barracks_objs";

call d_fnc_dodelintelu;

sleep 0.5;

if !(d_maintargets_list isEqualTo []) then {
	if (d_bonus_vec_type in [0, 1]) then {
		0 spawn d_fnc_gettargetbonus;
	} else {
		call d_fnc_targetclearm;
	};
} else {
	d_target_clear = true; publicVariable "d_target_clear";
#ifndef __TT__
	("d_" + d_cur_tgt_name + "_dommtm") setMarkerAlpha d_e_marker_color_alpha;
	"" remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
	d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "Captured2", ["1", "", _cur_tgt_name, [_cur_tgt_name]],d_kbtel_chan];
#else
	private _mtcol = if (d_mt_winner == 1) then {
		"ColorBlue"
	} else {
		if (d_mt_winner == 2) then {
			"ColorRed"
		} else {
			"ColorGreen"
		};
	};
	("d_" + _cur_tgt_name + "_dommtm") setMarkerColor _mtcol;
	("d_" + d_cur_tgt_name + "_dommtm") setMarkerAlpha d_e_marker_color_alpha;
	["", ""] remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
	d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","Captured2",["1","",_cur_tgt_name,[_cur_tgt_name]],"SIDE"];
	d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","Captured2",["1","",_cur_tgt_name,[_cur_tgt_name]],"SIDE"];
#endif
};

sleep 2.123;

if !(d_maintargets_list isEqualTo []) then {
	[1, d_current_target_index] call d_fnc_doexechcf;
};

sleep 3.321;

if (d_WithJumpFlags == 1 && {!(d_maintargets_list isEqualTo [])}) then {0 spawn d_fnc_createjumpflag};

_del_camps_stuff = [];
{
	private _flag = _x getVariable "d_FLAG";
	deleteMarker (_x getVariable "d_camp_mar");
	_del_camps_stuff pushBack _x;
	if (!isNull _flag) then {
		_del_camps_stuff pushBack _flag;
	};
} forEach d_currentcamps;
d_currentcamps = [];
publicVariable "d_currentcamps";
#ifdef __TT__
d_campscaptured_w = 0;
publicVariable "d_campscaptured_w";
d_campscaptured_e = 0;
publicVariable "d_campscaptured_e";
#endif

#ifndef __TT__
if (d_enable_civs == 1) then {
	//cleanup civ modules presencesafespot
	{
		deleteVehicle _x;
	} forEach d_cur_tgt_civ_modules_presencesafespot;
	d_cur_tgt_civ_modules_presencesafespot = [];

	//cleanup civ modules presenceunit
	{
		deleteVehicle _x;
	} forEach d_cur_tgt_civ_modules_presenceunit;
	d_cur_tgt_civ_modules_presenceunit = [];

	//cleanup civ modules presence
	{
		deleteVehicle _x;
	} forEach d_cur_tgt_civ_modules_presence;
	d_cur_tgt_civ_modules_presence = [];

	//cleanup civ units
	{
		//diag_log [diag_frameno, diag_ticktime, time, format ["Deleting civ: %1", _x]];
		deleteVehicle _x;
	} forEach d_cur_tgt_civ_units;
	d_cur_tgt_civ_units = [];
};
#endif

sleep 0.245;

[d_old_target_pos, d_old_radius, _del_camps_stuff] execFSM "fsms\fn_DeleteEmpty.fsm";

0 spawn d_fnc_rebbuil;

__TRACE_1("","d_maintargets_list")

if !(d_maintargets_list isEqualTo []) then {
	if (d_MHQDisableNearMT != 0) then {
		{
			private _fux = _x getVariable "d_vecfuelmhq";
			if (fuel _x < _fux) then {
				[_x, _fux] remoteExecCall ["setFuel", _x];
			};
			_x setVariable ["d_vecfuelmhq", nil, true];
		} forEach (vehicles select {alive _x && {!isNil {_x getVariable "d_vecfuelmhq"}}});
	};
	sleep 10;
#ifdef __TT__
	d_kill_points_blufor = 0;
	d_kill_points_opfor = 0;
	d_public_points = true;
#endif
	if (d_database_found && {d_db_auto_save}) then {
		["d_dom_db_autosave", objNull] call d_fnc_saveprogress2db;
	};
	0 spawn d_fnc_createnexttarget;
} else {
	if (d_tt_ver) then {
		if (d_database_found && {d_db_auto_save}) then {
#ifndef __INTERCEPTDB__
			"extdb3" callExtension format ["1:dom:missionsaveDelTT:%1", tolower (worldName + "d_dom_db_autosave" + briefingname)];
#else
			if (d_interceptdb) then {
				["missionsaveDelTT", [tolower (worldName + "d_dom_db_autosave" + briefingname)]] call dsi_fnc_queryconfigasync;
			};
#endif
		};
		d_the_end = true; publicVariable "d_the_end";
		0 spawn d_fnc_DomEnd;
	} else {
		if (d_database_found && {d_db_auto_save}) then {
#ifndef __INTERCEPTDB__
			"extdb3" callExtension format ["1:dom:missionsaveDel:%1", tolower (worldName + "d_dom_db_autosave" + briefingname)];
#else
			if (d_interceptdb) then {
				["missionsaveDel", [tolower (worldName + "d_dom_db_autosave" + briefingname)]] call dsi_fnc_queryconfigasync;
			};
#endif
		};
		d_the_end = true; publicVariable "d_the_end";
		0 spawn d_fnc_DomEnd;
	};
};

__TRACE("Done")