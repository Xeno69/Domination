// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[8166.81,17018.4,0], [8130.84,17010.5,0], [8121.2,16991.2,0], [8140.73,17030,0], [8149.6,17049.7,0], [8162.93,16994.6,0], [8154.33,16974.8,0]]; // index: 29,   Tank depot at Cabo Juventudo
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1810";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_767";
};

if (isServer) then {
	[d_x_sm_pos, [114.952,114.952,114.952,114.952,292.444,292.444]] spawn d_fnc_sidetanks;
};
