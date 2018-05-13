// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vehiclescripts.sqf"
#include "..\..\x_setup.sqf"

private _vec = param [2];

if ((_vec isKindOf "ParachuteBase") || {_vec isKindOf "BIS_Steerable_Parachute"}) exitWith {};
private _do_exit = false;
if (_vec isKindOf "Air") then {
	if (_vec isKindOf "Helicopter") then {
		0 spawn d_fnc_chop_hudsp;
		// currently the only way to disable slingload assistant and rope action for sling loadling.
		// sadly yet another Arma bug is not fixed, therefore inputAction is also needed... http://feedback.arma3.com/view.php?id=20845
		d_heli_kh_ro = (findDisplay 46) displayAddEventHandler ["KeyDown", {(param [1] in actionKeys "HeliRopeAction" || {param [1] in actionKeys "HeliSlingLoadManager" || {inputAction "HeliRopeAction" > 0 || {inputAction "HeliSlingLoadManager" > 0}}})}];
	};
	if (d_pilots_only == 0 && {!(call d_fnc_isPilotCheck) && {param [1] == "driver"}}) then {
		player action ["getOut", _vec];
		hintSilent localize "STR_DOM_MISSIONSTRING_1417";
		_do_exit = true;
	};
} else {
	if ((_vec isKindOf "LandVehicle" && {!(_vec isKindOf "StaticWeapon")}) || {_vec isKindOf "StaticWeapon" && {!(_vec isKindOf "StaticATWeapon")}}) then {
		[_vec] spawn d_fnc_vec_hudsp;
	};
	if (d_MHQDisableNearMT != 0 && {!d_playerInMHQ && {(_vec getVariable ["d_vec_type", ""]) == "MHQ"}}) then {
		d_playerInMHQ = true;
		[_vec] spawn d_fnc_mhqCheckNearTarget;
	};
};
if (_do_exit) exitWith {};

if (d_with_ranked || {d_database_found}) then {
	if (_vec isKindOf "Car" || {_vec isKindOf "Air"}) then {
		[_vec] spawn d_fnc_playervectrans;
	};
	if (d_with_ranked) then {
		[_vec] call d_fnc_playerveccheck;
	};
};
if (d_without_vec_ti == 0) then {
	_vec disableTIEquipment true;
};
if (d_without_vec_nvg == 0) then {
	_vec disableNVGEquipment true;
};

if (toUpper (typeOf _vec) in d_check_ammo_load_vecs) then {
	{
		[_x] execFSM "fsms\fn_AmmoLoad.fsm";
		false
	} count d_all_ammoloads;
};
