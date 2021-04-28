// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

sleep 10;

while {true} do {
	sleep 1;
	if (d_player_canu && {!(d_clientScriptsAr # 0)}) then {
		if ((isMultiplayer && {d_pisadminp}) || {!isMultiplayer}) then {
			d_clientScriptsAr set [0, true];
			execFSM "fsms\fn_IsAdmin.fsm";
		};
	};
};
