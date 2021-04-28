// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[10245.7,15784.9,0],[10276.6,15813.6,0],[10269.1,15751,0],[10287.4,15719.9,0]]; // index: 28,   Radio Tower at bunker near Mataredo
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1815";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_727";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_telek1", _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	private _pos_other = d_x_sm_pos # 1;
	["aa", 1, "tracked_apc", 0, "tank", 0, _pos_other, 1, 0, false] spawn d_fnc_CreateArmor;
	sleep 2.333;
	["specops", 1, "allmen", 2, d_x_sm_pos # 2, 80, true] spawn d_fnc_CreateInf;
	sleep 2.333;
	["aa", 0, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 3, 1, 100, true] spawn d_fnc_CreateArmor;
};
