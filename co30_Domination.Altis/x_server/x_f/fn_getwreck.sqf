// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getwreck.sqf"
#include "..\..\x_setup.sqf"

params ["_rep_station", "_types"];
private _no = nearestObjects [_rep_station, _types, 10, false];
if (_no isEqualTo []) exitWith {objNull};
[objNull, _no # 0] select (damage (_no # 0) >= 1)
