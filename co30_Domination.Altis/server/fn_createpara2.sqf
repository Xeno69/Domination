// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createpara2.sqf"
#include "..\x_setup.sqf"

#define __exitchop if (!alive _chopper || {!canMove _chopper || {!alive driver _chopper}}) exitWith {[_crew_vec, _chopper, 240 + random 100] spawn _delveccrew; _stop_me = true}

params ["_vgrp", "_chopper", "_helifirstpoint", "_heliendpoint"];
private _crew_vec = crew _chopper;
private _startpos = getPos _chopper;

if (d_with_dynsim == 0) then {
	if (dynamicSimulationEnabled  _chopper) then {
		_chopper enableDynamicSimulation false; 
	};
};

sleep 2.123;

private _stop_me = false;
private _unit = driver _chopper;
_unit setSkill 1;

_unit doMove _helifirstpoint;
_chopper flyInHeight 80;
_vgrp setBehaviourStrong "CARELESS";

/*
private _wp = _vgrp addWaypoint [_helifirstpoint, 30];
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointSpeed "NORMAL";
_wp setwaypointtype "MOVE";
_wp setWaypointFormation "WEDGE";

private _wp2 = _vgrp addWaypoint [_heliendpoint, 0];
_wp2 setwaypointtype "MOVE";
_wp2 setWaypointBehaviour "CARELESS";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setwaypointtype "MOVE";

_chopper flyinheight 100;
*/

#ifndef __TT__
if (d_searchintel # 6 == 1) then {
	d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "TellInfiltrateAttack", d_kbtel_chan];
};
#endif

private _delveccrew = {
	scriptName "spawn_x_createpara2_delveccrew";
	params ["_crew_vec", "_vec", "_time"];
	sleep _time;
	{_x setDamage 1} forEach (_crew_vec select {!isNull _x});
	sleep 1;
	if (!isNull _vec) then {_vec setDamage 1};
};

private _checktime = time + 300;
private _distchk = [500, 2000] select (_chopper isKindOf "Plane");
while {_helifirstpoint distance2D _chopper > 300} do {
	__exitchop;
	if (time > _checktime) then {
		if (_startpos distance2D _chopper < _distchk) then {
			[_crew_vec, _chopper, 1 + random 1] spawn _delveccrew;
			_stop_me = true;
		} else {
			_checktime = time + 9999999;
		};
	};
	if (_stop_me) exitWith {};
	sleep 0.8;
};

if (_stop_me) exitWith {};

if (alive _chopper && {canMove _chopper && {alive driver _chopper}}) then {
	_unit doMove _heliendpoint;
	_chopper flyInHeight 80;
	_vgrp setBehaviourStrong "CARELESS";

	private _subskill = if (diag_fps > 29) then {
		(0.1 + (random 0.2))
	} else {
		(0.12 + (random 0.04))
	};
	private _real_units = ["sabotage", d_enemy_side_short] call d_fnc_getunitlistm;
	if (count _real_units < 5) then {
		while {count _real_units < 5} do {
			_real_units pushBack (selectRandom _real_units);
		};
	};
	private _nightorfog = call d_fnc_nightfograin;
	private _paragrp = [d_side_enemy] call d_fnc_creategroup;
	{
		private _pposcx = getPosATL _chopper;
		_one_unit = _paragrp createUnit [_x, [_pposcx # 0, _pposcx # 1, 0], [], 0,"NONE"];
		[_one_unit] joinSilent _paragrp;

		private _para = createVehicle [d_non_steer_para, _pposcx, [], 20, "NONE"];
		_one_unit moveInDriver _para;
		_para setDir random 360;
		_pposcx = getPosATL _chopper;
		_para setPos [_pposcx # 0, _pposcx # 1, (_pposcx # 2) - 10];
		_one_unit call d_fnc_removenvgoggles_fak;

		if (d_with_ai && {d_with_ranked}) then {
			[_one_unit, 4] call d_fnc_setekmode;
		};
		_one_unit setUnitAbility ((d_skill_array # 0) + (random (d_skill_array # 1)));
		_one_unit setSkill ["aimingAccuracy", _subskill];
		_one_unit setSkill ["spotTime", _subskill];
		//_one_unit enableStamina false;
		//_one_unit enableFatigue false;
		_one_unit disableAI "RADIOPROTOCOL";
		[_one_unit, _nightorfog, true] call d_fnc_changeskill;
		sleep 0.551;
	} forEach _real_units;
	_paragrp allowFleeing 0;
	_paragrp setCombatMode "YELLOW";
	_paragrp setBehaviour "AWARE";

	sleep 0.113;
	_paragrp spawn {
		scriptName "spawn createpara2";
		private "_grp";
		_grp = _this;
		sleep 20;
		if ((units _grp) findIf {alive _x} > -1) then {
			[_grp, d_base_array # 0, [d_base_array # 0, d_base_array # 1, d_base_array # 2, d_base_array # 3]] spawn d_fnc_MakePatrolWPX;
			_grp setVariable ["d_PATR", true];
		};
	};
	sleep 0.112;
	[_paragrp] spawn d_fnc_sabotage;
	_paragrp call d_fnc_addgrp2hc;
};

__exitchop;

_checktime = time + 300;
while {(_heliendpoint distance2D _chopper > 500)} do {
	__exitchop;
	if (time > _checktime) exitWith	{};
	sleep 1.123;
};

if (!isNull _chopper) then {_chopper call d_fnc_DelVecAndCrew};