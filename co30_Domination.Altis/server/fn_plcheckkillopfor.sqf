// by Xeno
#define THIS_FILE "fn_plcheckkillopfor.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_killed", "", "_killer"];

private _killedfriendly = side (group _killer) == side (group _killed);

if (!isNull _killer && {(_killer call d_fnc_isplayer) && {vehicle _killer != vehicle _killed}}) then {
	private _par1 = d_player_hash getOrDefault [getPlayerUID _killed, []];
	__TRACE_1("",_par1);
	private _namep = [_par1 # 6, "Unknown"] select (_par1 isEqualTo []);
	private _par = d_player_hash getOrDefault [getPlayerUID _killer, []];
	private _namek = [_par # 6, "Unknown"] select (_par isEqualTo []);
	if (!_killedfriendly) then {
		d_points_blufor = d_points_blufor + (d_tt_points # 8);
		[14, _namek, _namep] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
	} else {
		[_namek, _namep, _killer] call d_fnc_TKKickCheck;
		[13, _namep, _namek] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
	};
};

if ((d_with_ranked || {d_database_found}) && {!_killedfriendly && {d_sub_kill_points != 0}}) then {
	_killed addScore d_sub_kill_points;
};
