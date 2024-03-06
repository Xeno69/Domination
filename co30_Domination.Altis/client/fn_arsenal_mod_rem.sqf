// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _mods = _this apply {toLowerANSI _x};
__TRACE_1("","_mods")

private _findmodfnc = {
	__TRACE_1("_findmodfnc","_this")
	params ["_csal"];
	private _res = -1;
	private _csallow = toLowerANSI (_csal # 0);
	__TRACE_1("_findmodfnc","_csallow")
	__TRACE_1("_findmodfnc","_mods")
	_mods findIf {
		__TRACE_1("_findmodfnc","_x")
		__TRACE_1("_findmodfnc","count _x")
		__TRACE_1("_findmodfnc","count _csallow")
		_ret = if (count _x >= count _csallow) then {
			//(_x select [0, count _csallow]) isEqualTo _csallow
			_x find _csallow == 0
		} else {
			//(_csallow select [0, count _x]) isEqualTo _x
			_csallow find _x == 0
		};
		if (_ret) then {
			_res = 1;
		};
		_ret
	};
	_res
};

{
	private _ar = _x;
	__TRACE_1("","_x")
	private ["_item", "_kind"];
	{
		_item = _x;
		_kind = call {
			if (isClass (configFile >> "CfgWeapons" >> _x)) exitWith {
				"CfgWeapons"
			};
			if (isClass (configFile >> "CfgMagazines" >> _x)) exitWith {
				"CfgMagazines"
			};
			if (isClass (configFile >> "CfgVehicles" >> _x)) exitWith {
				"CfgVehicles"
			};
			if (isClass (configFile >> "CfgGlasses" >> _x)) exitWith {
				"CfgGlasses"
			};
			""
		};
		__TRACE_1("","_kind")
		__TRACE_1("","configSourceAddonList (configFile >> _kind >> _x)")
		if (_kind isNotEqualTo "" && {([configSourceAddonList (configFile >> _kind >> _x)] call _findmodfnc) != -1}) then {
			__TRACE_1("","_ar select _forEachIndex")
			_ar set [_forEachIndex, -1];
		};
	} forEach _ar;
	_ar = _ar - [-1];
	bis_fnc_arsenal_data set [_forEachIndex, _ar];
} forEach bis_fnc_arsenal_data;
