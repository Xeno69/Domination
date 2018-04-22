// by Xeno
#define THIS_FILE "fn_getoutehpoints.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

private _unit = param [2];
if (!isPlayer _unit) exitWith {};
if (alive player && {_unit != player && {alive _unit}}) then {
	private _var = _unit getVariable "d_TRANS_START";
	if (!isNil "_var" && {_var distance2D _unit > d_transport_distance}) then {
		[player, d_ranked_a # 18] remoteExecCall ["addScore", 2];
	};
};