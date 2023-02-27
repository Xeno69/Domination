// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (d_mt_done) exitWith {};

params ["_killed", "_kind"];

if (_kind) then {
	if (d_mt_barracks_down) exitWith {
		__TRACE("mt done or barracks down")
	};
	
	private _grp = group _killed;
	
	__TRACE_1("","_grp")

	if (isNil "_grp" || {!isNil {_grp getVariable "d_respawned"}}) exitWith {
		__TRACE("Exiting")
	};
	
	__TRACE_1("","(units _grp) findIf {alive _x}")

	if ((units _grp) findIf {isNil {_x getVariable "d_dead"}} == -1) then {
		private _grpinfo = _grp getVariable "d_respawninfo";
		__TRACE_1("","_grpinfo")
		if (!isNil "_grpinfo") then {
			_grp setVariable ["d_respawned", true];
			_grpinfo spawn d_fnc_respawngroup;
			__TRACE_1("spawning d_fnc_respawngroup","_grp")
		};
	};
} else {
	if (d_mt_mobile_hq_down) exitWith {
		__TRACE("mt done or mobile hq down")
	};
	
	private _tv = _killed getVariable "d_thevecs";
	if (!isNil "_tv") then {
		_tv = _tv - [objNull];
		__TRACE_1("1","_tv")
		if (_tv isEqualTo []) exitWith {};
		if (_tv findIf {isNil {_x getVariable "d_dead"}} isEqualTo -1) then {
			private _grpinfo = _killed getVariable "d_respawninfo";
			__TRACE_1("","_grpinfo")
			if (!isNil "_grpinfo") then {
				_grpinfo spawn d_fnc_respawngroup;
				__TRACE_1("spawning d_fnc_respawngroup","_tv")
			};
		};
	};
};
