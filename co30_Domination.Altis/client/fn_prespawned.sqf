// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

player setVariable ["d_isinaction", false];

if (d_WithMHQTeleport == 0 && {d_WithRevive == 1}) then {
	d_player_in_base = true;
	call d_fnc_dlgopenx;
};

[1, _this] call d_fnc_playerspawn;

{
	if (alive _x) then {
		private _vc = _x getVariable ["d_fl_v_kc", 0];
		if (_vc < 4) then {
			_vc = _vc + 1;
			_x setVariable ["d_fl_v_kc", _vc];
		} else {
			deleteVehicle _x;
			d_player_vecs set [_forEachIndex, -1];
		};
	} else {
		d_player_vecs set [_forEachIndex, -1];
	};
} forEach d_player_vecs;

d_player_vecs = d_player_vecs - [-1];

