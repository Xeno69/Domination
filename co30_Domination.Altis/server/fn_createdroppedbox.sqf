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
if (d_with_dynsim == 0) then {
	[_box, 5] spawn d_fnc_enabledynsim;
};
private _percent = (_this # 1) getVariable "d_abox_perc";
if (!isNil "_percent") then {
	_box setVariable ["d_abox_perc", _percent, true];
	(_this # 1) setVariable ["d_abox_perc", nil, true];
};
#ifndef __TT__
private _mname = format ["d_bm_%1", _box call d_fnc_markername];
d_ammo_boxes pushBack [d_dbox_idx, _box, _mname];
_box setVariable ["d_box_params", [d_dbox_idx, _box, _mname]]:
#else
private _mbegin = ["d_bm_opf_%1", "d_bm_blu_%1"] select (_this # 2 == blufor);
private _mname = format [_mbegin, _box call d_fnc_markername];
d_ammo_boxes pushBack [d_dbox_idx, _box, _mname, _this # 2];
_box setVariable ["d_box_params", [d_dbox_idx, _box, _mname, _this # 2]];
#endif
publicVariable "d_ammo_boxes";
d_dbox_idx = d_dbox_idx + 1;
[_mname, _box, "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_523", 0, d_dropped_box_marker] call d_fnc_CreateMarkerGlobal;
[_mname, "STR_DOM_MISSIONSTRING_523"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
#ifdef __TT__
_mname remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select ((_this # 2) == blufor)];
#endif
if (d_with_ace) then {
	[_box, _mname] spawn d_fnc_moveboxm;
};

[_box, 12] call d_fnc_setekmode;

_this set [0, _box];
_this remoteExecCall ["d_fnc_create_boxNet", [0, -2] select isDedicated];
