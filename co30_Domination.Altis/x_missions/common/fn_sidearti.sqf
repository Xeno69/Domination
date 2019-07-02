// by Xeno
#define THIS_FILE "fn_sidearty.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_poss"];

#ifndef __TT__
d_sm_arty_crewman = getText (configFile>>"CfgVehicles">>d_sm_arty>>"crew");
#else
d_sm_arty_crewman = "I_Crew_F";
#endif

// calc positions
private _angle = 0;
private _pos_array = [];
#define __count_arti 8
private _angle_plus = 360 / __count_arti;

for "_i" from 0 to __count_arti - 1 do {
	private _npos = _poss getPos [30, _angle];
	_npos set [2, 0];
	_pos_array pushBack [_npos, _angle];
	_angle = _angle + _angle_plus;
};

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
#endif

d_dead_arti = 0;
private _grp = [d_side_enemy] call d_fnc_creategroup;

for "_i" from 0 to (__count_arti - 1) do {
	private _arti_pos_dir = _pos_array # _i;
	private _arti = createVehicle [d_sm_arty, _arti_pos_dir # 0, [], 0, "NONE"];
	_arti setDir (_arti_pos_dir # 1);
	_arti setPos (_arti_pos_dir # 0);
	d_x_sm_vec_rem_ar pushBack _arti;
	_arti addEventHandler ["killed", {
		d_dead_arti = d_dead_arti + 1;
		params ["_v"];
		_v removeAllEventHandlers "killed";
		{_v deleteVehicleCrew _x} forEach (crew _v);
	}];
#ifdef __TT__
	_arti addEventHandler ["handleDamage", {_this call d_fnc_AddSMPoints}];
#endif
	_arti lock true;
	_arti allowCrewInImmobile true;
	private _unit = _grp createUnit [d_sm_arty_crewman, _arti_pos_dir # 0, [], 0, "NONE"];
	[_unit] joinSilent _grp;
	_unit call d_fnc_removenvgoggles_fak;
	_unit setSkill 1;_unit assignAsGunner _arti;_unit moveInGunner _arti;
	d_x_sm_rem_ar pushBack _unit;
	sleep 0.5321;
};

if (d_with_dynsim == 0) then {
	_grp enableDynamicSimulation true;
};
_grp deleteGroupWhenEmpty true;

_pos_array = nil;

for "_i" from 1 to 3 do {
	private _truck = createVehicle [d_sm_ammotrucktype, _poss, [], 0, "NONE"];
	_truck lock true;
	d_x_sm_vec_rem_ar pushBack _truck;
	sleep 0.523;
};

sleep 2.123;
["specops", 3, "allmen", (floor (random 4) min 2), _poss, 300, true] spawn d_fnc_CreateInf;
sleep 4.123;
["aa", 1, selectRandom ["tank", "tracked_apc"], 2, selectRandom ["wheeled_apc", "jeep_gl", "jeep_mg"], 2, _poss, 1, 400, true] spawn d_fnc_CreateArmor;

while {d_dead_arti != __count_arti && {!d_sm_resolved}} do {
	sleep 4.631;
};

d_dead_arti = nil;

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
d_no_more_observers = 1;
