// by Xeno
#include "..\x_setup.sqf"

#ifdef __TT__
if (_this # 1 == 0) then {
	(_this # 0) remoteExecCall ["d_fnc_plcheckkillblufor", 2];
} else {
	(_this # 0) remoteExecCall ["d_fnc_plcheckkillopfor", 2];
};
#endif
[0] call d_fnc_playerspawn;
d_player_in_vec = false;
uiNamespace setVariable ["BIS_fnc_guiMessage_status", false];

if (d_database_found) then {
	player setVariable ["d_move_stop", getPosWorld player];
	call d_fnc_updatemove;
};