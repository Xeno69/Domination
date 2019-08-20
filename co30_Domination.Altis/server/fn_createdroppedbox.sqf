// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createdroppedbox.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_box_pos"];

private _box = createVehicle [d_the_box, [0, 0, 0], [], 0, "NONE"];
_box setPos _box_pos;
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearItemCargoGlobal _box;
_box enableRopeAttach false;
private _mname = format ["d_bm_%1", _box];
#ifndef __TT__
d_ammo_boxes pushBack [_box, _mname];
_box setVariable ["d_box_params", [_box, _mname]]:
#else
d_ammo_boxes pushBack [_box, _mname, _this select 2];
_box setVariable ["d_box_params", [_box, _mname, _this select 2]];
#endif
publicVariable "d_ammo_boxes";
[_mname, _box, "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_523", 0, d_dropped_box_marker] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
_mname remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (_this select 2 == blufor)];
#endif

[_box, 12] call d_fnc_setekmode;

_this set [0, _box];
_this remoteExecCall ["d_fnc_create_boxNet", [0, -2] select isDedicated];
