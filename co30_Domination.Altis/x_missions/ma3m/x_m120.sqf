//#define __DEBUG__
#define THIS_FILE "x_m120.sqf"
#include "x_setup.sqf"
private ["_vehicle", "_poss"];

GVAR(x_sm_pos) = QGVAR(sm_120) call FUNC(smmapos); //  Destroy cargo box
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (!isDedicated) then {
	GVAR(cur_sm_txt) = (localize "STR_DOM_SIDESTRING_1015");
	GVAR(cur_sm_res_txt) = (localize "STR_DOM_SIDESTRING_1016");
};

if (isServer) then {
	__Poss
	_vehicle = createVehicle [GVAR(sm_ammotrucktype), _poss, [], 0, "NONE"];
	_vehicle setDir (markerDir QGVAR(sm_120));
	_vehicle setPos _poss;
	_vehicle lock true;
    _vehicle call FUNC(equipVehicle);
    _vehicle setDamage 0;
	_vehicle addEventHandler ["killed", {GVAR(sm_winner) = 2; GVAR(sm_resolved) = true;}];
	_vehicle addEventHandler ["HandleDamage",{ ((_this select 2) * 3) }];
	__AddToExtraVec(_vehicle)
	sleep 2.123;
	["specops", 2, "basic", 3, _poss, 150,true] spawn FUNC(CreateInf);
	sleep 2.123;
	["DSHKM",1,"AGS",0,"",0,[_poss, 100] call FUNC(GetRanPointCircle),1,100,false] spawn FUNC(CreateArmor);
	sleep 2.123;
	["DSHKM",0,"AGS",1,"",0,[_poss, 100] call FUNC(GetRanPointCircle),1,100,false] spawn FUNC(CreateArmor);
	sleep 2.123;
    [selectRandom ["uaz_grenade","uaz_mg"],1,selectRandom ["brdm","tank","bmp"],1,"shilka",selectRandom [0,1],[_poss, 100] call FUNC(GetRanPointCircleOuter),1,300,true] spawn FUNC(CreateArmor);
};
