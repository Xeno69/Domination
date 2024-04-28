//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_unit"];

if ((damage _unit) > 0.05) then {
	_unit setUnitPos "DOWN";
};
private _last_threatened_ts = (agent teamMember _unit) getVariable ["civ_last_firednear_or_threatened", 0];
private _last_dangerclose_ts = (agent teamMember _unit) getVariable ["civ_last_dangerclose", 0];
private _civ_walking_home = (agent teamMember _unit) getVariable ["d_civ_walking_home", false];
private _civ_walking_home_and_is_scared = (agent teamMember _unit) getVariable ["d_civ_walking_home_and_is_scared", false];
private _civ_startpos = (agent teamMember _unit) getVariable ["civ_startpos", []];
{
	// if weapon is raised close by then immediately lay down and set threatend timestamp
	if !(weaponLowered _x) exitWith {
		//if (((animationState _unit) find "sit") > 0) then {
		//	_unit call BIS_fnc_ambientAnim__terminate;
		//};
		_unit setUnitPos "DOWN";
		_last_threatened_ts = time;
		_unit setVariable ["civ_last_firednear_or_threatened", _last_threatened_ts];
		// if threatening unit is extremely close then civ moves away
		// this is very similar to the firedNear EH beahavior but here the movement order is only applied during a single cycle of the loop whereas the EH stores a threat ts and the unit is allowed to flee for a while
		if (_x distance _unit < 1.75 ) then {
			// calculate a position to retreat
			private _newx = (getPos _x # 0) - (getPos _unit # 0);
			private _newy = (getPos _x # 1) - (getPos _unit # 1);
			private _newpos = [(getPos _x # 0) - (1.15 * _newx), (getPos _unit # 1) - (1.15 * _newy)];
			_unit forceSpeed -1;
			_unit moveTo _newpos;
			_last_dangerclose_ts = time;
		};
	};
} forEach (allPlayers select { _x distance2D _unit < 6 });
private _elapsed_time_since_threatened = (time - _last_threatened_ts);
private _elapsed_time_since_dangerclose = (time - _last_dangerclose_ts);
if (_elapsed_time_since_dangerclose > 7 && {!(_civ_startpos isEqualTo []) && {(_unit distance2D _civ_startpos) < 2 && {!(_civ_walking_home_and_is_scared)}}}) then {
	// static civilian was allowed to move for a few seconds but must stop moving now
	_unit forceSpeed 0;
};
if (_elapsed_time_since_threatened > 20 && {_elapsed_time_since_threatened <= 45}) then {
	_unit setUnitPos "MIDDLE";
};
if (_elapsed_time_since_threatened > 45 || { _civ_walking_home_and_is_scared }) then {
	_unit setUnitPos "AUTO";
	if (_civ_startpos isNotEqualTo [] && {(_unit distance2D _civ_startpos) > 2}) then {
		// unit has moved away from start position
		if (_civ_walking_home && {!(_civ_walking_home_and_is_scared)}) then {
			// do nothing, unit is expected to be away from _civ_startpos until scared to move
		} else {
			// static civilian moved away from startpos or is running home scared, unit should move back now
			_unit moveTo _civ_startpos;
			// diag_log [format ["global loop walking home scared moveToo unit: %1   curr pos: %2   startpos: %3", _unit, getPos _unit, _civ_startpos]];
		};
	};
};
