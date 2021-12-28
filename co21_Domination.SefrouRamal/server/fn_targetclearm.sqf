// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("Start")

d_target_clear = true; publicVariable "d_target_clear";

private _mname = "d_" + d_cur_tgt_name + "_dommtm";
#ifndef __TT__
_mname setMarkerAlpha d_e_marker_color_alpha;

if (d_bonus_vec_type in [2, 3]) then {
	"" remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
};
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Captured",["1","",d_cur_tgt_name,[d_cur_tgt_name]],d_kbtel_chan];
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
_mname setMarkerColorLocal _mtcol;
_mname setMarkerAlpha d_e_marker_color_alpha;
if (d_bonus_vec_type in [2, 3]) then {
	["",""] remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
};
d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","Captured",["1","",d_cur_tgt_name,[d_cur_tgt_name]],"SIDE"];
d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","Captured",["1","",d_cur_tgt_name,[d_cur_tgt_name]],"SIDE"];
#endif

__TRACE("Start")
