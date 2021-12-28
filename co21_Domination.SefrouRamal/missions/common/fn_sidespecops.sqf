// by Xeno
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_poss", ["_radius_p", 150]];

private _fire = createVehicle ["Campfire_burning_F", _poss, [], 0, "NONE"];
_fire setPos _poss;
d_x_sm_vec_rem_ar pushBack _fire;
sleep 0.01;

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
#endif

private _angle = 0;
private _angle_plus = 360 / 4;

for "_i" from 0 to 3 do {
	private _npos = _poss getPos [5, _angle];
	private _tent = createVehicle [d_sm_tent, _npos, [], 0, "NONE"];
	_tent setDir _angle;
	_tent setPos _npos;
	d_x_sm_vec_rem_ar pushBack _tent;
	_angle = _angle + _angle_plus;
	sleep 0.2321;
};

private _grps = ["specops", 3, "allmen", 0, _poss , _radius_p, true, false, -1, false] call d_fnc_CreateInf;
private _units = [];
{
	_units append (units _x);
} forEach _grps;

d_num_species = 0;

{
	_x allowFleeing 0;
	_x addEventHandler ["killed", {
		d_num_species = d_num_species + 1;
		(_this # 0) removeAllEventHandlers "killed";
	}];
#ifdef __TT__
	_x addEventHandler ["handleDamage", {call d_fnc_AddSMPoints}];
#endif
} forEach _units;

sleep 2.123;
private _endnum = (count _units) - 2;

while {d_num_species < _endnum} do {
	{
		if (_x distance2D _poss >= 400) then {
			_x setDamage 1;
			sleep 0.1;
		};
	} forEach (_units select {alive _x});
	sleep 4.631;
	if (d_sm_resolved) exitWith {};
};

_units = nil;

if (!d_sm_resolved) then {
#ifndef __TT__
	d_sm_winner = 2;
#else
	if (d_sm_points_blufor > d_sm_points_opfor) then {
		d_sm_winner = 2;
	} else {
		if (d_sm_points_opfor > d_sm_points_blufor) then {
			d_sm_winner = 1;
		} else {
			if (d_sm_points_opfor == d_sm_points_blufor) then {
				d_sm_winner = 123;
			};
		};
	};
#endif
};

d_sm_resolved = true;
d_num_species = nil;