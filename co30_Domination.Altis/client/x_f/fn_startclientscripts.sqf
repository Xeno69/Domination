// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_startclientscripts.sqf"
#include "..\..\x_setup.sqf"

sleep 10;

while {true} do {
	sleep 1;
	if (alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}) then {
		if (!(d_clientScriptsAr # 0) && {(isMultiplayer && {d_pisadminp}) || {!isMultiplayer}}) then {
			d_clientScriptsAr set [0, true];
			execFSM "fsms\fn_IsAdmin.fsm";
		};
	};
};
