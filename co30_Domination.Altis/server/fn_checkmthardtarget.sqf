// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkmthardtarget.sqf"
#include "..\x_setup.sqf"

params ["_vec"];
_vec addEventHandler ["killed", {call d_fnc_mthardtargetkilled}];
_vec addEventHandler ["handleDamage", {call d_fnc_CheckMTShotHD}];