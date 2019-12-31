// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_plcheckkill.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_killed", "_killer", "_instigator"];
if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill

if ((d_with_ranked || {d_database_found}) && {d_sub_kill_points != 0 && {side (group _instigator) getFriend side (group _killed) < 0.6}}) then {
	_killed addScore d_sub_kill_points;
};

if (d_with_ai) then {	
	if (!isNull _instigator && {!(_instigator call d_fnc_isplayer) && {side (group _instigator) getFriend side (group _killed) >= 0.6 && {vehicle _killed != vehicle _instigator}}}) then {
		_leader_killer = leader _instigator;
		if (_leader_killer call d_fnc_isplayer) then {
			private _par = d_player_store getVariable (getPlayerUID _killed);
			private _namep = [_par # 6, "Unknown"] select (isNil "_par");
			private _par = d_player_store getVariable (getPlayerUID _leader_killer);
			[[_par # 6, "Unknown"] select (isNil "_par"), _namep, _instigator] call d_fnc_TKKickCheck;
		};
	};
};

if (!isNull _instigator && {(_instigator call d_fnc_isplayer) && {vehicle _instigator != vehicle _killed}}) then {
	private _par = d_player_store getVariable (getPlayerUID _killed);
	__TRACE_1("_killed",_par)
	private _namep = [_par # 6, "Unknown"] select (isNil "_par");
	private _par = d_player_store getVariable (getPlayerUID _instigator);
	__TRACE_1("_instigator",_par)
	private _namek = [_par # 6, "Unknown"] select (isNil "_par");
	[_namek, _namep, _instigator] call d_fnc_TKKickCheck;
	[_namep, _namek] remoteExecCall ["d_fnc_unit_tk", [0, -2] select isDedicated];
};
