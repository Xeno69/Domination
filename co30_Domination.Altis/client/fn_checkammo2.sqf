// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

#define __shots ["shotbullet","shotshell","shotrocket","shotmissile","shottimebomb","shotmine","shotgrenade","shotspread","shotsubmunitions","shotdeploy","shotboundingmine","shotdirectionalbomb"]

if ((_this # 4) isEqualTo "") exitWith {false};

d_misc_sc_hash2 getOrDefaultCall [_this # 4, {private _v = (toLowerANSI getText (configFile>>"CfgAmmo">>(_this # 4)>>"simulation")) in __shots; if (_this # 4 == "rhs_ammo_m84") then {_v = false}; _v}, true];
