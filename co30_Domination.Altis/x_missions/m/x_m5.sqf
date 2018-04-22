// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m5.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[6979.58,2425.28,0]]; // train in Chernogorsk
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_809";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_748";
};

if (call d_fnc_checkSHC) then {
	#define __train1poss [6976.36,2422.87,0]
	private _train1 = createVehicle ["Land_loco_742_blue", __train1poss, [], 0, "NONE"];
	_train1 setDir 51.991;
	_train1 setPos __train1poss;
	#define __train2poss [6966.26,2415.06,0]
	private _train2 = createVehicle ["Land_wagon_box", __train2poss, [], 0, "NONE"];
	_train2 setDir 51.991;
	_train2 setPos __train2poss;
	#define __train3poss [6954.63,2405.98,0]
	private _train3 = createVehicle ["Land_wagon_flat", __train3poss, [], 0, "NONE"];
	_train3 setDir 51.991;
	_train3 setPos __train3poss;
	#define __train4poss [6943,2396.9,0]
	private _train4 = createVehicle ["Land_wagon_tanker", __train4poss, [], 0, "NONE"];
	_train4 setDir 51.991;
	_train4 setPos __train4poss;
	[d_x_sm_pos # 0, [_train1,_train2,_train3,_train4]] spawn d_fnc_sidetrains;
};