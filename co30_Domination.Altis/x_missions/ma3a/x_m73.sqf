// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m73.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_73" call d_fnc_smmapos;
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1807";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_750";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss"];
	private _vec = createVehicle [d_sm_plane, _poss, [], 0, "NONE"];
	_vec setDir (markerDir "d_sm_73");
	_vec setPos _poss;
	sleep 2.123;
	["specops", 3, "allmen", 1, _poss, 50, true] spawn d_fnc_CreateInf;
	sleep 2.221;
	["aa", 2, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 1, 1, 60, true] spawn d_fnc_CreateArmor;
	[_vec] spawn d_fnc_sidesteal;
	_vec addMPEventHandler ["MPKilled", {if (isServer) then {[_this select 0] call d_fnc_sidempkilled}}];
	_vec setDamage 0;
};
