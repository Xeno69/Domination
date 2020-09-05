// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pylonapply.sqf"
#include "..\x_setup.sqf"

disableSerialization;

private _vec = d_pylon_vec;

private _alreadyremoved = [];
{
	_pyweap = getText (configFile>>"CfgMagazines">>_x>>"pylonWeapon");
	if (_alreadyremoved pushBackUnique _pyweap != -1) then {
		_vec removeWeaponGlobal _pyweap;
		_vec removeWeaponTurret [_pyweap, [-1]];
	};
} forEach getPylonMagazines _vec;
__TRACE_1("2","weapons _vec")

private _cfg = (configOf _vec)>>"Components">>"TransportPylonsComponent">>"pylons";
private _pylonowners = _vec getVariable ["d_pylon_owners", []];
__TRACE_1("","_pylonowners")
private _oldpylonowners =+ _pylonowners;
for "_i" from 0 to (count _cfg - 1) do {
	private _ctrl = d_pylondialog_ctrls select _i;
	private _mag = _ctrl lbData (lbCurSel _ctrl);
	__TRACE_1("","_mag")
	private _cname = configName (_cfg select _i);
	__TRACE_1("","_cname")
	if (_mag != "") then {
		private _ctrl_drivgun = _ctrl getVariable "d_turret_ctrl";
		if (!isNil "_ctrl_drivgun") then {
			private _turtype = [[], [0]] select (_ctrl_drivgun getVariable "d_cursel_gundriv" == 1);
			__TRACE_1("","_turtype")
			_vec setPylonLoadOut [_cname, _mag, true, _turtype];
			if !(_pylonowners isEqualTo []) then {
				_pylonowners set [_i, _turtype];
			};
		} else {
			__TRACE("_ctrl_drivgun is nil")
			_vec setPylonLoadOut [_cname, _mag, true, getArray ((configOf _vec)>>"Components">>"TransportPylonsComponent">>"Pylons">>_cname>>"turret")];
		};
	} else {
		__TRACE("no pylon")
		_vec setPylonLoadOut [_cname, "", true];
	};
};
__TRACE_1("3","weapons _vec")

if !(_pylonowners isEqualTo _oldpylonowners) then {
	_vec setVariable ["d_pylon_owners", _pylonowners, true];
};

_vec vehicleChat localize "STR_DOM_MISSIONSTRING_1861";
