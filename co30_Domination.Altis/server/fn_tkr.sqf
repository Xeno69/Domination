// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tkr.sqf"
#include "..\x_setup.sqf"

params ["_unit", "_killer"];
private _par = d_player_store getVariable (getPlayerUID _unit);
__TRACE_1("_unit",_par)
private _namep = [_par # 6, "Unknown"] select (isNil "_par");
__TRACE_1("","_namep")
_par = d_player_store getVariable (getPlayerUID _killer);
__TRACE_1("","_par")
private _namek = [_par # 6, "Unknown"] select (isNil "_par");
__TRACE_1("","_namek")
[_namek, _namep, _killer] call d_fnc_TKKickCheck;
[_namep,_namek] remoteExecCall ["d_fnc_unit_tk2", [0, -2] select isDedicated];