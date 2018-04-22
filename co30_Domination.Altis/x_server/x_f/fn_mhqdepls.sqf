// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mhqdepls.sqf"
#include "..\..\x_setup.sqf"

if (local (param [0])) then {
	(param [0]) lock (param [1])
};
if (param [1]) then {
	(param [0]) call d_fnc_createMHQEnemyTeleTrig;
} else {
	(param [0]) call d_fnc_removeMHQEnemyTeleTrig;
};

_this remoteExecCall ["d_fnc_mhqdeplNet", [0, -2] select isDedicated];
