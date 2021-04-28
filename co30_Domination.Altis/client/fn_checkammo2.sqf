// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

#define __shots ["shotbullet","shotshell","shotrocket","shotmissile","shottimebomb","shotmine","shotgrenade","shotspread","shotsubmunitions","shotdeploy","shotboundingmine","shotdirectionalbomb"]

if ((_this # 4) isEqualTo "") exitWith {false};

private _v = d_misc_sc_hash2 getOrDefault [_this # 4, -1];
if (_v isEqualType 1) then {
	_v = (toLowerANSI getText (configFile>>"CfgAmmo">>(_this # 4)>>"simulation")) in __shots;
	d_misc_sc_hash2 set [_this # 4, _v];
};

__TRACE_1("","_v")

_v
