// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

__TRACE("black out")
"xr_revtxt_wf" cutText [localize "STR_DOM_MISSIONSTRING_920", "PLAIN"];
#define __radius 20
private _endpos = getPosWorld player;
private _markerpos = markerPos "xr_center";
while {surfaceIsWater _endpos} do {
	_endpos = _endpos getPos [__radius, _endpos getDir _markerpos];
	sleep 0.01;
};
_endpos set [2, 0];
[player, _endpos] call d_fnc_setposagls
