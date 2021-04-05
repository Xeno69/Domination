// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_s_sm_up.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")
d_cur_sm_idx = _this # 0;
publicVariable "d_cur_sm_idx";

private _s1 = format ["d_XMISSIONM%1", d_cur_sm_idx + 1];
if (d_x_sm_type == "convoy") then {
	[_s1, d_x_sm_pos # 0, "ICON","ColorRed", [1, 1], localize "STR_DOM_MISSIONSTRING_708", 0, "hd_start"] call d_fnc_CreateMarkerGlobal;
	[_s1, "STR_DOM_MISSIONSTRING_708"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
	_s1 = format ["d_XMISSIONM2%1", d_cur_sm_idx + 1];
	[_s1, d_x_sm_pos # 1, "ICON","ColorRed", [1, 1], localize "STR_DOM_MISSIONSTRING_709", 0, "mil_pickup"] call d_fnc_CreateMarkerGlobal;
	[_s1, "STR_DOM_MISSIONSTRING_709"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
} else {
	
	if (d_x_sm_type == "deliver") then {
		[_s1, d_x_sm_pos # 0, "ICON","ColorRed", [1, 1], localize "STR_DOM_MISSIONSTRING_1702", 0, "hd_start"] call d_fnc_CreateMarkerGlobal;
		[_s1, "STR_DOM_MISSIONSTRING_1702"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
		_s1 = format ["d_XMISSIONM2%1", d_cur_sm_idx + 1];
		[_s1, d_x_sm_pos # 1, "ICON","ColorRed", [1, 1], localize "STR_DOM_MISSIONSTRING_1703", 0, "mil_pickup"] call d_fnc_CreateMarkerGlobal;
		[_s1, "STR_DOM_MISSIONSTRING_1703"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
	} else {
		[_s1, d_x_sm_pos # 0, "ICON", "ColorRed", [1, 1], localize "STR_DOM_MISSIONSTRING_707", 0, "hd_destroy"] call d_fnc_CreateMarkerGlobal;
		[_s1, "STR_DOM_MISSIONSTRING_707"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
	};
};
__TRACE("Calling getsidemissionclient")
[true] remoteExec ["d_fnc_getsidemissionclient", [0, -2] select isDedicated];
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "NewMission", d_kbtel_chan];
#else
d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2, "HQ_W", "NewMission", "SIDE"]; d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2, "HQ_E", "NewMission", "SIDE"];
#endif
d_sm_resolved = false;
d_sm_winner = 0;