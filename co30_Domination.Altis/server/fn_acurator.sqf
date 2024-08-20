// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_newu", "_cur"];

private _ltime = _newu getVariable "d_lr_ti";

if (isNil "_ltime") exitWith {};

if (time - _ltime > 10) exitWith {};

_newu assignCurator _cur;
