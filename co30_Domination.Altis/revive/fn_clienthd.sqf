// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

params ["_unit", "", "_dam", "", "_ammo", "_idx", "_injurer"];
__TRACE_1("","_this")

if (!alive _unit) exitWith {
	__TRACE("unit not alive, removing hd EH")
	private _ehi = player getVariable "xr_hd_eh_i";
	if (!isNil "_ehi") then {
		player removeEventHandler ["handleDamage", _ehi];
		player setVariable ["xr_hd_eh_i", nil];
	} else {
		_unit removeEventHandler ["handleDamage", _thisEventhandler];
	};
	nil
};
if (_dam == 0) exitWith {
	__TRACE_1("exiting, unit healing","_dam")
	_dam
};
if (_unit getVariable "xr_pluncon" || {xr_phd_invulnerable}) exitWith {
	__TRACE("exiting, unit uncon or invulnerable")
	0
};

if (d_no_teamkill == 0 && {_dam >= 0.1 && {!isNull _injurer && {_injurer isNotEqualTo _unit && {side (group _injurer) getFriend side (group _unit) >= 0.6 && {isNull objectParent _unit && {isPlayer [_injurer]}}}}}}) exitWith {
	if (_idx == -1 && {_ammo isNotEqualTo "" && {time > (player getVariable "d_tk_cutofft") && {call d_fnc_checkammo2}}}) then {
		_unit setVariable ["d_tk_cutofft", time + 3];
		hint format [localize "STR_DOM_MISSIONSTRING_497", name _injurer];
		[_unit, _injurer] remoteExecCall ["d_fnc_TKR", 2];
	};
	0
};

if (_dam >= 0.9 && {isNull objectParent _unit && {time > (player getVariable "d_tk_cutofft")}}) then {
	_unit setVariable ["d_tk_cutofft", time + 3];
};

_dam