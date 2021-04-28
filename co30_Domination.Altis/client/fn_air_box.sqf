// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_box", "_side"];

player reveal _box;
[_box, _side] call d_fnc_weaponcargo;
_box enableRopeAttach false;
