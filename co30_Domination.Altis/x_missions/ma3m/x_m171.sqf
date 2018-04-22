//#define __DEBUG__
#define THIS_FILE "x_m171.sqf"
#include "x_setup.sqf"

GVAR(x_sm_pos) = QGVAR(sm_171) call FUNC(smmapos); // rescue in sea
GVAR(x_sm_type) = "normal"; // "convoy"

#ifdef __SMMISSIONS_MARKER__
if (true) exitWith {};
#endif

if (!isDedicated) then {
	GVAR(cur_sm_txt) = (localize "STR_DOM_SIDESTRING_1031B");
	GVAR(cur_sm_res_txt) = (localize "STR_DOM_SIDESTRING_1032");
};

if (isServer) then {
   [GVAR(x_sm_pos),time + ((15 * 60) + random 60),"plane"] spawn FUNC(sideevacsea);
};
