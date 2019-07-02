// by Xeno
#define THIS_FILE "fn_sidearrest.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_officer", ["_docreatearmor", false], ["_docreateinf", false]];

if (isNull _officer) then {
	d_x_sm_pos params ["_poss"];
	private _ogroup = [d_side_enemy] call d_fnc_creategroup;
	_officer = _ogroup createUnit [d_soldier_officer, _poss, [], 0, "NONE"];
	[_officer] joinSilent _ogroup;
	_ogroup deleteGroupWhenEmpty true;
	_officer allowDamage false;
	_officer spawn {
		sleep 20;
		_this allowDamage true;
	};
	_poss set [2, 0];
	[_officer, _poss] call d_fnc_setposagls;
	_officer call d_fnc_removenvgoggles_fak;
	_officer addEventHandler ["killed", {_this call d_fnc_KilledSMTarget500}];
	d_x_sm_rem_ar pushBack _officer;
	removeAllWeapons _officer;
	sleep 2.123;
	private _leadero = leader _ogroup;
	_leadero setRank "COLONEL";
	_ogroup setBehaviour "CARELESS";
	if (d_with_dynsim == 0) then {
		_officer enableDynamicSimulation true;
	};
	sleep 2;
};

private _offz_at_base = false;
private _is_dead = false;
private _rescued = false;

if (d_with_ranked || {d_database_found}) then {d_sm_p_pos = nil};

if (_docreateinf) then {
	["specops", (floor (random 4)) min 2, "allmen", (floor (random 4)) min 2, d_x_sm_pos # 0, 300, true] spawn d_fnc_CreateInf;
	sleep 2.333;
};
if (_docreatearmor) then {
	[selectRandom ["aa", "tank"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, d_x_sm_pos # 0, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 2.333;
	["stat_mg", 1, "stat_gl", 1, "", 0, d_x_sm_pos # 0, 1, 100, false] spawn d_fnc_CreateArmor;
	sleep 1;
};

d_sm_arrest_not_failed = true;

while {!_offz_at_base && {!_is_dead && {d_sm_arrest_not_failed && {!d_sm_resolved}}}} do {
	if (!alive _officer) exitWith {_is_dead = true;};
	if (!_rescued) then {
		private _nobjs = (_officer nearEntities ["CAManBase", 20]) select {(_x call d_fnc_isplayer) && {alive _x && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}};
		if !(_nobjs isEqualTo []) then {
			_nobjs params ["_rescuer"];
			_rescued = true;
			_officer enableAI "PATH";
			[_officer] join _rescuer;

			[_officer, true] remoteExecCall ["setCaptive", _officer];

			d_sm_arrest_mp_unit = _rescuer;
			d_sm_arrest_mp_unit setVariable ["d_sm_ar_mpk_eh_idx",
				_rescuer addMPEventhandler ["MPKilled", {
					if (!isNil "d_sm_arrest_mp_unit") then {
						d_sm_arrest_not_failed = false;
						d_sm_arrest_mp_unit removeMPEventHandler ["MPKilled", d_sm_arrest_mp_unit getVariable "d_sm_ar_mpk_eh_idx"];
						d_sm_arrest_mp_unit setVariable ["d_sm_ar_mpk_eh_idx", nil];
						d_sm_arrest_mp_unit = nil;
					};
				}]
			];
		};
	} else {
#ifndef __TT__
		if (_officer distance2D d_FLAG_BASE < 50 || {!isNil "d_flag_airfield" && {_officer distance2D d_flag_airfield < 50}}) then {
#else
		if (_officer distance2D d_WFLAG_BASE < 50 || {_officer distance2D d_EFLAG_BASE < 50}) then {
#endif
			_offz_at_base = true;
		};
	};

	sleep 5.621;
};

if (!d_sm_arrest_not_failed) then {_is_dead = true};

if (!d_sm_resolved) then {
	if (_is_dead) then {
		d_sm_winner = -500;
	} else {
		if (_offz_at_base) then {
	#ifndef __TT__
			if (d_with_ranked || {d_database_found}) then {
				[missionNamespace, ["d_sm_p_pos", getPosATL d_FLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
			};
			d_sm_winner = 2;
	#else
			if (_officer distance2D d_WFLAG_BASE < 50) then {
				if (d_with_ranked || {d_database_found}) then {
					[missionNamespace, ["d_sm_p_pos", getPosATL d_WFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
				};
				d_sm_winner = 2;
			} else {
				if (_officer distance2D d_EFLAG_BASE < 50) then {
					if (d_with_ranked || {d_database_found}) then {
						[missionNamespace, ["d_sm_p_pos", getPosATL d_EFLAG_BASE]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
					};
					d_sm_winner = 1;
				} else {
					d_sm_winner = -500;
				};
			};
	#endif
		};
	};
};

if (!isNull objectParent _officer) then {
	(objectParent _officer) deleteVehicleCrew _officer;
} else {
	deleteVehicle _officer;
};
sleep 0.5;

d_sm_arrest_not_failed = nil;
if (!isNil "d_sm_arrest_mp_unit") then {
	d_sm_arrest_mp_unit removeMPEventHandler ["MPKilled", d_sm_arrest_mp_unit getVariable "d_sm_ar_mpk_eh_idx"];
	d_sm_arrest_mp_unit setVariable ["d_sm_ar_mpk_eh_idx", nil];
	d_sm_arrest_mp_unit = nil;
};

d_sm_resolved = true;
