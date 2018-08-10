// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_arsenal_mod.sqf"
#include "..\..\x_setup.sqf"

private _mods = _this apply {toLower _x};
__TRACE_1("","_mods")

private _items_no = ["FirstAidKit", "Medikit", "ItemMap", "ItemRadio", "ItemCompass", "ItemWatch", "ItemGPS", "Rangefinder", "NVGoggles", "NVGoggles_OPFOR",
			"NVGoggles_INDEP"];

if (d_with_ace) then {
	_items_no append ["ACE_atropine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_quikclot", "ACE_bloodIV", "ACE_bloodIV_500", "ACE_bloodIV_250",
		"ACE_bodyBag", "ACE_bodyBagObject", "ACE_epinephrine", "ACE_morphine", "ACE_packingBandage", "ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_500",
		"ACE_plasmaIV_250", "ACE_salineIV", "ACE_salineIV_500", "ACE_salineIV_250", "ACE_surgicalKit", "ACE_tourniquet"];
};

_items_no = _items_no apply {toLower _x};

private _findmodfnc = {
	__TRACE_1("_findmodfnc","_this")
	params ["_csal"];
	private _res = -1;
	private _csallow = toLower (_csal # 0);
	__TRACE_1("_findmodfnc","_csallow")
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
		if !(toLower _item in _items_no) then {
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
			if (_kind != "" && {([configSourceAddonList (configFile >> _kind >> _x)] call _findmodfnc) == -1}) then {
				_ar set [_forEachIndex, -1];
			};
		};
	} forEach _ar;
	_ar = _ar - [-1];
	bis_fnc_arsenal_data set [_forEachIndex, _ar];
} forEach bis_fnc_arsenal_data;
