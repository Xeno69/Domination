// by Xeno
#define THIS_FILE "fn_air_box.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_box", "_side"];

player reveal _box;
[_box, _side] call d_fnc_weaponcargo;
_box enableRopeAttach false;
