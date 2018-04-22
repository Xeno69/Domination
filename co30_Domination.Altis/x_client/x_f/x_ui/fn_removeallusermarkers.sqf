// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_removeallusermarkers.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated || {isMultiplayer && {!d_pisadminp}}) exitWith {};

remoteExec ["d_fnc_rallusermarkers", 2];
