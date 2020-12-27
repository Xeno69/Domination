// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_weaponcargo_ranked.sqf"
#include "..\x_setup.sqf"

// bis_fnc_arsenal_data indices
// PRIMARYWEAPON    0
// SECONDARYWEAPON    1
// HANDGUN            2
// UNIFORM            3
// VEST            4
// BACKPACK        5
// HEADGEAR        6
// GOGGLES            7
// NVGS            8
// BINOCULARS        9
// MAP                10
// GPS                11
// RADIO            12
// COMPASS            13
// WATCH            14
// FACE            15
// VOICE            16
// INSIGNIA        17
// ITEMOPTIC        18
// ITEMACC            19
// ITEMMUZZLE        20
// CARGOMAG        21
// CARGOTHROW        22
// CARGOPUT        23
// CARGOMISC        24
// ITEMBIPOD        25
// CARGOMAGALL        26

waitUntil {!d_arsenal_opened};

private _rank = rank player;
private _vec = player;

_vec setVariable ["bis_addVirtualWeaponCargo_cargo", [[], [], [], []]];		

private _helperar = [];

_helperar append (d_misc_hash get (_rank + "_RIFLES"));
__TRACE_1("RIFLES","_helperar")

_helperar append (d_misc_hash get (_rank + "_LAUNCHERS"));		
__TRACE_1("LAUNCHERS","_helperar")

_helperar append (d_misc_hash get (_rank + "_PISTOLS"));
__TRACE_1("PISTOLS","_helperar")

[_vec, _helperar, false, false] call BIS_fnc_addVirtualWeaponCargo;
[_vec, bis_fnc_arsenal_data # 7, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 8, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 9, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 10, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 11, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 12, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 13, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 14, false, false] call BIS_fnc_addVirtualItemCargo;
[_vec, bis_fnc_arsenal_data # 24, false, false] call BIS_fnc_addVirtualItemCargo;

[_vec, bis_fnc_arsenal_data # 22, false, false] call BIS_fnc_addVirtualMagazineCargo;
[_vec, bis_fnc_arsenal_data # 23, false, false] call BIS_fnc_addVirtualMagazineCargo;
[_vec, bis_fnc_arsenal_data # 26, false, false] call BIS_fnc_addVirtualMagazineCargo;

_helperar = [];

_helperar append (d_misc_hash get (_rank + "_OPTICS"));
__TRACE_1("OPTICS","_helperar")

_helperar append (d_misc_hash get (_rank + "_MUZZLES"));
__TRACE_1("MUZZLES","_helperar")

if ((d_misc_hash getOrDefault ["private_uniforms", []]) isEqualTo []) then {
	_helperar append d_usave;
} else {
	_helperar append (d_misc_hash get (_rank + "_UNIFORMS"));
};
__TRACE_1("UNIFORMS","_helperar")

_helperar append (d_misc_hash get (_rank + "_ITEMS"));
__TRACE_1("ITEMS","_helperar")

[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;


[_vec, d_misc_hash get (_rank + "_BAGS"), false, false] call BIS_fnc_addVirtualBackpackCargo;

[_vec, d_misc_hash get (_rank + "_VESTS"), false, false] call BIS_fnc_addVirtualItemCargo;
