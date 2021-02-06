// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_arsenal_mod.sqf"
#include "..\x_setup.sqf"

private _mods = _this apply {toLowerANSI _x};
__TRACE_1("","_mods")

private _items_no = ["ItemMap", "ItemRadio", "ToolKit", "MineDetector"];

if (!d_gmcwg) then {
	_items_no append ["FirstAidKit", "Medikit", "ItemCompass", "ItemWatch"];
};

if (!d_ifa3lite && {!d_gmcwg && {!d_unsung && {!d_csla}}}) then {
	_items_no append ["Rangefinder", "NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP", "ItemGPS"];
};

if (d_with_ace) then {
	_items_no append ["ACE_atropine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_quikclot", "ACE_bloodIV", "ACE_bloodIV_500", "ACE_bloodIV_250",
		"ACE_bodyBag", "ACE_bodyBagObject", "ACE_epinephrine", "ACE_morphine", "ACE_packingBandage", "ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_500",
		"ACE_plasmaIV_250", "ACE_salineIV", "ACE_salineIV_500", "ACE_salineIV_250", "ACE_surgicalKit", "ACE_tourniquet"];
};

if (d_cup) then {
	_items_no append ["B_UavTerminal", "O_UavTerminal", "I_UavTerminal"];
};

_items_no = _items_no apply {toLowerANSI _x};

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
			(_x select [0, count _csallow]) isEqualTo _csallow
		} else {
			(_csallow select [0, count _x]) isEqualTo _x
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
		if !(toLowerANSI _item in _items_no) then {
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
			if (_kind != "" && {([configSourceAddonList (configFile >> _kind >> _x)] call _findmodfnc) == -1}) then {
				__TRACE_1("","_ar select _forEachIndex")
				_ar set [_forEachIndex, -1];
			};
		};
	} forEach _ar;
	_ar = _ar - [-1];
	bis_fnc_arsenal_data set [_forEachIndex, _ar];
} forEach bis_fnc_arsenal_data;
