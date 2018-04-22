// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m5.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_5" call d_fnc_smmapos; //  destroy power generator in mine near Feruz-Abad
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1804";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_741";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle ["Land_Misc_Cargo2E_EP1", _poss, [], 0, "NONE"]; // d_sm_land_transformer
	_vec setDir (markerDir "d_sm_5");
	_vec setPos _poss;
	_vec call d_fnc_addKilledEHSM;
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 2, "allmen", 3, _poss, 200, true] spawn d_fnc_CreateInf;
	sleep 2.321;
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 350, true] spawn d_fnc_CreateArmor;
};