// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_weaponcargo_ranked.sqf"
#include "..\x_setup.sqf"

// bis_fnc_arsenal_data indices
// 0 primary weapon
// 1 launcher
// 2 handgun
// 3 uniform
// 4 vest
// 5 backpack
// 6 helmet
// 7 goggles
// 8 nvgoggles
// 9 binoculars
// 10 map
// 11 GPS, UavTerminal
// 12 Radio
// 13 Compass
// 14 Watch
// 15 Heads
// 16 Voice
// 17 Badge
// 18 ?
// 19 ?
// 20 ?
// 21 ?
// 22 Grenades
// 23 Explosives
// 24 Detectors, First Aid Kit
// 25 ?
// 26 magazines

waitUntil {!d_arsenal_opened};

private _rank = rank player;
private _vec = player;

_vec setVariable ["bis_addVirtualWeaponCargo_cargo", [[], [], [], []]];		

private _helperar = [];

_helperar append (d_misc_store getVariable (_rank + "_RIFLES"));
__TRACE_1("RIFLES","_helperar")

_helperar append (d_misc_store getVariable (_rank + "_LAUNCHERS"));		
__TRACE_1("LAUNCHERS","_helperar")

_helperar append (d_misc_store getVariable (_rank + "_PISTOLS"));
__TRACE_1("PISTOLS","_helperar")

[_vec, _helperar, false, false] call BIS_fnc_addVirtualWeaponCargo;
[_vec, bis_fnc_arsenal_data # 7, false, false] call BIS_fnc_addVirtualItemCargo;

_helperar =+ bis_fnc_arsenal_data # 10;
_helperar = _helperar - ["ItemMap"];
[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;
_helperar =+ bis_fnc_arsenal_data # 11;
_helperar = _helperar - ["ItemGPS"];
[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;
_helperar =+ bis_fnc_arsenal_data # 12;
_helperar = _helperar - ["ItemRadio"];
[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;
_helperar =+ bis_fnc_arsenal_data # 13;
_helperar = _helperar - ["ItemCompass"];
[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;
_helperar =+ bis_fnc_arsenal_data # 14;
_helperar = _helperar - ["ItemWatch"];
[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;

[_vec, bis_fnc_arsenal_data # 22, false, false] call BIS_fnc_addVirtualMagazineCargo;
[_vec, bis_fnc_arsenal_data # 23, false, false] call BIS_fnc_addVirtualMagazineCargo;
[_vec, bis_fnc_arsenal_data # 26, false, false] call BIS_fnc_addVirtualMagazineCargo;

_helperar = [];

_helperar append (d_misc_store getVariable (_rank + "_OPTICS"));
__TRACE_1("OPTICS","_helperar")

_helperar append (d_misc_store getVariable (_rank + "_MUZZLES"));
__TRACE_1("MUZZLES","_helperar")

_helperar append (d_misc_store getVariable (_rank + "_UNIFORMS"));
__TRACE_1("UNIFORMS","_helperar")

_helperar append (d_misc_store getVariable (_rank + "_ITEMS"));
__TRACE_1("ITEMS","_helperar")

[_vec, _helperar, false, false] call BIS_fnc_addVirtualItemCargo;

[_vec, bis_fnc_arsenal_data # 5, false, false] call BIS_fnc_addVirtualBackpackCargo;
