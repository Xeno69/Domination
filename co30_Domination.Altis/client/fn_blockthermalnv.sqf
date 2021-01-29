// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_blockthermalnv.sqf"
#include "..\x_setup.sqf"

private _thermarheadgear = [];
private _nvarheadgear = [];
{
	private _ar = getArray(configFile>>"CfgWeapons">>_x>>"subItems");
	if (_ar isNotEqualTo []) then {
		{
			private _visionmode = getArray(configFile>>"CfgWeapons">>_x>>"visionMode") apply {toLowerANSI _x};
			if ("nvg" in _visionmode) then {
				_nvarheadgear pushBackUnique _x;
			};
			if ("ti" in _visionmode) then {
				_thermarheadgear pushBackUnique _x;
			};
		} forEach _ar;
	};
} forEach (bis_fnc_arsenal_data # 6); // headgear

__TRACE_1("","_thermarheadgear")
__TRACE_1("","_nvarheadgear")

private _thermarlauncher = [];
private _nvarlauncher = [];
{
	private _om = configFile>>"CfgWeapons">>_x>>"OpticsModes";
	if (isClass _om) then {
		for "_i" from 0 to count _om - 1 do {
			private _entry = _om select _i;
			private _visionmode = getArray(_entry>>"visionMode") apply {toLowerANSI _x};
			if ("nvg" in _visionmode) then {
				_nvarlauncher pushBackUnique _x;
			};
			if ("ti" in _visionmode) then {
				_thermarlauncher pushBackUnique _x;
			};
		};
	};
} forEach (bis_fnc_arsenal_data # 1); // launchers

__TRACE_1("","_thermarlauncher")
__TRACE_1("","_nvarlauncher")

while {true} do {
	waitUntil {sleep 0.1; currentVisionMode player in [1, 2]};
	if (currentVisionMode player == 1) then {
		if (currentWeapon player in _nvarlauncher || {headgear player in _nvarheadgear || {alive (getConnectedUAV player)}}) then {
			"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2014", "BLACK", 0.1];
			waitUntil {sleep 0.1; currentVisionMode player != 1};
			"d_t_block" cutText ["", "PLAIN"];
		};
	} else {
		if (currentVisionMode player == 2) then {
			if (currentWeapon player in _thermarlauncher || {headgear player in _thermarheadgear || {alive (getConnectedUAV player)}}) then {
				"d_t_block" cutText [localize "STR_DOM_MISSIONSTRING_2015", "BLACK", 0.1];
				waitUntil {sleep 0.1; currentVisionMode player != 2};
				"d_t_block" cutText ["", "PLAIN"];
			};
		};
	};
	sleep 0.1;
};