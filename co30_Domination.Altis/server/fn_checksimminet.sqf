// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checksimminet.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (_this isEqualTo "") exitWith {true};

private _miscx = d_misc_s_store getVariable _this;
if (isNil "_miscx") then {
	_miscx = toLower(getText(configFile>>"CfgAmmo">>_this>>"simulation")) in d_hd_sim_types && {!(toLower(getText(configFile>>"CfgAmmo">>_this>>"mineTrigger")) in ["uxotrigger1", "uxotrigger2", "uxotrigger3", "uxotrigger4"])};
	d_misc_s_store setVariable [_this, _miscx];
};
_miscx