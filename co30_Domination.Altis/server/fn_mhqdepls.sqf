// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifdef __GMCWG__
if (typeOf (_this # 0) == "gm_ge_army_m113a1g_command") then {
	if (_this # 1) then {
		(_this #0) animateSource ["antennamast_01_elev_source", 1];
	} else {
		(_this #0) animateSource ["antennamast_01_elev_source", 0];
	};
};
#endif

if (local (_this # 0)) then {
	(_this # 0) lock (_this # 1)
};
if (_this # 1) then {
	(_this # 0) call d_fnc_createMHQEnemyTeleTrig;
} else {
	[_this # 0, 0] call d_fnc_removeMHQEnemyTeleTrig;
};

_this remoteExecCall ["d_fnc_mhqdeplNet", [0, -2] select isDedicated];
