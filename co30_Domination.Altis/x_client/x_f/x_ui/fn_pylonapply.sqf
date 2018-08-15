// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pylonapply.sqf"
#include "..\..\..\x_setup.sqf"

disableSerialization;

private _vec = vehicle player;

__TRACE_1("","count d_pylondialog_ctrls")
__TRACE_1("","d_pylondialog_ctrls")

private _prevweaps = getPylonMagazines _vec apply {getText (configFile>>"CfgMagazines">>_x>> "pylonWeapon")};
__TRACE_1("","_prevweaps")

private _cfg = configFile>>"CfgVehicles">>(typeOf _vec)>>"Components">>"TransportPylonsComponent">>"pylons";
for "_i" from 0 to (count _cfg - 1) do {
	_ctrl = d_pylondialog_ctrls select _i;
	_vec setPylonLoadOut [configName (_cfg select _i), _ctrl lbData (lbCurSel _ctrl), true];
};

private _newweaps = getPylonMagazines _vec apply {getText (configFile>>"CfgMagazines">>_x>> "pylonWeapon")};
__TRACE_1("","_newweaps")

private _oldweaps = [];
{
	if (_x != "") then {
		_oldweaps pushBackUnique _x;
	};
} forEach _prevweaps;

__TRACE_1("","_oldweaps")

{
	if !(_x in _newweaps) then {
		_vec removeWeaponGlobal _x;
	};
} forEach _oldweaps;

_vec vehicleChat localize "STR_DOM_MISSIONSTRING_1861";