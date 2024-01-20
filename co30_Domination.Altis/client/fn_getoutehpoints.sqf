// by Xeno
#include "..\x_setup.sqf"

private _unit = _this # 2;
if !(isPlayer [_unit]) exitWith {};
if (alive player && {_unit != player && {alive _unit}}) then {
	private _var = _unit getVariable "d_TRANS_START";
	if (!isNil "_var" && {_var distance2D _unit > d_transport_distance}) then {
		[player, 13] remoteExecCall ["d_fnc_addscore", 2];
	};
};