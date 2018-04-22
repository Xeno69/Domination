// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_removediscusermarkers.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated || {isMultiplayer && {!d_pisadminp}}) exitWith {};

remoteExec ["d_fnc_rusermarkers", 2];
