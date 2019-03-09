// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_targetclearm.sqf"
#include "..\..\x_setup.sqf"

d_target_clear = true; publicVariable "d_target_clear";

{
	private _mname = _x getVariable "d_trigmarker";
	if (!isNil "_mname") then {
		deleteMarker _mname;
	};
	deleteVehicle _x;
} forEach d_mt_marker_triggers;

d_mt_marker_triggers = [];

#ifndef __TT__
("d_" + d_cur_tgt_name + "_dommtm") setMarkerAlpha d_e_marker_color_alpha;

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
("d_" + d_cur_tgt_name + "_dommtm") setMarkerColor _mtcol;
("d_" + d_cur_tgt_name + "_dommtm") setMarkerAlpha d_e_marker_color_alpha;
if (d_bonus_vec_type in [2, 3]) then {
	["",""] remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
};
d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","Captured",["1","",d_cur_tgt_name,[d_cur_tgt_name]],"SIDE"];
d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","Captured",["1","",d_cur_tgt_name,[d_cur_tgt_name]],"SIDE"];
#endif
