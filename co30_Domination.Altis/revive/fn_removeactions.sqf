// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (!hasInterface || {player == _this}) exitWith {};

private _unit = _this;
private _actid = _unit getVariable ["xr_ReviveAction", -9999];
if (_actid != -9999) then {
	[_unit, _actid] call bis_fnc_holdActionRemove;
	_unit setVariable ["xr_ReviveAction", -9999];
};
_actid = _unit getVariable ["xr_DragAction", -9999];
if (_actid != -9999) then {
	_unit removeAction _actid;
	_unit setVariable ["xr_DragAction", -9999];
};

xr_uncon_units = xr_uncon_units - [_unit, objNull];