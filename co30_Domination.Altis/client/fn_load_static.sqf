// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_load_static.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_vec"];

if (d_no_ai && {!(player getUnitTrait "engineer")}) exitWith {
	hintSilent (localize "STR_DOM_MISSIONSTRING_68");
};

private _tr_cargo_ar = _vec getVariable ["d_CARGO_AR", []];

if (count _tr_cargo_ar >= d_max_truck_cargo) exitWith {
	systemChat format [localize "STR_DOM_MISSIONSTRING_69", d_max_truck_cargo];
};

private _cargo = nearestObject [_vec, "StaticWeapon"];
if (isNull _cargo) exitWith {hintSilent (localize "STR_DOM_MISSIONSTRING_70")};
if (!alive _cargo) exitWith {hintSilent (localize "STR_DOM_MISSIONSTRING_71")};

private _type_name = [_cargo] call d_fnc_GetDisplayName;
if (_cargo distance2D _vec > 10) exitwith {hintSilent format [localize "STR_DOM_MISSIONSTRING_72", _type_name]};
if (!d_player_canu) exitWith {};

if (player getVariable ["d_currently_loading", false]) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_73")};

player setVariable ["d_currently_loading", true];
_tr_cargo_ar = _vec getVariable ["d_CARGO_AR", []];
if (count _tr_cargo_ar >= d_max_truck_cargo) then {
	systemChat format [localize "STR_DOM_MISSIONSTRING_69", d_max_truck_cargo];
} else {
	_tr_cargo_ar pushBack (typeOf _cargo);
	_vec setVariable ["d_CARGO_AR", _tr_cargo_ar, true];
};
private _alive = true;
for "_i" from 10 to 1 step -1 do {
	hintSilent format [localize "STR_DOM_MISSIONSTRING_74", _type_name, _i];
	if (!d_player_canu || {!alive _vec}) exitWith {_alive = false};
	sleep 1;
};
if (_alive) then {
	deleteVehicle _cargo;
	hintSilent format [localize "STR_DOM_MISSIONSTRING_75", _type_name];
};
player setVariable ["d_currently_loading", false];
