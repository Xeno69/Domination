// by Xeno
#define THIS_FILE "fn_rem_ti_nvg_items.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};
private _headgear = headgear player;

if (_headgear != "") then {
	private _subi = getArray (configFile>>"CfgWeapons">>_headgear>>"subItems") apply {toLowerANSI _x};
	private _rem = false;
	if (d_without_nvg == 0 && {_subi find "integrated_nvg" > -1}) then {
		_rem = true;
		systemChat localize "STR_DOM_MISSIONSTRING_1962";
	};
	if (!_rem && {d_without_ti == 0 && {_subi find "integrated_nvg_ti" > -1}}) then {
		_rem = true;
		systemChat localize "STR_DOM_MISSIONSTRING_1963";
	};
	if (_rem) then {
		removeHeadgear player;
	};
};