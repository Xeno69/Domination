// by Xeno
#define THIS_FILE "fn_checkveckillblufor.sqf"
#include "..\..\x_setup.sqf"

private _killer = param [2];

if !(_killer call d_fnc_isplayer) exitWith {};

if (side (group _killer) == opfor) then {
	d_points_opfor = d_points_opfor + (d_tt_points # 7);
	
	private _kpar = d_player_store getVariable (getPlayerUID _killer);
	if (isNil "_kpar") exitWith {};
	format [localize "STR_DOM_MISSIONSTRING_516", _kpar # 6, "WEST", "EAST", d_tt_points # 7] remoteExecCall ["systemChat", [0, -2] select isDedicated];
};
