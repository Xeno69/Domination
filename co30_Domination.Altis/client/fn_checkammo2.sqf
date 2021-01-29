// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkammo2.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

#define __shots ["shotBullet","shotShell","shotRocket","shotMissile","shotTimeBomb","shotMine","shotGrenade","shotSpread","shotSubmunitions","shotDeploy","shotBoundingMine","shotDirectionalBomb"]

if (_this isEqualTo "") exitWith {false};

private _v = d_misc_sc_store getVariable _this;
if (isNil "_v") then {
	_v = getText (configFile>>"CfgAmmo">>_this>>"simulation") in __shots;
	d_misc_sc_store setVariable [_this, _v];
};

__TRACE_1("","_v")

_v
