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
	[10, _reason, _pl_name] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
};