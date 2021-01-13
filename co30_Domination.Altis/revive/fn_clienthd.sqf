// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_clienthd.sqf"
#include "..\x_macros.sqf"

#define __shots ["shotBullet","shotShell","shotRocket","shotMissile","shotTimeBomb","shotMine","shotGrenade","shotSpread","shotSubmunitions","shotDeploy","shotBoundingMine","shotDirectionalBomb"]

if (!hasInterface) exitWith {};

params ["_unit", "_part", "_dam", "_source", "_ammo", "_idx", "_injurer"];
__TRACE_1("","_this")
if (!local _unit) exitWith {};
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
if (_unit getVariable ["xr_pluncon", false] || {xr_phd_invulnerable}) exitWith {
	__TRACE_2("exiting, unit uncon or invulnerable","_part")
	0
};

if (d_no_teamkill == 0 && {_dam >= 0.1 && {!isNull _injurer && {_injurer isNotEqualTo _unit && {(_injurer call d_fnc_isplayer) && {isNull objectParent _unit && {side (group _injurer) getFriend side (group _unit) >= 0.6}}}}}}) exitWith {
	if (_idx == -1 && {_ammo isNotEqualTo "" && {time > (player getVariable "d_tk_cutofft") && {_ammo call d_fnc_checkammo2}}}) then {
		_unit setVariable ["d_tk_cutofft", time + 3];
		hint format [localize "STR_DOM_MISSIONSTRING_497", _injurer call d_fnc_getplayername];
		[_unit, _injurer] remoteExecCall ["d_fnc_TKR", 2];
	};
	0
};

if (_dam >= 0.9 && {isNull objectParent _unit && {time > (player getVariable "d_tk_cutofft")}}) then {
	_unit setVariable ["d_tk_cutofft", time + 3];
};

_dam