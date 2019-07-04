// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkilledehsm.sqf"
#include "..\x_setup.sqf"
__TRACE_1("","_this")

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
#endif

_this addEventHandler ["killed", {_this call d_fnc_smkilledeh}];
_this addEventHandler ["handleDamage", {_this call d_fnc_CheckSMShotHD}];
#ifdef __TT__
_this addEventHandler ["hit", {_this call d_fnc_smhiteh}];
#endif
d_x_sm_vec_rem_ar pushBack _this;