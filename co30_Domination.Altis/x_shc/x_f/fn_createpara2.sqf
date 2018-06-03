// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createpara2.sqf"
#include "..\..\x_setup.sqf"

#define __exitchop if (!alive _chopper || {!canMove _chopper || {!alive driver _chopper}}) exitWith {[_crew_vec, _chopper,240 + random 100] spawn _delveccrew}
private ["_assigned","_paragrp","_pos_end","_u","_unit_array","_wp","_xx","_wp2","_del_me","_delveccrew","_crew_vec"];
if (!isServer) exitWith {};

params ["_vgrp", "_chopper", "_helifirstpoint", "_heliendpoint"];
_crew_vec = crew _chopper;

sleep 2.123;

_wp = _vgrp addWaypoint [_helifirstpoint, 30];
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointSpeed "NORMAL";
_wp setwaypointtype "MOVE";
_wp setWaypointFormation "WEDGE";

_wp2 = _vgrp addWaypoint [_heliendpoint, 0];
_wp2 setwaypointtype "MOVE";
_wp2 setWaypointBehaviour "CARELESS";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setwaypointtype "MOVE";

_chopper flyinheight 100;

#ifndef __TT__
if ((__XJIPGetVar(GVAR(searchintel)) select 0) == 1) then {
	GVAR(kb_logic1) kbTell [GVAR(kb_logic2),GVAR(kb_topic_side),"TellInfiltrateAttack",true];
};
#endif

_delveccrew = {
	params ["_crew_vec", "_vec", "_time"];
	sleep _time;
	{_x setDamage 1.1} forEach (_crew_vec select {!isNull _x});
	sleep 1;
	if (!isNull _vec && {({_x call d_fnc_isplayer} count (crew _vec)) == 0}) then {_vec setDamage 1};
};

while {_helifirstpoint distance2D (leader _vgrp) > 150} do {
	__exitchop;
	sleep 2.123;
};

if (alive _chopper && {canMove _chopper && {alive driver _chopper}}) then {
	_paragrp = [d_side_enemy] call d_fnc_creategroup;
	sleep 0.1;
	private _subskill = if (diag_fps > 29) then {
		(0.1 + (random 0.2))
	} else {
		(0.12 + (random 0.04))
	};
	{
		private _pposcx = getPosATL _chopper;
		_one_unit = _paragrp createUnit [_x, [_pposcx # 0, _pposcx # 1, 0], [], 0,"NONE"];
		[_one_unit] joinSilent _paragrp;
		
		private _para = createVehicle [d_non_steer_para, _pposcx, [], 20, "NONE"];
		_one_unit moveInDriver _para;
		_para setDir random 360;
		_pposcx = getPosATL _vec;
		_para setPos [_pposcx # 0, _pposcx # 1, (_pposcx # 2) - 10];
		_one_unit call d_fnc_removenvgoggles_fak;
		
		if (d_with_ai && {d_with_ranked}) then {
			_one_unit addEventHandler ["Killed", {
				[1, _this select 1] remoteExecCall ["d_fnc_addkillsai", 2];
				(_this select 0) removeAllEventHandlers "Killed";
			}];
		};
		_one_unit setUnitAbility ((d_skill_array # 0) + (random (d_skill_array # 1)));
		_one_unit setSkill ["aimingAccuracy", _subskill];
		_one_unit setSkill ["spotTime", _subskill];
		sleep 0.551;
	} forEach (["sabotage", d_enemy_side_short] call d_fnc_getunitlistm);
	_paragrp allowFleeing 0;
	_paragrp setCombatMode "YELLOW";
	_paragrp setBehaviour "AWARE";
	
	sleep 0.113;
	_paragrp spawn {
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
};

__exitchop;

while {(_heliendpoint distance2D (leader _vgrp) > 300)} do {
	__exitchop;
	sleep 5.123;
};

if (!isNull _chopper) then {_chopper call d_fnc_DelVecAndCrew};