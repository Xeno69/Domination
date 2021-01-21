// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_grouplead.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")
disableSerialization;

private _disp = uiNamespace getVariable "d_dyxn_gr_disp";

private _old_lead = leader (group player);
private _isleader = _old_lead == player;

__TRACE_2("","_old_lead","_isleader")

while {d_player_canu && {!isNull _disp}} do {
	sleep 0.5;
};

if (!d_player_canu) then {
	_disp closeDisplay 1;
};

private _new_lead = leader (group player);
__TRACE_1("","_new_lead")

if (_isLeader && {_new_lead != player}) then {
	player setVariable ["xr_isleader", false];
	[_new_lead, true] remoteExecCall ["d_fnc_setleader", _new_lead];
} else {
	if (!_isLeader && {_new_lead == player}) then {
		player setVariable ["xr_isleader", true];
		[_old_lead, false] remoteExecCall ["d_fnc_setleader", _old_lead];
	};
};

uiNamespace setVariable ["d_dyxn_gr_disp", nil];