// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_14" call d_fnc_smmapos; // index: 14,   Radio tower south of Orekastro
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1815";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_727";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_illum_tower, _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 300, true] spawn d_fnc_CreateArmor;
	sleep 2.333;
	["specops", 1, "allmen", 2, _poss, 200, true] spawn d_fnc_CreateInf;
};
