// by Xeno
#define THIS_FILE "fn_handleattackgroups.sqf"
#include "..\..\x_setup.sqf"

params ["_grps"];

private _allunits = [];
{
	_allunits append ((units _x) select {alive _x});
} forEach _grps;

if (_allunits isEqualTo []) exitWith {
	d_c_attacking_grps = [];
	d_create_new_paras = true;
};

sleep 1.2123;

private _waitiime = time + 240;
while {!d_mt_radio_down} do {
	if ({alive _x} count _allunits < 4) exitWith {
		d_c_attacking_grps = [];
		while {time < _waitiime && {!d_mt_radio_down}} do {
			sleep 1;
		};
		if (!d_mt_radio_down) then {
			d_create_new_paras = true;
		};
	};
	sleep 5;
};
