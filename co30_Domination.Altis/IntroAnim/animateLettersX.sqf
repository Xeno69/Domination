#define THIS_FILE "animateLettersX.sqf"
#include "..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_pre_spaces", "_string", "_line"];

private _out_chars = [];

for "_i" from 1 to _pre_spaces do {_out_chars pushBack " "};

for "_i" from 0 to ((count _string) - 1) do {_out_chars pushBack (_string select [_i, 1])};

if (count _out_chars < 30) then {for "_i" from ((count _out_chars) + 1) to 30 do {_out_chars pushBack " "}};

[_out_chars, _line] execVM "IntroAnim\animateLetters.sqf";