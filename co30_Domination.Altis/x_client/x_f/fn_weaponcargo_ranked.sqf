// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_weaponcargo_ranked.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_vec"];

private _old_rank = "";
while {alive _vec} do {
	if (_old_rank != rank player) then {
		clearMagazineCargo _vec;
		clearWeaponCargo _vec;
		clearItemCargo _vec;
		clearBackpackCargo _vec;

		_old_rank = rank player;
		
		_vec setVariable ["bis_addVirtualWeaponCargo_cargo", [[], [], [], []]];		

		waitUntil {time > 0};
		private _helperar = [];
		private _curar = d_misc_store getVariable (_old_rank + "_RIFLES");
		__TRACE_1("RIFLES","_curar")
		{
			_helperar pushBack (_x # 0);
			false
		} count _curar;
		__TRACE_1("RIFLES","_helperar")

		_curar = d_misc_store getVariable (_old_rank + "_LAUNCHERS");
		__TRACE_1("LAUNCHERS","_curar")
		{
			_helperar pushBack (_x # 0);
			false
		} count _curar;
		__TRACE_1("LAUNCHERS","_helperar")
		_curar = d_misc_store getVariable (_old_rank + "_PISTOLS");
		__TRACE_1("PISTOLS","_curar")
		{
			_helperar pushBack (_x # 0);
			false
		} count _curar;
		__TRACE_1("PISTOLS","_helperar")
		[_vec, _helperar, false, false] call BIS_fnc_addVirtualWeaponCargo;

		_helperar = [];
		_curar = d_all_magazines;
		__TRACE_1("Mags","_curar")
		_helperar resize (count _curar);
		{
			_helperar set [_forEachIndex, _x # 0];
		} forEach _curar;
		__TRACE_1("Mags","_helperar")
		[_vec, _helperar, false, false] call BIS_fnc_addVirtualMagazineCargo;

		_helperar = [];
		_curar = d_misc_store getVariable (_old_rank + "_OPTICS");
		__TRACE_1("OPTICS","_curar")
		{
			_helperar pushBack (_x # 0);
			false
		} count _curar;
		__TRACE_1("OPTICS","_helperar")
		_curar = d_misc_store getVariable (_old_rank + "_MUZZLES");
		__TRACE_1("MUZZLES","_curar")
		{
			_helperar pushBack (_x # 0);
			false
		} count _curar;
		__TRACE_1("MUZZLES","_helperar")
		_curar = d_misc_store getVariable (_old_rank + "_UNIFORMS");
		__TRACE_1("UNIFORMS","_curar")
		{
			_helperar pushBack (_x # 0);
			false
		} count _curar;
		__TRACE_1("UNIFORMS","_helperar")
		_curar = d_misc_store getVariable (_old_rank + "_ITEMS");
		__TRACE_1("ITEMS","_curar")
		{
			_helperar pushBack (_x # 0);
			false
		} count _curar;
		__TRACE_1("ITEMS","_helperar")
		[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;

		_helperar = [];
		_curar = d_backpackclasses;
		__TRACE_1("Backpacks","_curar")
		_helperar resize (count _curar);
		{
			_helperar set [_forEachIndex, _x];
		} forEach _curar;
		__TRACE_1("Backpacks","_helperar")
		[_vec, _helperar, false, false] call BIS_fnc_addVirtualBackpackCargo;
	};
	sleep 2.32;
};
