// by Xeno
#define THIS_FILE "fn_checkveckillopfor.sqf"
#include "..\..\x_setup.sqf"

private _killer = param [2];

if (!isPlayer _killer) exitWith {};

if (side (group _killer) == blufor) then {
	d_points_blufor = d_points_blufor + (d_tt_points # 7);
	
	private _kpar = d_player_store getVariable (getPlayerUID _killer);
	if (isNil "_kpar") exitWith {};
	format [localize "STR_DOM_MISSIONSTRING_516", _kpar # 6, "EAST", "WEST", d_tt_points # 7] remoteExecCall ["systemChat", [0, -2] select isDedicated];
};
