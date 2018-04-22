// by Xeno
#define THIS_FILE "fn_plcheckkillopfor.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_killed", "", "_killer"];

private _killedfriendly = side (group _killer) == side (group _killed);

if (!isNull _killer && {isPlayer _killer && {vehicle _killer != vehicle _killed}}) then {
	private _par1 = d_player_store getVariable (getPlayerUID _killed);
	__TRACE_1("",_par1);
	private _namep = [_par1 # 6, "Unknown"] select (isNil "_par1");
	private _par = d_player_store getVariable (getPlayerUID _killer);
	private _namek = [_par # 6, "Unknown"] select (isNil "_par");
	if (!_killedfriendly) then {
		d_points_blufor = d_points_blufor + (d_tt_points # 8);
		format [localize ["STR_DOM_MISSIONSTRING_515", "STR_DOM_MISSIONSTRING_514"] select (d_WithRevive == 0), _namek, _namep, "WEST", d_tt_points # 8] remoteExecCall ["sideChat", [0, -2] select isDedicated];
	} else {
		[_namek, _namep, _killer] call d_fnc_TKKickCheck;
		
		private _hmsg = if (d_sub_tk_points != 0) then {
			[format [localize "STR_DOM_MISSIONSTRING_502", _namep, _namek, d_sub_tk_points], "GLOBAL"]
		} else {
			[format [localize "STR_DOM_MISSIONSTRING_503", _namep, _namek], "GLOBAL"]
		};
		
		_hmsg remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
	};
};

if (d_with_ranked && {!_killedfriendly && {d_sub_kill_points != 0}}) then {
	_killed addScore d_sub_kill_points;
};
