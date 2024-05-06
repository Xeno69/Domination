// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

if (d_without_nvg != 1) then {
	private _hmd = hmd _this;

	if (_hmd isNotEqualTo "" && {getText(configFile>>"CfgWeapons">>_hmd>>"simulation") == "NVGoggles"}) then {
		_this unlinkItem _hmd;
	};
};

if (d_no_faks == 0) then {
	_this removeItems "FirstAidKit";
	if (d_gmcwg) exitWith {
		_this removeItems "gm_ge_army_gauzeBandage";
	};
	if (d_vn) exitWith {
		_this removeItems "vn_b_item_firstaidkit";
		_this removeItems "vn_o_item_firstaidkit";
	};
};

if (d_no_ai_silencer == 1) then {
	private _items = primaryWeaponItems _this;
	if ((_items # 0) isNotEqualTo "") then {
		_this removePrimaryWeaponItem (_items  # 0);
	};
	_items = handgunItems _this;
	if ((_items # 0) isNotEqualTo "") then {
		_this removeHandgunItem (_items  # 0);
	};
	_items = secondaryWeaponItems _this;
	if ((_items # 0) isNotEqualTo "") then {
		_this removeSecondaryWeaponItem (_items  # 0);
	};
};
