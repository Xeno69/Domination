// by Xeno
//#define __DEBUG___
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_36" call d_fnc_smmapos; // index: 36,   Boat making facility near Savaka
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1687";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1502";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_land_factory, _poss, [], 0, "NONE"];
	_vec call d_fnc_addKilledEHSM;
	_vec setDir 270;
	_vec setPos _poss;
	_vec setVectorUp [0,0,1];
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.132;
	["specops", 1, "allmen", 1, _poss, 50, true] spawn d_fnc_CreateInf;
	sleep 2.234;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 60, true] spawn d_fnc_CreateArmor;
};
