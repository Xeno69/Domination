// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m19.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[10841.9,2695.45,0]]; // train in Elektrozavodsk
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_747";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_748";
};

if (isServer) then {
	private _train1 = "Land_loco_742_blue" createVehicle [10841.9,2695.45,0];
	_train1 setDir 20.7776;
	_train1 setPos [10841.9,2695.45,0];
	private _train2 = "Land_wagon_box" createVehicle [10837.3,2683.54,0];
	_train2 setDir 20.7776;
	_train2 setPos [10837.3,2683.54,0];
	private _train3 = "Land_wagon_flat" createVehicle [10832.1,2669.75,0];
	_train3 setDir 20.7776;
	_train3 setPos [10832.1,2669.75,0];
	private _train4 = "Land_wagon_tanker" createVehicle [10826.8,2655.96,0];
	_train4 setDir 20.7776;
	_train4 setPos [10826.8,2655.96,0];
	[d_x_sm_pos # 0, [_train1, _train2, _train3, _train4]] spawn d_fnc_sidetrains;
};