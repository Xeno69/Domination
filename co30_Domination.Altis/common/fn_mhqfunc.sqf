// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mhqfunc.sqf"
#include "..\x_setup.sqf"

_this setVariable ["d_MHQ_Deployed", false];
if (isServer && {d_NoMHQTeleEnemyNear > 0}) then {
	_this call d_fnc_removeMHQEnemyTeleTrig;
};