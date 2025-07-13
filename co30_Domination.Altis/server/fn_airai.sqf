// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("airai")

params ["_type"];

#define __wp_behave "AWARE"

while {true} do {
#ifndef __DEBUG__
	if (!d_mt_radio_down) then {
		while {!d_mt_spotted} do {sleep 8.32};
	} else {
		while {d_mt_radio_down} do {sleep 8.123};
		if (!d_mt_spotted) then {
			while {!d_mt_spotted} do {sleep 8.32};
		};
	};
#endif
	private _vec = objNull;
	private _vehicles = [];
	private _funits = [];

	private _limit_p = call {
		if (d_limit_airai == 0) exitWith {0};
		if (_type isEqualTo "AP") exitWith {12};
		if (_type isEqualTo "HAC") exitWith {10};
		if (_type isEqualTo "UAV") exitWith {5};
		3;
	};
	__TRACE_1("","_limit_p")
#ifndef __DEBUG__
	while {true} do {
		if (!d_mt_radio_down && {(call d_fnc_PlayersNumber) >= _limit_p && {diag_fps > 15}}) exitWith {
			__TRACE("spawning airai vehicle")
		};
		sleep (5 + random 10);
		};
#endif

	while {d_mt_radio_down} do {sleep 6.123};
	private _pos = call d_fnc_GetRanPointOuterAir;
	if (d_cur_tgt_pos isNotEqualTo []) then {
		private _counter = 0;
		while {_pos distance2D d_cur_tgt_pos < 2000 && {_counter < 100}} do {
			_pos = call d_fnc_GetRanPointOuterAir;
			_counter = _counter + 1;
		};
	};

	private _grpskill = 0.6 + (random 0.3);
	__TRACE_2("","_pos","_grpskill")

	private _grp = [d_side_enemy] call d_fnc_creategroup;
	__TRACE_1("","_grp")
	private _heli_type = "";
	private _height = 150;
	private _heightASL = [150,150,150];
	private _numair = 0;
	call {
		if (_type == "HAC") exitWith {
			_heli_type = selectRandom d_airai_attack_chopper;
			_numair = [d_number_attack_choppers, ceil (random d_number_attack_choppers)] select (d_number_attack_choppers > 1);
			_height = 250;
			_heightASL = [250, 100 + (random 100), 250 + (random 250)];
		};
		if (_type == "AP") exitWith {
			_heli_type = selectRandom d_airai_attack_plane;
			_numair = [d_number_attack_planes, ceil (random d_number_attack_planes)] select (d_number_attack_planes > 1);
			if (!d_spe) then {
				_height = 500;
				_heightASL = [500, 300 + (random 100), 200 + (random 200)];
			} else {
				_height = 200;
				_heightASL = [200, 100 + (random 100), 300 - (random 200)];
			};
		};
		if (_type == "LAC") exitWith {
			_heli_type = selectRandom d_light_attack_chopper;
			_numair = [d_number_light_attack_choppers, ceil (random d_number_light_attack_choppers)] select (d_number_light_attack_choppers > 1);
			_height = 150;
			_heightASL = [150, 100 + (random 50), 150 + (random 150)];
		};
		if (_type == "UAV") exitWith {
			_heli_type = selectRandom d_airai_attack_uav;
			_numair = [d_number_attack_uavs, ceil (random d_number_attack_uavs)] select (d_number_attack_uavs > 1);
			_height = 400;
			_heightASL = [400, 250 + (random 100), 400 + (random 200)];
		};
	};

	__TRACE_2("","_heli_type","_numair")

	while {true} do {
		sleep 0.323;
		if (d_current_target_index >= 0) exitWith {};
	};
	private _cdir = _pos getDir d_island_center;
	__TRACE_1("","_cdir")
#ifndef __TT__
	if !((toUpperANSI _heli_type) in ["B_PLANE_FIGHTER_01_STEALTH_F","O_PLANE_FIGHTER_02_STEALTH_F"]) then {
		call {
			if (_type == "AP") exitWith {if (d_searchintel # 1 == 1) then {[0] call d_fnc_DoKBMsg}};
			if (_type == "HAC") exitWith {if (d_searchintel # 2 == 1) then {[1] call d_fnc_DoKBMsg}};
			if (_type == "LAC") exitWith {if (d_searchintel # 3 == 1) then {[2] call d_fnc_DoKBMsg}};
		};
	 };
#endif
	for "_xxx" from 1 to _numair do {
		private _vec_array = [[_pos # 0, _pos # 1, 400], _cdir, _heli_type, _grp] call d_fnc_spawnVehicle;
		__TRACE_1("","_vec_array")

		_vec_array params ["_vec"];
		if (d_with_dynsim == 0) then {
			_vec setVariable ["d_nodyn", true];
		};
		//_vec setPos [_pos # 0, _pos # 1, 400];
		_vehicles pushBack _vec;
		__TRACE_1("","_vehicles")

		_funits append (_vec_array # 1);
		__TRACE_1("","_funits")

		addToRemainsCollector [_vec];
		[_vec, 2] remoteExec ["setFeatureType", [0, -2] select isDedicated, _vec];
		[_vec, 17] call d_fnc_setekmode;

		if (d_LockAir == 0) then {_vec lock true};
		_vec flyInHeight _height;
		_vec flyInHeightASL _heightASL;
#ifndef __TT__
		if !((toUpperANSI _heli_type) in ["B_PLANE_FIGHTER_01_STEALTH_F","O_PLANE_FIGHTER_02_STEALTH_F"]) then {
			call {
				 if (_type == "AP") exitWith {if (d_searchintel # 1 == 1) then {_vec spawn d_fnc_airmarkermove;}};
				 if (_type == "HAC") exitWith {if (d_searchintel # 2 == 1) then {_vec spawn d_fnc_airmarkermove;}};
				 if (_type == "LAC") exitWith {if (d_searchintel # 3 == 1) then {_vec spawn d_fnc_airmarkermove;}};
			};
		};
#endif
		if (_vec isKindOf "Plane") then {
			_vec setVehicleRadar 1;
		};
		{
			_x disableAI "LIGHTS";
			_x setVehicleReceiveRemoteTargets true;
			_x setVehicleReportRemoteTargets true;
		} forEach (crew _vec);
		_vec setCollisionLight true;
		_vec setPilotLight false;
		_vec setVehicleReceiveRemoteTargets true;
		_vec setVehicleReportRemoteTargets true;
		_vec setVariable ["d_enemyAir_nextRearmTime",(diag_tickTime + 300),false];
		__TRACE_1("","_vec")
		sleep 0.1;
	};

	(leader _grp) setSkill _grpskill;

	sleep 1.011;

	_grp allowFleeing 0;
	_grp setCombatMode "RED";
	_grp enableAttack true;

	while {true} do {
		sleep 0.323;
		if (d_current_target_index >= 0) exitWith {};
	};
	private _cur_tgt_pos =+ d_cur_tgt_pos;
	_cur_tgt_pos set [2, 0];
	private _wp = _grp addWayPoint [d_cur_tgt_pos, 0];
	_wp setWaypointType "SAD";
	private _pat_pos =+ d_cur_tgt_pos;
	[_grp, 1] setWaypointStatements ["true", ""];
	_wp setWaypointCompletionRadius 50;
	private _old_pos = [0,0,0];
	private _xcounter = 0;
	while {true} do {
		while {true} do {
			sleep 0.323;
			if (d_current_target_index >= 0) exitWith {};
		};
		_cur_tgt_pos =+ d_cur_tgt_pos;
		_cur_tgt_pos set [2, 0];

		sleep 3 + random 2;

		private _radius = call {
			if (_type == "HAC" || {_type == "LAC"}) exitWith {d_cur_target_radius * 3};
			if (_type == "AP") exitWith {d_cur_target_radius * 5};
			d_cur_target_radius
		};

		__TRACE_1("","_radius")

#define __patternpos \
_pat_pos = _cur_tgt_pos getPos [random _radius, random 360]; \
_pat_pos set [2, _cur_tgt_pos select 2]

		_curvec = objNull;
		private _mmvevs = _vehicles select {alive _x && {canMove _x}};
		if (_mmvevs isNotEqualTo []) then {
			_curvec = _mmvevs # 0;
			if (_old_pos isEqualTo []) then {
				_old_pos = getPosASL _curvec;
			};
		};
		_mmvevs = nil;
		__TRACE_1("","_curvec")
		__TRACE_1("","_old_pos")
		_xcounter = _xcounter + 1;
		if (!isNull _curvec && {_curvec distance2D _cur_tgt_pos > _radius || {_curvec distance2D _old_pos < 30 && {_xcounter > 100}}}) then {
			if (_curvec distance2D _old_pos < 30 && {_xcounter > 100}) exitWith {
				{
					private _v = _x;
					deleteVehicleCrew _v;
					_v setDamage 1;
				} forEach _vehicles;
				_xcounter = 0;
			};
			_xcounter = 0;
			if (_type == "HAC" || {_type == "LAC"}) then {
				private _tmp_pos = _pat_pos;
				__patternpos;
				while {_pat_pos distance2D _tmp_pos < 100} do {
					__patternpos;
					sleep 0.01;
				};
				_pat_pos = _pat_pos call d_fnc_WorldBoundsCheck;
				__TRACE_1("HACLAC","_pat_pos")
				[_grp, 1] setWaypointPosition [_pat_pos, 0];
				_grp setSpeedMode "NORMAL";
				if (_type != "UAV") then {
					_grp setBehaviour __wp_behave;
				} else {
					_grp setBehaviour "COMBAT";
				};
				_old_pos = getPosASL _curvec;
				{
					_x flyInHeight _height;
					_x flyInHeightASL _heightASL;
				} forEach (_vehicles select {alive _x});
				sleep 16.821 + random 15;
			} else {
				__patternpos;
				_pat_pos = _pat_pos call d_fnc_WorldBoundsCheck;
				__TRACE_1("plane","_pat_pos")
				[_grp, 1] setWaypointPosition [_pat_pos, 0];
				_grp setSpeedMode "LIMITED";
				if (_type != "UAV") then {
					_grp setBehaviour __wp_behave;
				} else {
					_grp setBehaviour "COMBAT";
				};
				_old_pos = getPosASL _curvec;
				{
					_x flyInHeight _height;
					_x flyInHeightASL _heightASL;
				} forEach (_vehicles select {alive _x});
				sleep 80 + random 80;
			};
		};
		__TRACE_1("","_xcounter")

		sleep 3 + random 2;

		if (_vehicles isNotEqualTo []) then {
			__TRACE("_vehicles array not empty")
			{
				if (isNull _x || {!alive _x || {!canMove _x}}) then {
					__TRACE_1("not alive","_x")
					if (!isNull _x && {!canMove _x}) then {
						_x spawn {
							__TRACE("deleting airai vehicle")
							scriptName "spawn_x_airai_delvec1";
							private _vec = _this;
							sleep 100;
							if (alive _vec && {canMove _vec}) exitWith {};
							if (!isNull _vec) then {_vec call d_fnc_DelVecAndCrew};
						};
					};
					_vehicles set [_forEachIndex, -1];
				} else {
				    private _oneveh = _x;
				    if (!isNil {_oneveh getVariable "d_enemyAir_nextRearmTime"}) then {
				         if (diag_tickTime > (_oneveh getVariable "d_enemyAir_nextRearmTime")) then {
				              _oneveh setFuel 1;
					      _oneveh setVehicleAmmo 1;
					      _oneveh setVariable ["d_enemyAir_nextRearmTime",(diag_tickTime + 300),false];
					 };
				    };
				    if (_type isEqualTo "AP") then {
					private _allPlayers =  (allPlayers - entities "HeadlessClient_F") select {!(_x isKindOf "VirtualMan_F")};
					if (_allPlayers isNotEqualTo []) then {
					       {
						   if ((objectParent _x) isKindOf "Plane") then {
								if (_x isEqualTo (currentPilot (objectParent _x))) then {
								(group (currentPilot _oneveh)) reveal [(objectParent _x),4];
								if (isNull (getAttackTarget (currentPilot _oneveh))) then {
									(currentPilot _oneveh) doTarget (objectParent _x);
								};
							};
							};
						} count _allPlayers;
					};
					};
				};
			} forEach _vehicles;
			_vehicles = _vehicles - [-1];
		};
		if (_vehicles isEqualTo []) exitWith {
			__TRACE("_vehicles array IS empty")
			deleteVehicle _funits;
			_funits = [];
			_vehicles = [];
		};
		sleep 20;
		{
			if (_x distance2D _pos < 500) then {
				_vec call d_fnc_DelVecAndCrew
			};
		} forEach _vehicles;
		sleep 0.1;
		_vehicles = _vehicles - [objNull];
		_funits = _funits - [objNull];
		sleep 0.1;
		if (_vehicles isEqualTo []) exitWith {
			__TRACE("_vehicles array IS empty")
			deleteVehicle _funits;
			_funits = [];
			_vehicles = [];
		};
	};
#ifndef __DEBUG__
	_num_p = call d_fnc_PlayersNumber;
	private _re_random = (call {
		if (_num_p < 5) exitWith {1000};
		if (_num_p < 10) exitWith {800};
		if (_num_p < 15) exitWith {600};
		if (_num_p < 20) exitWith {400};
		200;
	});
	sleep (d_airai_respawntime + _re_random);
#else
	sleep 10;
#endif
};
