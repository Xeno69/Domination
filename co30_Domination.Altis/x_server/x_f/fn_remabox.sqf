// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_remabox.sqf"
#include "..\..\x_setup.sqf"

params ["_bpos"];
if (_bpos isEqualType 1) exitWith {};
private _fidx = d_ammo_boxes findIf {(_x # 0) distance2D _bpos < 10};
if (_fidx > -1) then {
	deleteMarker (d_ammo_boxes # _fidx # 1);
	d_ammo_boxes deleteAt _fidx;
};
publicVariable "d_ammo_boxes";

_this remoteExecCall ["d_fnc_RemABoxC", [0, -2] select isDedicated];
