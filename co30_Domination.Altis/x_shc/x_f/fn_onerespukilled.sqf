// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_onerespukilled.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

private _grp = group (_this select 0);

if (isNil "_grp" || {!isNil {_grp getVariable "d_respawned"}}) exitWith {};

if ((units _grp) findIf {alive _x} == -1) then {
	private _grpinfo = _grp getVariable "d_respawninfo";
	if (!isNil "_grpinfo") then {
		_grp setVariable ["d_respawned", true];
		_grpinfo spawn d_fnc_respawngroup;
		__TRACE_1("spawning d_fnc_respawngroup","_grp")
	};
};