// by Xeno
//#define __DEBUG__
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_2" call d_fnc_smmapos; //  steal plane prototype, Rasman, second array position armor
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1807";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_750";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_plane, _poss, [], 0, "NONE"];
	_vec setDir (markerDir "d_sm_2");
	_vec setPos _poss;
	sleep 2.123;
	["specops", 1, "allmen", 1, _poss, 300, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 400, true] spawn d_fnc_CreateArmor;
	[_vec] spawn d_fnc_sidesteal;
	[_vec, 6] call d_fnc_setekmode;
	_vec setDamage 0;
};