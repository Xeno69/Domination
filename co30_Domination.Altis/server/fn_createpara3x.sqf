// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createpara3x.sqf"
#include "..\x_setup.sqf"

params ["_startpoint", "_attackpoint", "_flytopos", "_heliendpoint", "_number_vehicles"];
__TRACE_3("","_startpoint","_attackpoint","_heliendpoint")
__TRACE_2("","_number_vehicles","_flytopos")

d_should_be_there = _number_vehicles;

d_c_attacking_grps = [];

private _delveccrew = {
	scriptName "spawn_x_createpara3_delveccrew";
	params ["_crew_vec", "_vec", "_time"];
	__TRACE("_delveccrew running")
	sleep _time;
	__TRACE("_delveccrew deleting")
	{_vec deleteVehicleCrew _x} forEach (_crew_vec select {!isNull _x});
	if (!isNull _vec) then {_vec setDamage 1};
	{_x setDamage 1; deleteVehicle _x} forEach (_crew_vec select {!isNull _x});
};

private _make_jump = {
	scriptName "spawn_x_createpara3_make_jump";
	params ["_vgrp", "_vec", "_attackpoint", "_flytopos", "_heliendpoint", "_delveccrew", "_crew_vec"];

	__TRACE("_make_jump")

	private _startpos = getPosATL _vec;
	private _driver_vec = driver _vec;

	if (_vec isKindOf "Plane") then {_flytopos = _attackpoint} else {_flytopos set [2, 80]};

	_heliendpoint set [2, 80];
	_attackpoint set [2, 0];

	/*private _wp = _vgrp addWaypoint [_flytopos, 0];
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointtype "MOVE";
	_wp setWaypointFormation "VEE";
	_wp setWaypointForceBehaviour true;
	_wp = _vgrp addWaypoint [_heliendpoint, 0];
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointtype "MOVE";
	_wp setWaypointFormation "VEE";
	_wp setWaypointForceBehaviour true;
	*/

	_driver_vec setSkill 1;

	sleep 0.1;
	private _landheli = random 100 > 49;
	
	__TRACE_1("","_landheli")

	private _helperh = objNull;
	if (_landheli) then {
		_helperh = d_HeliHEmpty createVehicle [0,0,0];
		private _nendpos = _attackpoint findEmptyPosition [10, 200, typeOf _vec];
		if !(_nendpos isEqualTo []) then {_nendpos = _attackpoint};
		_driver_vec doMove _nendpos;
		__TRACE_1("","_helperh")
	} else {
		_driver_vec doMove _flytopos;
	};
	_vec flyInHeight 80;
	_vec flyInHeightASL [80,80,80];
	_vgrp setBehaviourStrong "CARELESS";

	__TRACE_1("","_flytopos")

	//_vec flyInHeight 100;

	sleep 10.0231;

	__TRACE_1("","d_mt_radio_down")
	if (d_mt_radio_down) exitWith {
		[_crew_vec, _vec, 1 + random 1] spawn _delveccrew;
		if (!isNull _helperh) then {
			deleteVehicle _helperh;
		};
	};

	private _stop_me = false;
	private _checktime = time + 400;
	private _distchk = [500, 2000] select (_vec isKindOf "Plane");
	private _slower = false;
	__TRACE_2("","_checktime","_distchk")
	while {_attackpoint distance2D _vec > 300} do {
		__TRACE_1("","_attackpoint distance2D _vec")
		if (!alive _vec || {!alive _driver_vec || {!canMove _vec}}) exitWith {d_should_be_there = d_should_be_there - 1};
		sleep 0.01;
		if (d_mt_radio_down && {_attackpoint distance2D (leader _vgrp) > 1300}) exitWith {
			[_crew_vec, _vec, 1 + random 1] spawn _delveccrew;
			_stop_me = true;
		};
		sleep 0.01;
		if (time > _checktime) then {
			__TRACE_2("","time","_checktime")
			__TRACE_1("","_startpos distance2D _vec")
			if (_startpos distance2D _vec < _distchk) then {
				d_should_be_there = d_should_be_there - 1;
				[_crew_vec, _vec, 1 + random 1] spawn _delveccrew;
				_stop_me = true;
			} else {
				_checktime = time + 9999999;
			};
		};
		if (_stop_me) exitWith {};
		sleep 0.01;
		if (_landheli && {!_slower && {_attackpoint distance2D _vec > 1000}}) then {
			_slower = true;
			_driver_vec setSpeedMode "LIMITED";
		};
		sleep 0.7;
	};
	if (_stop_me) exitWith {
		if (!isNull _helperh) then {
			deleteVehicle _helperh;
		};
		__TRACE("1 stop me true")
	};
	__TRACE("MT dist loop end")
	sleep 0.3;

	if (alive _vec && {alive _driver_vec && {canMove _vec}}) then {
		private "_paragrp";
		private _subskill = if (diag_fps > 29) then {
			(0.1 + (random 0.2))
		} else {
			(0.12 + (random 0.04))
		};
		if (_landheli) then {
			if (!d_mt_radio_down) then {
				while {alive _vec && {alive _driver_vec && {canMove _vec && {!(unitReady _driver_vec)}}}} do {
					sleep 1;
				};
				if (alive _vec && {alive _driver_vec && {canMove _vec}}) then {
					__TRACE("vec landing")
					_vec land "LAND";
					while {alive _vec && {alive _driver_vec && {canMove _vec && {!isTouchingGround _vec}}}} do {
						sleep 1;
					};
				};
			};
			if (alive _vec && {alive _driver_vec && {canMove _vec}}) then {
				sleep 1;
				_paragrp = [d_side_enemy] call d_fnc_creategroup;
				__TRACE_1("","_paragrp")
				private _real_units = ["allmen", d_enemy_side_short] call d_fnc_getunitlistm;
				sleep 0.1;
				if (count _real_units > 6) then {
					_real_units resize 6;
				};
				private _nightorfog = call d_fnc_nightfograin;
				__TRACE_1("","_nightorfog")
				private _aunits = [];
				{
					private _one_unit = _paragrp createUnit [_x, [0,0,0], [], 0, "NONE"];
					[_one_unit] joinSilent _paragrp;
					__TRACE_1("","_one_unit")
					_one_unit moveInCargo _vec;
					_one_unit call d_fnc_removenvgoggles_fak;
#ifdef __TT__
					[_one_unit, 0] call d_fnc_setekmode;
#endif
					_aunits pushBack _one_unit;
					if (d_with_ai && {d_with_ranked}) then {
						[_one_unit, 4] call d_fnc_setekmode;
					};
					_one_unit setUnitAbility ((d_skill_array # 0) + (random (d_skill_array # 1)));
					_one_unit setSkill ["aimingAccuracy", _subskill];
					_one_unit setSkill ["spotTime", _subskill];
					//_one_unit enableStamina false;
					//_one_unit enableFatigue false;
					_one_unit disableAI "RADIOPROTOCOL";
					d_delinfsm pushBack _one_unit;
					[_one_unit, _nightorfog, true] call d_fnc_changeskill;
					sleep 0.01;
					if (!alive _vec) exitWith {
						__TRACE("vec not alive")
					};
				} forEach _real_units;
				sleep 0.1;
				__TRACE("paragrp leavevehicle")
				_paragrp leaveVehicle _vec;
				{
					unassignVehicle _x;
					moveOut _x;
					sleep 0.5;
				} forEach _aunits;
				__TRACE("paragrp units moveout")
				private _bino = binocular (leader _paragrp);
				if !(_bino isEqualTo "") then {
					(leader _paragrp) removeWeapon _bino;
				};
#ifdef __TT__
				if (d_with_ace) then {
					_paragrp setVariable ["d_ktypett", 1];
				};
#endif
				_paragrp deleteGroupWhenEmpty true;
				__TRACE_1("","_real_units")
#ifndef __TT__
				(units _paragrp) call d_fnc_addceo;
#endif
				_paragrp allowFleeing 0;
				_paragrp setCombatMode "YELLOW";
				_paragrp setBehaviour "AWARE";

				[_paragrp, d_cur_tgt_pos, d_cur_target_radius] spawn {
					scriptName "spawn_x_createpara3_usegroup2";
					params ["_grp", "_pos"];
					sleep 5;
					if ((units _grp) findIf {alive _x} > -1) then {
						[_grp, _pos, [_pos, _this select 2], [10, 20, 50], "", 0] spawn d_fnc_MakePatrolWPX;
						_grp setVariable ["d_PATR", true];
						if (d_with_dynsim == 0) then {
							[_grp, 0] spawn d_fnc_enabledynsim;
						};
						_grp call d_fnc_addgrp2hc;
					};
				};

				sleep 1;
				_vec land "NONE";
				__TRACE("vec starting again")
				sleep 0.1;
				_driver_vec doMove _heliendpoint;
				if (_slower) then {
					_driver_vec setSpeedMode "NORMAL";
				};
				_vec flyInHeight 80;
				_vgrp setBehaviourStrong "CARELESS";
			};
		} else {
			_driver_vec doMove _heliendpoint;
			_vec flyInHeight 80;
			_vgrp setBehaviourStrong "CARELESS";
			private _disttt = [500, 700] select (speed _vec > 300);
			__TRACE_1("","_disttt")
			__TRACE_1("","_vec distance2D d_cur_tgt_pos")
			if (!d_mt_radio_down && {_vec distance2D d_cur_tgt_pos < _disttt}) then {
				__TRACE("Do create para units")
				_paragrp = [d_side_enemy] call d_fnc_creategroup;
				__TRACE_1("","_paragrp")
				private _real_units = ["allmen", d_enemy_side_short] call d_fnc_getunitlistm;
				sleep 0.1;
				private _nightorfog = call d_fnc_nightfograin;
				__TRACE_1("","_nightorfog")
				private _sleeptime = [0.551, 0.15] select (speed _vec > 300);
				__TRACE_1("","_sleeptime")
				{
					private _pposcx = getPosASLVisual _vec;
					private _one_unit = _paragrp createUnit [_x, [0,0,0], [], 0, "NONE"];
					[_one_unit] joinSilent _paragrp;
					__TRACE_1("","_one_unit")
					private _para = d_non_steer_para createVehicle [0,0,0];
					__TRACE_1("","_para")
					_para setPosASL [_pposcx # 0, _pposcx # 1, (_pposcx # 2) - 10];
					_para setVectorDirAndUp [vectorDirVisual _vec,vectorUpVisual _vec];
					_one_unit moveInDriver _para;
					_one_unit call d_fnc_removenvgoggles_fak;
#ifdef __TT__
					[_one_unit, 0] call d_fnc_setekmode;
#endif
					if (d_with_ai && {d_with_ranked}) then {
						[_one_unit, 4] call d_fnc_setekmode;
					};
					_one_unit setUnitAbility ((d_skill_array # 0) + (random (d_skill_array # 1)));
					_one_unit setSkill ["aimingAccuracy", _subskill];
					_one_unit setSkill ["spotTime", _subskill];
					//_one_unit enableStamina false;
					//_one_unit enableFatigue false;
					_one_unit disableAI "RADIOPROTOCOL";
					d_delinfsm pushBack _one_unit;
					[_one_unit, _nightorfog, true] call d_fnc_changeskill;
					sleep _sleeptime;
					if (!alive _vec) exitWith {
						__TRACE("vec not alive")
					};
				} forEach _real_units;
#ifdef __TT__
				if (d_with_ace) then {
					_paragrp setVariable ["d_ktypett", 1];
				};
#endif
				_paragrp deleteGroupWhenEmpty true;
				__TRACE_1("","_real_units")
#ifndef __TT__
				(units _paragrp) call d_fnc_addceo;
#endif
				_paragrp allowFleeing 0;
				_paragrp setCombatMode "YELLOW";
				_paragrp setBehaviour "AWARE";

				[_paragrp, d_cur_tgt_pos, d_cur_target_radius] spawn {
					scriptName "spawn_x_createpara3_usegroup";
					params ["_grp", "_pos"];
					sleep 40;
					if ((units _grp) findIf {alive _x} > -1) then {
						[_grp, _pos, [_pos, _this select 2], [10, 20, 50], "", 0] spawn d_fnc_MakePatrolWPX;
						_grp setVariable ["d_PATR", true];
						if (d_with_dynsim == 0) then {
							[_grp, 0] spawn d_fnc_enabledynsim;
						};
						_grp call d_fnc_addgrp2hc;
					};
				};
			};
		};

		if (!isNil "_paragrp" && {!isNull _paragrp}) then {
			d_c_attacking_grps pushBack _paragrp;
		};

		sleep 0.112;
		d_should_be_there = d_should_be_there - 1;

		_checktime = time + 500;
		__TRACE_1("","_checktime")
		while {_heliendpoint distance2D _vec > 1000} do {
			__TRACE_1("","_vec")
			__TRACE_1("","_heliendpoint distance2D _vec")
			__TRACE_3("","alive _vec","alive _driver_vec","canMove _vec")
			if (!alive _vec || {!alive _driver_vec || {!canMove _vec || {time > _checktime}}}) exitWith {
				__TRACE("Exiting heliendpoint check")
			};
			sleep 1.123;
		};
		
		if (!isNull _vec) then {
			if (_heliendpoint distance2D _vec > 1000) then {
				[_crew_vec, _vec, 60 + random 60] spawn _delveccrew;
			} else {
				_vec call d_fnc_DelVecAndCrew;
			};
		};

		if (!isNull _helperh) then {
			deleteVehicle _helperh;
		};
	} else {
		[_crew_vec, _vec, 60 + random 60] spawn _delveccrew;
	};
	__TRACE("Ending makejump")
};

private _cur_tgt_pos =+ d_cur_tgt_pos;
__TRACE_1("","_cur_tgt_pos")
private _stop_it = false;

if (d_searchintel # 0 == 1) then {
	[43] call d_fnc_DoKBMsg;
};

private _crews_ar = [];
private _vecs_ar = [];

private _icounter = 0;
while {_icounter < _number_vehicles} do {
	if (d_mt_radio_down || {d_cur_tgt_pos distance2D _cur_tgt_pos > 500}) exitWith {_stop_it = true};
	private _vgrp = [d_side_enemy] call d_fnc_creategroup;
	private _heli_type = selectRandom d_transport_chopper;
	private _spos = [_startpoint # 0, _startpoint # 1, 300];
	([_spos, _spos getDir _attackpoint, _heli_type, _vgrp] call d_fnc_spawnVehicle) params ["_vec", "_crew"];
	__TRACE_1("","_crew")
	__TRACE_1("","_vec")
	_crews_ar append _crew;
	_vecs_ar pushBack _vec;
	addToRemainsCollector [_vec];
	_vec spawn d_fnc_airmarkermove;

	_vec lock true;

	_vgrp deleteGroupWhenEmpty true;

	private _etime = time + 5.012;
	while {time < _etime && {!d_mt_radio_down}} do {sleep 1};
	__TRACE("5 seconds over")

	//_vec flyInHeight 100;
	_vec flyInHeight 80;
	_vec flyInHeightASL [80,80,80];

	__TRACE_1("","d_mt_radio_down")
	if (d_mt_radio_down) exitWith {
		_stop_it = true;
		__TRACE("Main deleting")
		{_vec deleteVehicleCrew _x} forEach (crew _vec);
		deleteVehicle _vec;
	};
	__TRACE("before _make_jump")
	[_vgrp, _vec, _attackpoint, _flytopos, _heliendpoint, _delveccrew, _crew] spawn _make_jump;

	_icounter = _icounter + 1;
	if (_icounter == _number_vehicles) exitWith {
		__TRACE("icounter = number vecs")
	};

	_etime = time + 30 + (random 30);
	while {time < _etime && {!d_mt_radio_down}} do {
		__TRACE("waiting for radio down or etime")
		sleep 1;
	};
};

__TRACE_1("","_stop_it")

if (_stop_it) exitWith {
	{
		private _v = _x;
		{_v deleteVehicleCrew _x} forEach (crew _v);
	} forEach (_vecs_ar select {!isNull _x});
	{deleteVehicle _x} forEach (_vecs_ar select {!isNull _x});
	{deleteVehicle _x} forEach (_crews_ar select {!isNull _x});
};

while {d_should_be_there > 0 && {!d_mt_radio_down}} do {
	__TRACE_1("","d_should_be_there")
	sleep 1.021;
};

if (!d_mt_radio_down) then {
	private _etime = time + 20.0123;
	while {time < _etime && {!d_mt_radio_down}} do {sleep 1};
	if (d_mt_radio_down) exitWith {
		d_create_new_paras = false;
	};
	if !(d_c_attacking_grps isEqualTo []) then {
		[d_c_attacking_grps] spawn d_fnc_handleattackgroups;
	} else {
		d_c_attacking_grps = [];
		d_create_new_paras = true;
	};
};

[_vecs_ar, _crews_ar] spawn {
	params ["_vecs_ar", "_crews_ar"];
	sleep 120;
	{
		private _v = _x;
		{_v deleteVehicleCrew _x} forEach (crew _v);
	} forEach (_vecs_ar select {!isNull _x});
	{deleteVehicle _x} forEach (_vecs_ar select {!isNull _x});
	{deleteVehicle _x} forEach (_crews_ar select {!isNull _x});
};