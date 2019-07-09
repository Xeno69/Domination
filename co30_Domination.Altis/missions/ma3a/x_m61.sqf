// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m61.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_61" call d_fnc_smmapos; // index:61 steal Ifrit GMG prototype, At the Mine South of Charkia, array 2 and 3 = infantry and armor positions
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1819";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1551";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_HunterGMG, _poss, [], 0, "NONE"];
	_vec setDir  markerDir "d_sm_61";
	_vec setPos _poss;
	sleep 2.123;
	["specops", 4, "allmen", 4, d_x_sm_pos # 1, 150, true] spawn d_fnc_CreateInf;
	sleep 2.321;
	["aa", 3, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 2, 1, 200, true] spawn d_fnc_CreateArmor;
	[_vec] spawn d_fnc_sidesteal;
	[_vec, "d_sidekill"] call d_fnc_setekmode;
	_vec setDamage 0;
};
