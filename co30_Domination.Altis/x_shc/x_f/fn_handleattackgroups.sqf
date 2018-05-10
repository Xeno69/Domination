// by Xeno
#define THIS_FILE "fn_handleattackgroups.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_grps"];

private _allunits = [];
{
	_allunits append ((units _x) select {alive _x});
	false
} count _grps;

if (_allunits isEqualTo []) exitWith {
	d_c_attacking_grps = [];
	d_create_new_paras = true;
};

sleep 1.2123;

while {!d_mt_radio_down} do {
	if ({alive _x} count _allunits < 4) exitWith {
		d_c_attacking_grps = [];
		d_create_new_paras = true;
	};
	sleep 10.623;
};
