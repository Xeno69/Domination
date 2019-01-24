// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_fixheadbug.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

private "_posasl";
private _unit = _this;
if (!isNull objectParent _unit) exitWith {hintSilent (localize "STR_DOM_MISSIONSTRING_632")};
titleCut [localize "STR_DOM_MISSIONSTRING_633", "black faded", 0];
private _pos = getPosATLVisual _unit;
private _dist = _pos distance _unit;
__TRACE_1("Fixheadbug","_dist")
if (surfaceIsWater _pos) then {_posasl = getPosASL _unit};
private _dir = getDirVisual _unit;
private _vec = d_headbug_vehicle createVehicleLocal [0,0,0];
_vec setPos _pos;
if (surfaceIsWater _pos) then {_vec setPosASL _posasl};
_unit moveincargo _vec;
waitUntil {!isNull objectParent _unit};
unassignVehicle _unit;
_unit action ["getOut", vehicle _unit];
waitUntil {isNull objectParent _unit};
deleteVehicle _vec;
[player, ""] remoteExecCall ["switchMove"];
_pos set [2, _dist];
if (surfaceIsWater _pos) then {_unit setPosASL _posasl} else {_unit setPos _pos};
_unit setDir _dir;
titleCut["", "BLACK IN", 2];