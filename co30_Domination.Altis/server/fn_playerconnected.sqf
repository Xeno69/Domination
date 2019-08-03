// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_playerconnected.sqf"
#include "..\x_setup.sqf"

__TRACE_1("Start","_this")

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];


if (_name == "__SERVER__") exitWith {
	diag_log ["DOM playerconnected, Server connect: _this", _this];
};

if (_uid isEqualTo "") exitWith {};

if (_name select [0, 9] == "HC_D_UNIT" || {_name select [0, 14] == "headlessclient"}) exitWith {};

__TRACE_1("End","_this")
