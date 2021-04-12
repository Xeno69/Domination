// by Xeno
#define THIS_FILE "fn_sidesteal.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

sleep 10.213;

params ["_vec", ["_vpos", []], ["_vdir", -4.5], ["_vtype", ""], ["_docreatearmor", false], ["_docreateinf", false]];

if (isNull _vec) then {
	_vpos set [2, 0];
	_vec = createVehicle [_vtype, _vpos, [], 0, "NONE"];
	_vec setDir _vdir;
	_vec setPos _vpos;
	[_vec, 6] call d_fnc_setekmode;
	_vec setDamage 0;
	sleep 1;
};

if !(_vec isKindOf "Air") then {
	_vec setVariable ["d_liftit", true, true];
};

if (_docreateinf) then {
	["specops", (floor (random 3)) min 1, "allmen", (floor (random 3)) min 1, _vpos, 300, true] spawn d_fnc_CreateInf;
	sleep 2.333;
};
if (_docreatearmor) then {
	[selectRandom ["aa", "tank"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 1, selectRandom ["jeep_mg", "jeep_gl"], 2, _vpos, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 2.333;
	["stat_mg", 1, "stat_gl", 1, "", 0, _vpos, 1, 100, false] spawn d_fnc_CreateArmor;
	sleep 1;
};

private _reached_base = false;
#ifdef __TT__
private _winner = 0;
#endif
private _vma = format ["d_smvecposc_%1", _vec call d_fnc_markername];

private _oldpos = getPosAsl _vec;

[_vma, _oldpos, "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_1584", 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
[_vma, "STR_DOM_MISSIONSTRING_1584"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];

while {alive _vec && {!_reached_base && {!d_sm_resolved}}} do {
#ifndef __TT__
	if (_vec distance2D d_FLAG_BASE < 100 || {!isNil "d_flag_airfield" && {_vec distance2D d_FLAG_BASE < 50}}) exitWith {_reached_base = true};
#else
	if (_vec distance2D d_WFLAG_BASE < 100) exitWith {
		_reached_base = true;
		_winner = 2;
	};
	if (_vec distance2D d_EFLAG_BASE < 100) exitWith {
		_reached_base = true;
		_winner = 1;
	};
#endif
	if (_oldpos distance2D _vec > 10) then {
		_oldpos = getPosAsl _vec;
		_vma setMarkerPos _oldpos;
	};
	sleep 5.2134;
};

if (!d_sm_resolved) then {
	if (alive _vec && {_reached_base}) then {
	#ifndef __TT__
		d_sm_winner = 2;
	#else
		d_sm_winner = _winner;
	#endif
	} else {
		d_sm_winner = -600;
	};
};

deleteMarker _vma;

d_sm_resolved = true;
