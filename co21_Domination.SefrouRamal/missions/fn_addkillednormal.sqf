// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;

_this addEventhandler ["handleDamage", {call d_fnc_smhandledeh}];
_this addEventHandler ["hit", {call d_fnc_smhiteh2}];
#endif

_this addEventhandler ["killed", {call d_fnc_KilledSMTargetNormal}];