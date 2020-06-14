// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_remactionssm.sqf"
#include "..\x_setup.sqf"
__TRACE_1("","_this")

if (!hasInterface) exitWith {};

params ["_obj"];

private _idx = _obj getVariable "d_sm_holdactionidx";
if (isNil "_idx") exitWith {};

[_obj, _idx] call BIS_fnc_holdActionRemove;