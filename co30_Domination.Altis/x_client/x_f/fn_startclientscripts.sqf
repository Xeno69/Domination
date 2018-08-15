// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_startclientscripts.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}) exitWith {};
if (!(d_clientScriptsAr # 0) && {(isMultiplayer && {d_pisadminp}) || {!isMultiplayer}}) then {
	d_clientScriptsAr set [0, true];
	execFSM "fsms\fn_IsAdmin.fsm";
};
