// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!alive player) exitWith {};

params ["_person", "_visionMode"];

if (_person != player) exitWith {};

player setVariable ["d_currentvisionmode", _visionMode];
