// by Xeno
#define THIS_FILE "fn_plcheckkill.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_killed", "", "_killer"];

if (d_with_ranked && {d_sub_kill_points != 0 && {side (group _killer) getFriend side (group _killed) < 0.6}}) then {
	_killed addScore d_sub_kill_points;
};

if (d_with_ai) then {	
	if (!isNull _killer && {!isPlayer _killer && {side (group _killer) getFriend side (group _killed) >= 0.6 && {vehicle _killed != vehicle _killer}}}) then {
		_leader_killer = leader _killer;
		if (isPlayer _leader_killer) then {
			private _par = d_player_store getVariable (getPlayerUID _killed);
			private _namep = [_par # 6, "Unknown"] select (isNil "_par");
			private _par = d_player_store getVariable (getPlayerUID _leader_killer);
			[[_par # 6, "Unknown"] select (isNil "_par"), _namep, _killer] call d_fnc_TKKickCheck;
		};
	};
};

if (!isNull _killer && {isPlayer _killer && {vehicle _killer != vehicle _killed}}) then {
	private _par = d_player_store getVariable (getPlayerUID _killed);
	__TRACE_1("_killed",_par)
	private _namep = [_par # 6, "Unknown"] select (isNil "_par");
	private _par = d_player_store getVariable (getPlayerUID _killer);
	__TRACE_1("_killer",_par)
	private _namek = [_par # 6, "Unknown"] select (isNil "_par");
	[_namek, _namep, _killer] call d_fnc_TKKickCheck;
	[_namep, _namek] remoteExecCall ["d_fnc_unit_tk", [0, -2] select isDedicated];
};
