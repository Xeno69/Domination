// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_arsenal_mod_rem.sqf"
#include "..\x_setup.sqf"

//private _mods = _this apply {toLower _x};
private _mods = _this apply {toLowerANSI _x};
__TRACE_1("","_mods")

private _findmodfnc = {
	//__TRACE_1("_findmodfnc","_this")
	params ["_csal"];
	private _res = -1;
	//private _csallow = toLower (_csal # 0);
	private _csallow = toLowerANSI (_csal # 0);
	//__TRACE_1("_findmodfnc","_csallow")
	_mods findIf {
		_ret = _csallow find _x != -1;
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
		_kind = if (isClass (configFile >> "CfgWeapons" >> _x)) then {
			"CfgWeapons"
		} else {
			if (isClass (configFile >> "CfgMagazines" >> _x)) then {
				"CfgMagazines"
			} else {
				if (isClass (configFile >> "CfgVehicles" >> _x)) then {
					"CfgVehicles"
				} else {
					if (isClass (configFile >> "CfgGlasses" >> _x)) then {
						"CfgGlasses"
					} else {
						""
					};
				};
			};
		};
		__TRACE_1("","_kind")
		__TRACE_1("","configSourceAddonList (configFile >> _kind >> _x)")
		if (_kind != "" && {([configSourceAddonList (configFile >> _kind >> _x)] call _findmodfnc) != -1}) then {
			__TRACE_1("","_ar select _forEachIndex")
			_ar set [_forEachIndex, -1];
		};
	} forEach _ar;
	_ar = _ar - [-1];
	bis_fnc_arsenal_data set [_forEachIndex, _ar];
} forEach bis_fnc_arsenal_data;
