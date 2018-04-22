//#define __DEBUG__
#define THIS_FILE "x_m116.sqf"
#include "x_setup.sqf"
private ["_vehicle", "_poss"];

GVAR(x_sm_pos) = QGVAR(sm_116) call FUNC(smmapos); // Destroy trucks
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (!isDedicated) then {
	GVAR(cur_sm_txt) = (localize "STR_DOM_SIDESTRING_1043");
	GVAR(cur_sm_res_txt) = (localize "STR_DOM_SIDESTRING_1044");
};

if (isServer) then {
	__Poss
    [_poss,markerDir QGVAR(sm_116)] spawn FUNC(sidetrucks);
};
