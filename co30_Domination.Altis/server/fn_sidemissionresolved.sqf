// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sidemissionresolved.sqf"
#include "..\x_setup.sqf"

__TRACE("In fn_sidemissionresolved")

0 spawn d_fnc_clearsidemission;

(d_cur_sm_idx + 1) call d_fnc_d_sm_mar;

d_cur_sm_idx = -1;
publicVariable "d_cur_sm_idx";

__TRACE_2("","d_sm_winner","d_current_sm_bonus_vec")

if (d_sm_winner > 0) then {
	__TRACE("Calling getbonus")
	if (d_without_sm_bonus == 1) then {
		d_sm_bonus_wait = true;
		[d_sm_winner, d_current_sm_bonus_vec] spawn d_fnc_getbonus;
	} else {
		[d_sm_winner, "FAKE_VEC"] remoteExecCall ["d_fnc_sm_res_client", [0, -2] select isDedicated];
#ifndef __TT__
		d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MissionAccomplished",d_kbtel_chan];
#else
		if (d_sm_winner == 1) then {
			d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionFailure","SIDE"];
			d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionAccomplished","SIDE"];
		} else {
			if (d_sm_winner == 2) then {
				d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionAccomplished","SIDE"];
				d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionFailure","SIDE"];
			} else {
				if (d_sm_winner == 123) then {
					d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionAccomplished","SIDE"];
					d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionAccomplished","SIDE"];
				} else {
					d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionFailure","SIDE"];
					d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionFailure","SIDE"];
				};
			};
		};
#endif
	};
} else {
	if (d_sm_winner in [-1,-2,-300,-400,-500,-600,-700,-878,-900,-1000,-1100,-1200]) then {
		__TRACE("Calling res client because winner less than 0")
		[d_sm_winner, ""] remoteExecCall ["d_fnc_sm_res_client", [0, -2] select isDedicated];
#ifndef __TT__
		[35] call d_fnc_DoKBMsg;
#else
		[36] call d_fnc_DoKBMsg;
#endif
		if !(isServer && {!isDedicated}) then {d_sm_winner = 0};
	};
};
if (d_database_found && {d_db_auto_save}) then {
	if (!isNil "d_sm_bonus_wait") then {
		0 spawn {
			scriptName "spawn saveprogress2db sidemissionresolved";
			while {true} do {
				sleep 0.1;
				if (isNil "d_sm_bonus_wait") exitWith {};
			};
			["d_dom_db_autosave", objNull] call d_fnc_saveprogress2db;
		};
	} else {
		["d_dom_db_autosave", objNull] call d_fnc_saveprogress2db;
	};
};
__TRACE("End fn_sidemissionresolved")