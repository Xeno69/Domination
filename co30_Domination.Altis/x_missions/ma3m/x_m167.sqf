//#define __DEBUG__
#define THIS_FILE "x_m167.sqf"
#include "x_setup.sqf"
private ["_vehicle", "_poss"];

GVAR(x_sm_pos) = QGVAR(sm_167) call FUNC(smmapos); // sabotage submarine
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (!isDedicated) then {
	GVAR(cur_sm_txt) = (localize "STR_DOM_SIDESTRING_1062A");
	GVAR(cur_sm_res_txt) = (localize "STR_DOM_SIDESTRING_1063A");
};

if (isServer) then {
	__PossAndOther
	_pos_other2 = GVAR(x_sm_pos) # 2;
	private _helper = createVehicle [GVAR(HeliHEmpty), _poss, [],0, "NONE"];
	_vehicle = objNull;
	_vehicle = GVAR(sm_submarine2) createVehicle [getPosASL _helper # 0, getPosASL _helper # 1, (random (getPosASL _helper # 2))];
	_vehicle setDir markerDir QGVAR(sm_166);
	deleteVehicle _helper;
	_vehicle addEventHandler ["HandleDamage", {0}];
    _vehicle remoteExecCall ["d_fnc_sabotage", [0, -2] select isDedicated];
    sleep 2.123;
    ["specops", 2, "basic", 3, _pos_other, 150,true] spawn FUNC(CreateInf);
    sleep 2.123;
    ["DSHKM",1,"AGS",0,"DSHKM",0,[_pos_other, 50] call FUNC(GetRanPointCircleOuter),1,100,false] spawn FUNC(CreateArmor);
    sleep 2.123;
    ["DSHKM",0,"AGS",1,"DSHKM",0,[_pos_other, 50] call FUNC(GetRanPointCircleOuter),1,100,false] spawn FUNC(CreateArmor);
    sleep 2.123;
    [selectRandom ["uaz_grenade","uaz_mg"],1,selectRandom ["brdm","tank","bmp"],1,"shilka",1,_pos_other2,1,300,true] spawn FUNC(CreateArmor);
};

