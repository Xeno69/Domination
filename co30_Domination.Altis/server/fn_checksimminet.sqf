// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (_this isEqualTo "") exitWith {true};

d_misc_s_hash getOrDefaultCall [_this, {
	toLowerANSI(getText(configFile>>"CfgAmmo">>_this>>"simulation")) in d_hd_sim_types && {!(toLowerANSI(getText(configFile>>"CfgAmmo">>_this>>"mineTrigger")) in ["uxotrigger1", "uxotrigger2", "uxotrigger3", "uxotrigger4"])}
}, true];
