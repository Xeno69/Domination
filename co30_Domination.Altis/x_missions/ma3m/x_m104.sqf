//#define __DEBUG__
#define THIS_FILE "x_m104.sqf"
#include "x_setup.sqf"
private ["_vehicle","_poss","_camo","_camotype"];

GVAR(x_sm_pos) = QGVAR(sm_104) call FUNC(smmapos); // evac a tank
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (!isDedicated) then {
	GVAR(cur_sm_txt) = (localize "STR_DOM_SIDESTRING_1051");
	GVAR(cur_sm_res_txt) = (localize "STR_DOM_SIDESTRING_1052");
};

if (isServer) then {
	__PossAndOther
	_vehicle = objNull;
	_vehicle = createVehicle [GVAR(sm_car), _poss, [], 0, "NONE"];
	_vehicle setDir markerDir QGVAR(sm_104);
	_vehicle setPos _poss;
	_vehicle setVariable [QGVAR(paint), true, true];
	_vehicle setHitPointDamage ["HitHull",0.5];
	_vehicle setHitPointDamage ["HitGun",1];
	_vehicle setHitPointDamage ["HitRTrack",1];
	_vehicle setHitPointDamage ["HitEngine",1];
    addToRemainsCollector [_vehicle];
	_vehicle call FUNC(equipVehicle);
    private _owngroup = [civilian] call FUNC(creategroup);
    private _crew1 = _owngroup createUnit [selectRandom GVAR(sm_crew), _poss, [], random 6, "NONE"];
    private _crew2 = _owngroup createUnit [selectRandom GVAR(sm_crew), _poss, [], random 6, "NONE"];
	private _crew3 = _owngroup createUnit [selectRandom GVAR(sm_crew), _poss, [], random 6, "NONE"];
   {GVAR(x_sm_rem_ar) pushback _x; _x setDamage 1} forEach [_crew1,_crew2,_crew3];
    _vehicle remoteExecCall ["d_fnc_initvec", [0, -2] select isDedicated];
	[_vehicle,"land","evac"] spawn FUNC(sidesteal);	
    private _pos_other2 = GVAR(x_sm_pos) # 2;
    ["specops", 2, "basic", 3, _pos_other, 150,true] spawn FUNC(CreateInf);
    sleep 2.123;
    ["DSHKM",1,"AGS",0,"DSHKM",0,[_pos_other, 50] call FUNC(GetRanPointCircleOuter),1,100,false] spawn FUNC(CreateArmor);
    sleep 2.123;
    ["DSHKM",0,"AGS",1,"DSHKM",0,[_pos_other, 50] call FUNC(GetRanPointCircleOuter),1,100,false] spawn FUNC(CreateArmor);
    sleep 2.123;
    [selectRandom ["uaz_grenade","uaz_mg"],1,selectRandom ["brdm","tank","bmp"],1,"shilka",1,_pos_other2,1,300,true] spawn FUNC(CreateArmor);	
};