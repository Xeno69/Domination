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
	_unit removeEventHandler ["handleDamage", _thisEventhandler];
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
// TODO
//if (isNull _injurer) then {_injurer = UAVControl vehicle _source select 0}; // UAV/UGV player operated road kill
//if (isNull _injurer) then {_injurer = _source}; // player driven vehicle road kill

if (d_no_teamkill == 0 && {_dam >= 0.1 && {!isNull _injurer && {(_injurer call d_fnc_isplayer) && {_injurer != _unit && {isNull objectParent _unit && {side (group _injurer) getFriend side (group _unit) >= 0.6}}}}}}) exitWith {
	if (_idx == -1 && {_ammo != "" && {time > (player getVariable "d_tk_cutofft") && {getText (configFile>>"CfgAmmo">>_ammo>>"simulation") in __shots}}}) then {
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