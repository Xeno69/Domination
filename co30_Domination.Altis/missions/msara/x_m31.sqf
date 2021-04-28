// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[17563.9,9550.78,0], [17589,9571.56,0], [17572.9,9567.49,0], [17529.4,9573.4,0], [17563.9,9533.05,0], [17527.6,9532.41,0], [17600.9,9551.71,0]]; // index: 31,   Tank depot near Everon
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1810";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_767";
};

if (isServer) then {
	[d_x_sm_pos, [178.861, 178.861, 178.861, 0, 0, 273.398]] spawn d_fnc_sidetanks;
};
