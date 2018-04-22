//#define __DEBUG__
#define THIS_FILE "x_m170.sqf"
#include "x_setup.sqf"

GVAR(x_sm_pos) = QGVAR(sm_170) call FUNC(smmapos); // rescue in sea
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (!isDedicated) then {
	GVAR(cur_sm_txt) = (localize "STR_DOM_SIDESTRING_1031A");
	GVAR(cur_sm_res_txt) = (localize "STR_DOM_SIDESTRING_1032");
};

if (isServer) then {
   [GVAR(x_sm_pos),time + ((15 * 60) + random 60),"ship"] spawn FUNC(sideevacsea);
};
