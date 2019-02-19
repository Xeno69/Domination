// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkmthardtarget.sqf"
#include "..\..\x_setup.sqf"

params ["_vec"];
_vec addEventHandler ["killed", {_this call d_fnc_mthardtargetkilled}];
_vec addEventHandler ["handleDamage", {_this call d_fnc_CheckMTShotHD}];