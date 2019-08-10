// by Xeno
#define THIS_FILE "fn_rem_ti_nvg_items.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _doexit = 0;
{
	private _omc = configFile>>"CfgWeapons">>_x>>"ItemInfo">>"OpticsModes";
	__TRACE_1("","_omc")
	if (isClass _omc) then {
		for "_i" from 0 to count _omc - 1 do {
			private _modes = getArray((_omc select _i)>>"visionMode");
			__TRACE_1("","_modes")
			if (d_without_nvg == 0 && {"NVG" in _modes}) exitWith {
				_doexit = 1;
			};
			if (d_without_vec_ti == 0 && {"Ti" in _modes}) exitWith {
				_doexit = 2;
			};
		};
	};
	if (_doexit != 0) exitWith {
		if (_doexit == 1) then {
			systemChat localize "STR_DOM_MISSIONSTRING_1645";
		} else {
			systemChat localize "STR_DOM_MISSIONSTRING_1646";
		};
		player removePrimaryWeaponItem _x;
	};
} forEach (primaryWeaponItems player);

{
	private _omc = configFile>>"CfgWeapons">>_x>>"ItemInfo">>"OpticsModes";
	__TRACE_1("","_omc")
	if (isClass _omc) then {
		for "_i" from 0 to count _omc - 1 do {
			private _modes = getArray((_omc select _i)>>"visionMode");
			__TRACE_1("","_modes")
			if (d_without_nvg == 0 && {"NVG" in _modes}) exitWith {
				_doexit = 1;
			};
			if (d_without_vec_ti == 0 && {"Ti" in _modes}) exitWith {
				_doexit = 2;
			};
		};
	};
	if (_doexit != 0) exitWith {
		if (_doexit == 1) then {
			systemChat localize "STR_DOM_MISSIONSTRING_1645";
		} else {
			systemChat localize "STR_DOM_MISSIONSTRING_1646";
		};
		player removeSecondaryWeaponItem _x;
	};
} forEach (secondaryWeaponItems player);

{
	private _omc = configFile>>"CfgWeapons">>_x>>"ItemInfo">>"OpticsModes";
	__TRACE_1("","_omc")
	if (isClass _omc) then {
		for "_i" from 0 to count _omc - 1 do {
			private _modes = getArray((_omc select _i)>>"visionMode");
			__TRACE_1("","_modes")
			if (d_without_nvg == 0 && {"NVG" in _modes}) exitWith {
				_doexit = 1;
			};
			if (d_without_vec_ti == 0 && {"Ti" in _modes}) exitWith {
				_doexit = 2;
			};
		};
	};
	if (_doexit != 0) exitWith {
		if (_doexit == 1) then {
			systemChat localize "STR_DOM_MISSIONSTRING_1645";
		} else {
			systemChat localize "STR_DOM_MISSIONSTRING_1646";
		};
		player removeHandgunItem _x;
	};
} forEach (handgunItems player);

private _headgear = headgear player;

if (_headgear != "") then {
	private _subi = getArray (configFile>>"CfgWeapons">>_headgear>>"subItems");
	private _rem = false;
	if (d_without_nvg == 0 && {_subi find "Integrated_NVG_F" > -1}) then {
		_rem = true;
		systemChat localize "STR_DOM_MISSIONSTRING_1962";
	};
	if (d_without_vec_ti == 0 && {_subi find "Integrated_NVG_TI_1_F" > -1}) then {
		_rem = true;
		systemChat localize "STR_DOM_MISSIONSTRING_1963";
	};
	if (_rem) then {
		removeHeadgear player;
	};
};