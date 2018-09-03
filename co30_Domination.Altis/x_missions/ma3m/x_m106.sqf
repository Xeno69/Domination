//#define __DEBUG__
#define THIS_FILE "x_m106.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_106" call d_fnc_smmapos; // steal submarine
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_SIDESTRING_1053";
	d_current_mission_resolved_text = localize "STR_DOM_SIDESTRING_1054";
};

if (call d_fnc_checkSHC) then {
	d_x_sm_pos params ["_poss", "_pos_other", "_pos_other2"];
	private _vehicle = createVehicle [d_sm_submarine, _poss, [], 0, "NONE"];
	_vehicle setDir markerDir "d_sm_106";
	_vehicle setPos _poss;
	_vehicle allowDamage false;
	_vehicle spawn {sleep 10;_this allowDamage true};	
    addToRemainsCollector [_vehicle];
    _vehicle call d_fnc_equipVehicle;
    _vehicle remoteExecCall ["d_fnc_initvec", [0, -2] select isDedicated];
	[_vehicle,"sea",""] spawn d_fnc_sidesteal;
	_vehicle setDamage 0;
    sleep 2.123;
    ["specops", 2, "basic", 3, _pos_other, 150,true] spawn d_fnc_CreateInf;
    sleep 2.123;
    ["DSHKM",1,"AGS",0,"DSHKM",0,[_pos_other, 50] call d_fnc_GetRanPointCircleOuter,1,100,false] spawn d_fnc_CreateArmor;
    sleep 2.123;
    ["DSHKM",0,"AGS",1,"DSHKM",0,[_pos_other, 50] call d_fnc_GetRanPointCircleOuter,1,100,false] spawn d_fnc_CreateArmor;
    sleep 2.123;
    [selectRandom ["uaz_grenade","uaz_mg"],1,selectRandom ["brdm","tank","bmp"],1,"shilka",1,_pos_other2,1,300,true] spawn d_fnc_CreateArmor;
};
