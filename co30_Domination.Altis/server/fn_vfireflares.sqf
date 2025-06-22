// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];

private _weaps = getArray ((configOf _vec) >> "weapons");
private _idx = _weaps findIf {
	_x isKindOf ["CMFlareLauncher", configFile >> "CfgWeapons"]
};
if (_idx == -1) exitwith {};

[_vec, _weaps # _idx] spawn {
	scriptname "spawn launch vec flares";
	params ["_vec", "_launcher"];
	if (canMove _vec && {alive driver _vec}) then {
		for "_i" from 0 to 5 do {
			driver _vec forceWeaponfire [_launcher, "Burst"];
			_time = time + 1.1;
			waitUntil {time > _time || {!alive _vec}};
			if (!alive _vec || {!alive driver _vec}) exitwith {};
		};
	};
};