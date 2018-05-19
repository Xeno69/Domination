// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_unload_static.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_vec"];

d_cargo_selected_index = -1;

if (d_no_ai && {!(player getUnitTrait "engineer")}) exitWith {hintSilent (localize "STR_DOM_MISSIONSTRING_79")};

private _tr_cargo_ar = _vec getVariable ["d_CARGO_AR", []];

if (_tr_cargo_ar isEqualTo []) exitWith {};
	
d_current_truck_cargo_array = _tr_cargo_ar;
createDialog "d_UnloadDialog";

waitUntil {!isNil "d_unload_dialog_open" && {d_cargo_selected_index != -1 || {!d_unload_dialog_open || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}}}};

if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {if (d_unload_dialog_open) then {closeDialog 0}};

if (d_cargo_selected_index == -1) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_82")};

if ((d_cargo_selected_index + 1) > count _tr_cargo_ar) exitWith {
	hintSilent (localize "STR_DOM_MISSIONSTRING_83");
};

private _cargo = _tr_cargo_ar # d_cargo_selected_index;
_tr_cargo_ar deleteAt d_cargo_selected_index;

_vec setVariable ["d_CARGO_AR", _tr_cargo_ar, true];

private _pos_to_set = player modelToWorldVisual [0,5,0];
private _static = _cargo createVehicleLocal [0,0,0];
_static setPos _pos_to_set;
_static lock false;
private _dir_to_set = getDir player;

private _place_error = false;
systemChat (localize "STR_DOM_MISSIONSTRING_84");
d_e_placing_running = 0; // 0 = running, 1 = placed, 2 = placing canceled
d_e_placing_id1 = player addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_85"], {
	private _caller = _this select 1;
	d_e_placing_running = 2;
	_caller removeAction (_this select 2);
	_caller removeAction d_e_placing_id2;
	d_e_placing_id1 = -1000;
	d_e_placing_id2 = -1000;
}];
d_e_placing_id2 = player addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_86"], {
	private _caller = _this select 1;
	private _id = _this select 2;
	d_e_placing_running = 1;
	_caller removeAction _id;
	_caller removeAction d_e_placing_id1;
	d_e_placing_id1 = -1000;
	d_e_placing_id2 = -1000;
},[], 0];
while {d_e_placing_running == 0} do {
	_pos_to_set = player modelToWorldVisual [0,5,0];
	_dir_to_set = getDir player;

	_static setDir _dir_to_set;
	_static setPos [_pos_to_set # 0, _pos_to_set # 1, 0];
	sleep 0.211;
	if (_vec distance2D player > 20) exitWith {
		systemChat (localize "STR_DOM_MISSIONSTRING_87");
		_place_error = true;
	};
	if (!alive player || {!alive _vec || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}) exitWith {
		_place_error = true;
		if (d_e_placing_id1 != -1000) then {
			player removeAction d_e_placing_id1;
			d_e_placing_id1 = -1000;
		};
		if (d_e_placing_id2 != -1000) then {
			player removeAction d_e_placing_id2;
			d_e_placing_id2 = -1000;
		};
	};
};

deleteVehicle _static;

if (_place_error) exitWith {
	_tr_cargo_ar pushBack _cargo;
	_vec setVariable ["d_CARGO_AR", _tr_cargo_ar, true];
};

if (d_e_placing_running == 2) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_88");
	_tr_cargo_ar pushBack _cargo;
	_vec setVariable ["d_CARGO_AR", _tr_cargo_ar, true];
};

_static = createVehicle [_cargo, _pos_to_set, [], 0, "NONE"];
_static setDir _dir_to_set;
_static setPos [_pos_to_set # 0, _pos_to_set # 1, 0];
player reveal _static;
_static lock false;
_static remoteExecCall ["d_fnc_allunits_add", 2];

private _str_placed = format [localize "STR_DOM_MISSIONSTRING_89", [_cargo, "CfgVehicles"] call d_fnc_GetDisplayName];
hintSilent _str_placed;
systemChat _str_placed;
