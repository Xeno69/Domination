// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m5.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[10269.6,7353.71,0], [10268.4,7313.75,0]];  // index: 5,   King of Sedia at hotel in Vallejo
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1636";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_1637";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	private _sm_vec = _newgroup createUnit [d_functionary, _poss, [], 0, "NONE"]
	[_sm_vec] joinSilent _newgroup;
	_newgroup deleteGroupWhenEmpty true;
	_sm_vec call d_fnc_removenvgoggles_fak;
	_sm_vec call d_fnc_addkillednormal;
	d_x_sm_rem_ar pushBack _sm_vec;
	private _leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "PATH";
	private _nbuilding = nearestBuilding _sm_vec;
	private _no_list = [19,27,39,41,55,57,59,67,81,94,98,99,120,121,131,142,144,156,159,160,162,182,183,193,204,206,220,222,233];
	_sm_vec setPos (_nbuilding buildingPos (selectRandom _no_list));
	sleep 2.123;
	private _grps = ["specops", 1, "allmen", 1, _poss, 0] call d_fnc_CreateInf;
	{
		{
			_x setPos (_nbuilding buildingPos (selectRandom _no_list));
			_x disableAI "PATH";
		} forEach (units _x);
		sleep 0.01;
	} forEach _grps;
	sleep 2.222;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos # 1, 1, 80, true] spawn d_fnc_CreateArmor;
	if (d_with_dynsim == 0) then {
		_sm_vec enableDynamicSimulation true;
	};
};
