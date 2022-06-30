//#define __DEBUG__
//#include "..\x_setup.sqf"

params ["_unit"];
private _pos = getPosATL _unit;
private _start = +_pos;
_start set [2, 100];
while {lineIntersects [ATLToASL _start, ATLToASL _pos]} do {
	_pos set [2, (_pos # 2) + 0.25]
};
_unit setPosATL _pos;
