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

while {alive player && {!(player getVariable ["xr_pluncon", false]) && {!isNull _disp && {!(player getVariable ["ace_isunconscious", false])}}}} do {
	sleep 0.5;
};

if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) then {
	_disp closeDisplay 1;
};

private _new_lead = leader (group player);
__TRACE_1("","_new_lead")

if (_isLeader && {_new_lead != player}) then {
	player setVariable ["xr_isleader", false];
	[_new_lead, ["xr_isleader", true]] remoteExecCall ["setVariable", _new_lead];
} else {
	if (!_isLeader && {_new_lead == player}) then {
		player setVariable ["xr_isleader", true];
		[_old_lead, ["xr_isleader", false]] remoteExecCall ["setVariable", _old_lead];
	};
};

uiNamespace setVariable ["d_dyxn_gr_disp", nil];