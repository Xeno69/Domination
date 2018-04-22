// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m25.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = [[4726.85,15689,0],[4385.75,15825.4,0],[4415.64,15790.9,0],[4375.74,15790.8,0],[4392.87,15521.3,0],[4532.88,15304.8,0],[4585.08,15287.2,0],[4978.4,15466.1,0],[4855.92,15535.1,0],[4930.69,15514.1,0],[4956.34,15760.8,0],[4949.85,15827.9,0],[4964.33,16067,0],[4987.25,15717.1,0],[4395.8,15350.6,0],   [4574.74,15374.2,0],[4368.82,15737,0],[5044.83,15799.3,0],[4860.15,15679.2,0]]; // index: 25,   enemy officer on Isla del Vasal or Isla del Vida
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1813";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_729";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos _poss = x_sm_pos # ((floor random 14) + 1);
	//private _fortress = createVehicle [d_sm_fortress, _poss, [], 0, "NONE"];
	//_fortress setPos _poss;
	//d_x_sm_vec_rem_ar pushBack _fortress;
	//sleep 2.123;
	private _ogroup = [d_side_enemy] call d_fnc_creategroup;
	private _sm_vec = _ogroup createUnit [d_soldier_officer, _poss, [], 0, "NONE"];
	[_sm_vec] joinSilent _ogroup;
	_ogroup deleteGroupWhenEmpty true;
	_sm_vec call d_fnc_removenvgoggles_fak;
	_sm_vec call d_fnc_addkillednormal;
	d_x_sm_rem_ar pushBack _sm_vec;
	sleep 2.123;
	//private _bpos = getPosATL _fortress;
	//_bpos set [2, 1];
	//_sm_vec setFormDir ((direction _fortress) + 90);
	//_sm_vec setPos _bpos;
	private _leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup allowFleeing 0;
	_ogroup setbehaviour "AWARE";
	_leadero disableAI "PATH";
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 80, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 15, 1, 130, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 0, d_x_sm_pos # 15, 80, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 16, 1, 130, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 0, d_x_sm_pos # 16, 80, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 17, 1, 130, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 0, d_x_sm_pos # 17, 80, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["aa", 1, "tracked_apc", 1, "tank", 0, d_x_sm_pos # 18, 1, 130, true] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 1, "allmen", 0, d_x_sm_pos # 18, 80, true] spawn d_fnc_CreateInf;
	sleep 2.123;
	if (d_with_dynsim == 0) then {
		_sm_vec enableDynamicSimulation true;
	};
};
