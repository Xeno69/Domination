// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checksimminet.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if (_this isEqualTo "") exitWith {true};

private _miscx = d_misc_s_store getVariable _this;
if (isNil "_miscx") then {
	_miscx = toUpper(getText(configFile>>"CfgAmmo">>_this>>"simulation")) in d_hd_sim_types && {!(toUpper(getText(configFile>>"CfgAmmo">>_this>>"mineTrigger")) in ["UXOTRIGGER1", "UXOTRIGGER2", "UXOTRIGGER3", "UXOTRIGGER4"])};
	d_misc_s_store setVariable [_this, _miscx];
};
_miscx