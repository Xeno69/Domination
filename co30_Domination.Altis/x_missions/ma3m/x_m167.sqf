//#define __DEBUG__
#define THIS_FILE "x_m167.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_167" call d_fnc_smmapos; //  sabotage submarine
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_SIDESTRING_1062A";
	d_current_mission_resolved_text = localize "STR_DOM_SIDESTRING_1063A";
};

if (isServer) then {
	d_x_sm_pos params ["_poss", "_pos_other", "_pos_other2"];
	private _helper = createVehicle [d_HeliHEmpty, _poss, [],0, "NONE"];
	private _vehicle = d_sm_submarine2 createVehicle [getPosASL _helper # 0, getPosASL _helper # 1, (random (getPosASL _helper # 2))];
	_vehicle setDir markerDir "d_sm_167";
	deleteVehicle _helper;
	_vehicle addEventHandler ["HandleDamage", {0}];
	_vehicle remoteExecCall ["d_fnc_sabotage_sm", [0, -2] select isDedicated];
	sleep 2.123;
	["specops", 2, "basic", 3, _pos_other, 150,true] spawn d_fnc_CreateInf;
	sleep 2.123;
	["DSHKM",1,"AGS",0,"DSHKM",0,[_pos_other, 50] call d_fnc_GetRanPointCircleOuter,1,100,false] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["DSHKM",0,"AGS",1,"DSHKM",0,[_pos_other, 50] call d_fnc_GetRanPointCircleOuter,1,100,false] spawn d_fnc_CreateArmor;
	sleep 2.123;
	[selectRandom ["uaz_grenade","uaz_mg"],1,selectRandom ["brdm","tank","bmp"],1,"shilka",1,_pos_other2,1,300,true] spawn d_fnc_CreateArmor;
};

