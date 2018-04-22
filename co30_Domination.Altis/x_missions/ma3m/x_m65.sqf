//#define __DEBUG__
#define THIS_FILE "x_m65.sqf"
#include "x_setup.sqf"
Private ["_poss","_pos_other"];

GVAR(x_sm_pos) = QGVAR(sm_65) call FUNC(smmapos); // clear naval mines
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (!isDedicated) then {
	GVAR(cur_sm_txt) = (localize "STR_DOM_SIDESTRING_1059");
	GVAR(cur_sm_res_txt) = (localize "STR_DOM_SIDESTRING_1061");
};

if (isServer) then {
    __PossAndOther
	[_poss,"naval"] spawn FUNC(sidemines);
	sleep 2.123;
	["specops", 2, "basic", 4, _pos_other, 150,true] spawn FUNC(CreateInf);
	sleep 2.123;
	["DSHKM",1,"AGS",1,"",0,[_pos_other, 100] call FUNC(GetRanPointCircle),1,100,false] spawn FUNC(CreateArmor);
	sleep 2.123;
	[selectRandom ["uaz_grenade","uaz_mg"],1,selectRandom ["brdm","tank","bmp"],1,"shilka",selectRandom [0,1],[_pos_other, 150] call FUNC(GetRanPointCircleOuter),1,300,true] spawn FUNC(CreateArmor);
};