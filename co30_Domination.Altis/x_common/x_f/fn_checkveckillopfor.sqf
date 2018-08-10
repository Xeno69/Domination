// by Xeno
#define THIS_FILE "fn_checkveckillopfor.sqf"
#include "..\..\x_setup.sqf"

params ["_vec", "", "_killer"];

if (d_with_ace && {isNull _killer}) then {
	_killer = _vec getVariable ["ace_medical_lastDamageSource", _killer];
};

if !(_killer call d_fnc_isplayer) exitWith {};

if (side (group _killer) == blufor) then {
	d_points_blufor = d_points_blufor + (d_tt_points # 7);
	
	private _kpar = d_player_store getVariable (getPlayerUID _killer);
	if (isNil "_kpar") exitWith {};
	format [localize "STR_DOM_MISSIONSTRING_516", _kpar # 6, "EAST", "WEST", d_tt_points # 7] remoteExecCall ["systemChat", [0, -2] select isDedicated];
};
