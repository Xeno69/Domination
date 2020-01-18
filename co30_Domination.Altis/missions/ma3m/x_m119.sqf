//#define __DEBUG__
#define THIS_FILE "x_m119.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_119" call d_fnc_smmapos; //  Destroy cargo box
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_SIDESTRING_1015";
	d_current_mission_resolved_text = localize "STR_DOM_SIDESTRING_1016";
};

if (isServer) then {
	d_x_sm_pos params ["_poss"];
	_vec = createVehicle [d_sm_ammotrucktype, _poss, [], 0, "NONE"];
	_vec setDir (markerDir "d_sm_119");
	_vec setPos _poss;
	_vec lock true;
    _vec call d_fnc_equipVehicle;
    _vec setDamage 0;
	_vec call d_fnc_addkillednormal;
	//_vec addEventHandler ["killed", {d_sm_winner = 2; d_sm_resolved = true}];
	_vec addEventHandler ["HandleDamage",{(_this select 2) * 3}];
	d_x_sm_vec_rem_ar pushBack _vec;
	sleep 2.123;
	["specops", 2, "basic", 3, _poss, 150,true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["DSHKM",1,"AGS",0,"",0,[_poss, 100, 2] call d_fnc_GetRanPointCircle,1,100,false] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["DSHKM",0,"AGS",1,"",0,[_poss, 100, 2] call d_fnc_GetRanPointCircle,1,100,false] spawn d_fnc_CreateArmor;
	sleep 2.123;
    [selectRandom ["uaz_grenade","uaz_mg"],1,selectRandom ["brdm","tank","bmp"],1,"shilka",selectRandom [0,1],[_poss, 100] call d_fnc_GetRanPointCircleOuter,1,300,true] spawn d_fnc_CreateArmor;
};
