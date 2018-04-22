// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_removenvgoggles_fak.sqf"
#include "..\..\x_setup.sqf"

if (d_without_nvg == 0) then {
	private _hmd = hmd _this;

	if (_hmd != "" && {getText(configFile>>"CfgWeapons">>_hmd>>"simulation") == "NVGoggles"}) then {
		_this unlinkItem _hmd;
	};
};

if (d_no_faks == 0) then {
	_this removeItem "FirstAidKit";
};
