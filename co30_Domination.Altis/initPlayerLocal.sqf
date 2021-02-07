// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerLocal.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerLocal.sqf"];
__TRACE_1("","_this")

diag_log ["DOM initPlayerLocal.sqf, sending this to init player on server:", _this];

_this remoteExec ["d_fnc_initPlayerServer", 2];

if (hasInterface) then {
	0 spawn d_fnc_tasks;
};

player enableAttack false;

diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerLocal.sqf processed"];