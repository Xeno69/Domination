// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dropammoboxdx.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_unit", "_caller"];

__TRACE_2("","_unit","_caller")

if (_unit == _caller) then {_unit = d_curvec_dialog};

private _chatfunc = {
	if (vehicle (param [1]) == (param [0])) then {
		(param [0]) vehicleChat (param [2]);
	} else {
		(param [1]) sideChat (param [2]);
	};
};

if (_caller != driver _unit && {!isNil {_unit getVariable "d_choppertype"} && {_unit getVariable ["d_vec_type", ""] != "MHQ"}}) exitWith {
	[_unit, _caller, localize "STR_DOM_MISSIONSTRING_1428"] call _chatfunc;
};

if (d_all_ammoloads findIf {_x distance2D _unit < 20} > -1) exitWith {[_unit, _caller, localize "STR_DOM_MISSIONSTRING_217"] call _chatfunc};

if ((_unit call d_fnc_GetHeight) > 3) exitWith {_unit vehicleChat (localize "STR_DOM_MISSIONSTRING_218")};

if (speed _unit > 3) exitWith {_unit vehicleChat (localize "STR_DOM_MISSIONSTRING_219")};

if (d_num_ammo_boxes > d_MaxNumAmmoboxes) exitWith {
	[_unit, _caller, format [localize "STR_DOM_MISSIONSTRING_220", d_MaxNumAmmoboxes]] call _chatfunc;
};

if !(_unit getVariable ["d_ammobox", false]) exitWith {[_unit, _caller, localize "STR_DOM_MISSIONSTRING_222"] call _chatfunc};

if ((_unit getVariable ["d_ammobox_next", -1]) > time) exitWith {[_unit, _caller, format [localize "STR_DOM_MISSIONSTRING_223", round ((_unit getVariable "d_ammobox_next") - time)]] call _chatfunc};

[_unit, _caller, localize "STR_DOM_MISSIONSTRING_224"] call _chatfunc;

_unit setVariable ["d_ammobox", false, true];
_unit setVariable ["d_ammobox_next", time + d_drop_ammobox_time, true];

private _boxpos = _unit modelToWorldVisual [4,0,0];
__TRACE_1("","_boxpos")
(boundingBoxReal _unit) params ["_p1", "_p2"];
private _maxHeight = abs ((_p2 # 2) - (_p1 # 2)) / 2;
__TRACE_1("","_maxHeight")
_boxpos set [2, ((_unit distance (getPos _unit)) - _maxHeight) max 0];
__TRACE_1("","_boxpos")

#ifndef __TT__
[_boxpos, _unit] remoteExecCall ["d_fnc_CreateDroppedBox", 2];
#else
[_boxpos, _unit, d_player_side] remoteExecCall ["d_fnc_CreateDroppedBox", 2];
#endif

[_unit, _caller, localize "STR_DOM_MISSIONSTRING_225"] call _chatfunc;