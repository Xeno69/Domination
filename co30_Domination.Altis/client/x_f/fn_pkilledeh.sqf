// by Xeno
#define THIS_FILE "fn_pkilledeh.sqf"
#include "..\..\x_setup.sqf"

#ifndef __TT_
_this remoteExecCall ["d_fnc_plcheckkill", 2];
#else
if (_this # 1 == 0) then {
	(_this # 0) remoteExecCall ["d_fnc_plcheckkillblufor", 2];
} else {
	(_this # 0) remoteExecCall ["d_fnc_plcheckkillopfor", 2];
};
#endif
[0] call d_fnc_playerspawn;
d_player_in_vec = false;
uiNamespace setVariable ["BIS_fnc_guiMessage_status", false];
