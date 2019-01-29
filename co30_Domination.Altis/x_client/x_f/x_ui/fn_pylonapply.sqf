// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pylonapply.sqf"
#include "..\..\..\x_setup.sqf"

disableSerialization;

private _vec = d_pylon_vec;
private _tvec = typeOf _vec;

__TRACE_1("","count d_pylondialog_ctrls")
__TRACE_1("","d_pylondialog_ctrls")

private _prevweaps = getPylonMagazines _vec apply {getText (configFile>>"CfgMagazines">>_x>>"pylonWeapon")};
_prevweaps = _prevweaps - [""];
__TRACE_1("","_prevweaps")

private _cfg = configFile>>"CfgVehicles">>(typeOf _vec)>>"Components">>"TransportPylonsComponent">>"pylons";
for "_i" from 0 to (count _cfg - 1) do {
	_ctrl = d_pylondialog_ctrls select _i;
	private _mag = _ctrl lbData (lbCurSel _ctrl);
	private _cname = configName (_cfg select _i);
	if (_mag != "") then {
		_vec setPylonLoadOut [_cname, _mag, true, getArray (configFile >>"CfgVehicles">>_tvec>>"Components">>"TransportPylonsComponent">>"Pylons">>_cname>>"turret")];
	} else {
		_vec setPylonLoadOut [_cname, "", true];
	};
};

private _newweapsx = getPylonMagazines _vec apply {getText (configFile>>"CfgMagazines">>_x>>"pylonWeapon")};
_newweapsx = _newweapsx - [""];
__TRACE_1("","_newweapsx")

private _oldweaps = [];
{
	_oldweaps pushBackUnique _x;
} forEach _prevweaps;

private _newweaps = [];
{
	_newweaps pushBackUnique _x;
} forEach _newweapsx;

__TRACE_1("","_oldweaps")

{
	if !(_x in _newweaps) then {
		_vec removeWeaponGlobal _x;
		if !(allTurrets _vec isEqualTo []) then {
			private _ww = _x;
			{
				_vec removeWeaponTurret [_ww, _x];
			} forEach allTurrets _vec;
		};
	};
} forEach _oldweaps;

{
	if !(_x in _oldweaps) then {
		_vec addWeaponGlobal _x;
	};
} forEach _newweaps;

_vec vehicleChat localize "STR_DOM_MISSIONSTRING_1861";