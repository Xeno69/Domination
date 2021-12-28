// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};
private _headgear = headgear player;

if (_headgear != "") then {
	private _subi = getArray (configFile>>"CfgWeapons">>_headgear>>"subItems") apply {toLowerANSI _x};
	private _rem = false;
	if (d_without_nvg != 1 && {"integrated_nvg" in _subi}) then {
		_rem = true;
		systemChat localize "STR_DOM_MISSIONSTRING_1962";
	};
	if (!_rem && {d_without_ti != 1 && {"integrated_nvg_ti" in _subi}}) then {
		_rem = true;
		systemChat localize "STR_DOM_MISSIONSTRING_1963";
	};
	if (_rem) then {
		removeHeadgear player;
	};
};