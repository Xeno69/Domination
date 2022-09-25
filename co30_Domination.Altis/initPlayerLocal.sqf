// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerLocal.sqf"];
__TRACE_1("","_this")

diag_log ["DOM initPlayerLocal.sqf, sending this to init player on server:", _this];

if (getClientStateNumber >= 11) exitWith {
	diag_log "Dom game already ended... Exiting";
};

_this remoteExec ["d_fnc_initPlayerServer", 2];

if (hasInterface) then {
	0 spawn d_fnc_tasks;
};

player enableAttack false;

diag_log ["Dom d_database_found:", d_database_found];
diag_log ["Dom name player:", name player];

diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerLocal.sqf processed"];