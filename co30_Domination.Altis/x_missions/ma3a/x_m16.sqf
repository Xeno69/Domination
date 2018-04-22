// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m16.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_16" call d_fnc_smmapos; // index: 16,   Radio tower mount Agia Stemma
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1815";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_727";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_illum_tower, _poss, [], 0, "NONE"];
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.22;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 1, 1, 110, true] spawn d_fnc_CreateArmor;
	sleep 2.333;
	["specops", 1, "allmen", 2, _poss, 250, true] spawn d_fnc_CreateInf;
};
