// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m12.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_12" call d_fnc_smmapos; // Officer at Tsoukalia
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1813";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_729";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 1, 1, 0] spawn d_fnc_CreateArmor;
	sleep 2.123;
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _fortress = createVehicle [d_sm_fortress, _poss, [], 0, "NONE"];
	_fortress setDir (markerDir "d_sm_12");
	_fortress setPos _poss;
	d_x_sm_vec_rem_ar pushBack _fortress;
	private _sm_vec = _newgroup createUnit [d_soldier_officer, _poss, [], 0, "NONE"];
	[_sm_vec] joinSilent _newgroup;
	_newgroup deleteGroupWhenEmpty true;
	_sm_vec call d_fnc_removenvgoggles_fak;
	_sm_vec call d_fnc_addkillednormal;
	d_x_sm_rem_ar pushBack _sm_vec;
	sleep 2.123;
	private _bpos = getPosATL _fortress;
	_bpos set [2, 1];
	_sm_vec setDir ((direction _fortress) + 90);
	_sm_vec setPos _bpos;
	sleep 2.123;
	private _leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "PATH";
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 0] spawn d_fnc_CreateInf;
	if (d_with_dynsim == 0) then {
		[_sm_vec, 1] spawn d_fnc_enabledynsim;
	};
};
