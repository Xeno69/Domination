// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sidemissionresolved.sqf"
#include "..\..\x_setup.sqf"

__TRACE("In fn_sidemissionresolved")

if (isNil "d_HC_CLIENT_OBJ_OWNER") then {
	0 spawn d_fnc_clearsidemission;
} else {
	[0] remoteExecCall ["d_fnc_doexechcf", d_HC_CLIENT_OBJ_OWNER];
};
(d_cur_sm_idx + 1) remoteExecCall ["d_fnc_d_sm_mar", 2];

d_cur_sm_idx = -1; publicVariable "d_cur_sm_idx";
__TRACE_2("","d_sm_winner","d_current_sm_bonus_vec")
if (d_sm_winner > 0) then {
	__TRACE("Calling getbonus")
	[d_sm_winner, d_current_sm_bonus_vec] remoteExec ["d_fnc_getbonus", 2];
} else {
	if (d_sm_winner in [-1,-2,-300,-400,-500,-600,-700,-878,-900,-1000]) then {
		__TRACE("Calling res client because winner less than 0")
		[d_sm_winner, ""] remoteExecCall ["d_fnc_sm_res_client", [0, -2] select isDedicated];
#ifndef __TT__
		[35] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
		[36] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
		if !(isServer && {!isDedicated}) then {d_sm_winner = 0};
	};
};
if (d_database_found && {d_db_auto_save}) then {
	["d_dom_db_autosave", objNull] call d_fnc_saveprogress2db;
};
__TRACE("End fn_sidemissionresolved")