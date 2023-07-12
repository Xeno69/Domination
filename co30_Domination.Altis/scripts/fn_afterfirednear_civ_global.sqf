//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_unit"];

if ((damage _unit) > 0.05) then {
	_unit setUnitPos "DOWN";
};
private _last_threatened_ts = (agent teamMember _unit) getVariable ["civ_last_firednear_or_threatened", 0];
private _last_dangerclose_ts = (agent teamMember _unit) getVariable ["civ_last_dangerclose", 0];
private _civ_is_walking = (agent teamMember _unit) getVariable ["civ_is_walking", false];
{
	// if weapon is raised and within 4m then immediately lay down and set threatend timestamp
	if !(weaponLowered _x) exitWith {
		if (((animationState _unit) find "sit") > 0) then {
			_unit call BIS_fnc_ambientAnim__terminate;
		};
		_unit setUnitPos "DOWN";
		_last_threatened_ts = time;
		_unit setVariable ["civ_last_firednear_or_threatened", _last_threatened_ts];
	};
} forEach (allPlayers select { _x distance2D _unit < 6 });
private _elapsed_time_since_threatened = (time - _last_threatened_ts);
private _elapsed_time_since_dangerclose = (time - _last_dangerclose_ts);
if (_elapsed_time_since_dangerclose > 7 && {!_civ_is_walking}) then {
	// static civilian was allowed to move for a few seconds but must stop moving now 
	_unit forceSpeed 0;
};
if (_elapsed_time_since_threatened > 10 && {_civ_is_walking}) then {
	_unit forceSpeed -1;
};
if (_elapsed_time_since_threatened > 30 && {_elapsed_time_since_threatened <= 45}) then {
	_unit setUnitPos "MIDDLE";
};
if (_elapsed_time_since_threatened > 45) then {
	_unit setUnitPos "AUTO";
};
