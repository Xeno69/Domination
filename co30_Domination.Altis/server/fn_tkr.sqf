// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tkr.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_unit", "_killer"];
private _namep = name _unit;
private _namek = name _killer;
[_namek, _namep, _killer] call d_fnc_TKKickCheck;
[_namep,_namek] remoteExecCall ["d_fnc_unit_tk2", [0, -2] select isDedicated];