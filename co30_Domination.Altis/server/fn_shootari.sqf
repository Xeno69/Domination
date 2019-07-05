// by Xeno
#define THIS_FILE "fn_shootari.sqf"
#include "..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_pos_enemy", "_kind"];

private _which = [d_ArtyShellsBlufor, d_ArtyShellsOpfor] select (d_enemy_side == "EAST");
private _height = 150;

private _type = call {
	if (_kind == 0) exitWith {_which # 2};
	if (_kind == 1) exitWith {_which # 0};
	_height = 1; _which # 1
};

private _num_shells = if (_kind in [0, 1]) then {
#ifndef __TT__
	if (d_searchintel # 4 == 1) then {
#else
	if (floor random 3 == 0) then {
#endif
		[_pos_enemy, 0] remoteExecCall ["d_fnc_doarti", [0, -2] select isDedicated];
	};
	3 + (ceil random 3)
} else {
	1
}; 

sleep 9.25 + (random 8);
for "_i" from 0 to (_num_shells - 1) do {
	private _npos = _pos_enemy getPos [random 30, floor random 360];
	_npos set [2, _height];
	private _shell = createVehicle [_type, _npos, [], 0, "NONE"];
	_shell setVelocity [0, 0, -150];
	 sleep 0.923 + ((ceil random 10) / 10);
};
