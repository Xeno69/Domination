// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

private _magsv = [];
private _cfgmagx = configFile>>"CfgMagazines";
private _marray = getArray(configFile>>"CfgVehicles">>typeOf (d_ao_arty_vecs # 0)>>"Turrets">>"MainTurret">>"magazines");
_marray = _marray - ["6Rnd_155mm_Mo_AT_mine", "6Rnd_155mm_Mo_mine", "6Rnd_155mm_Mo_AT_mine_O", "6Rnd_155mm_Mo_mine_O"];
{
	_magsv pushBackUnique _x;
} forEach (_marray select {getText(configFile>>"CfgAmmo">>getText(_cfgmagx>>_x>>"ammo")>>"submunitionAmmo") != "Mo_ClassicMineRange"});

private _ammonv = [];
_ammonv resize (count _magsv);
{
	_ammonv set [_forEachIndex, getText(configFile>>"CfgMagazines">>_x>>"displayName")];
} forEach _magsv;

//__TRACE_2("","_magsv","_ammonv")

private _dispx = uiNamespace getVariable "d_MarkArtilleryDialog";
private _ctrl = _dispx displayCtrl 888;
{
	private _idx = _ctrl lbAdd _x;
	_ctrl lbSetData [_idx, _magsv # _forEachIndex];
} forEach _ammonv;
_ctrl lbSetCurSel 0;

_ctrl = _dispx displayCtrl 889;
if (!d_with_ranked) then {
	{_ctrl lbAdd _x} forEach ["1", "2", "3"];
} else {
	private _rank = rank player;
	private _sels = if (_rank in ["PRIVATE","CORPORAL"]) then {
		["1"]
	} else {
		if (_rank in ["SERGEANT","LIEUTENANT"]) then {
			["1", "2"]
		} else {
			["1", "2", "3"]
		};
	};
	{_ctrl lbAdd _x} forEach _sels;
};
_ctrl lbSetCurSel 0;
ctrlSetFocus (_dispx displayCtrl 1212);

private _ctrlmap = _dispx displayCtrl 11111;
_ctrlmap ctrlMapAnimAdd [0.5, 0.02, markerPos "d_temp_mark_arty_marker"];
ctrlMapAnimCommit _ctrlmap;
