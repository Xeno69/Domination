// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_kickplayerbs.sqf"
#include "..\x_setup.sqf"

params ["_pl", "_pl_name", "_reason"];
private _uid = getPlayerUID _pl;
"LOSER" remoteExecCall ["endMission", _pl];
if (_reason != -1) then {
	if (_reason == 2) then {
		diag_log format [localize "STR_DOM_MISSIONSTRING_945", _pl_name, _uid];
	} else {
		if (_reason == 3) then {
			diag_log format [localize "STR_DOM_MISSIONSTRING_946", _pl_name, _uid];
		};
	};
	[format [[localize "STR_DOM_MISSIONSTRING_509", localize "STR_DOM_MISSIONSTRING_508"] select (_reason == 0), _pl_name], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
};