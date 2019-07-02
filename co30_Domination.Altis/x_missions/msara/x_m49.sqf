// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m49.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[16551.3,12925.3,0]]; // index: 49,   Officer near Benoma
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1800";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_792";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 120, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	private _fortress = createVehicle [d_sm_fortress, _poss, [], 0, "NONE"];
	//_fortress setDir 290.789;
	_fortress setPos _poss;
	d_x_sm_vec_rem_ar pushBack _fortress;
	sleep 2.123;
	private _ogroup = [d_side_enemy] call d_fnc_creategroup;
	private _sm_vec = _ogroup createUnit [d_soldier_officer, _poss, [], 0, "NONE"];
	[_sm_vec] joinSilent _ogroup;
	_ogroup deleteGroupWhenEmpty true;
	_sm_vec call d_fnc_removenvgoggles_fak;
	_sm_vec call d_fnc_addkillednormal;
	d_x_sm_rem_ar pushBack _sm_vec;
	sleep 2.123;
	private _bpos = getPosATL _fortress;
	_bpos set [2, 1];
	_sm_vec setFormDir ((direction _fortress) + 90);
	_sm_vec setPos _bpos;
	sleep 2.123;
	["specops", 3, "allmen", 2, _poss, 100, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	private _leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setBehaviour "AWARE";
	_leadero disableAI "PATH";
	if (d_with_dynsim == 0) then {
		_sm_vec enableDynamicSimulation true;
	};
};