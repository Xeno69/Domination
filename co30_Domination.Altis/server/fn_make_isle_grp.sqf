// by Xeno
#define THIS_FILE "fn_make_isle_grp.sqf"
#include "..\x_setup.sqf"

__TRACE("Starting _make_isle_grp")
private _dc = 0;
private _start_point = d_with_isledefense call d_fnc_GetRanPointSquare;

private _allplayers = allPlayers - entities "HeadlessClient_F";
private _player_near = false;

#ifndef __TT__
while {(count _start_point < 3 || {_start_point distance2D d_FLAG_BASE < 2000 || {_start_point distance2D d_old_old_start < 500 || {_player_near}}}) && {_dc < 99}} do {
#else
while {(count _start_point < 3 || {_start_point distance2D d_WFLAG_BASE < 2000 || {_start_point distance2D d_EFLAG_BASE < 2000 || {_start_point distance2D d_old_old_start < 500 || {_player_near}}}}) && {_dc < 99}} do {
#endif
	_start_point = d_with_isledefense call d_fnc_GetRanPointSquare;
	sleep 0.1;
	_player_near = _allplayers findIf {_x distance2D _start_point < 2000} > 0;
	sleep 0.353;
	_dc = _dc + 1;
};
_start_point = _start_point call d_fnc_WorldBoundsCheck;
__TRACE_1("","_start_point")
sleep 0.01;
d_old_old_start = _start_point;
private _units = [];
private _vecs = [];
private _agrp = [d_side_enemy] call d_fnc_creategroup;
private _npos = _start_point;
{
	private _rand = floor random 2;
	if (_rand > 0) then {
		private _reta = [_rand, _npos, _x, _agrp, -1.111] call d_fnc_makevgroup;
		_vecs append (_reta # 0);
		_units append (_reta # 1);
		sleep 0.73;
		_npos = ((_reta # 0) # 0) modelToWorld [0,-12,0];
	};
} forEach ([d_enemy_side_short] call d_fnc_getmixedlist);
_agrp deleteGroupWhenEmpty true;
_agrp enableDynamicSimulation false;
sleep 0.31;

_agrp setVariable ["d_PATR", true];
_agrp setVariable ["d_PATR_ISLE", true];
[_agrp, _start_point, [d_with_isledefense # 0, d_with_isledefense # 1, d_with_isledefense # 2, d_with_isledefense # 3]] spawn d_fnc_MakePatrolWPX;
#ifndef __TT__
if (d_searchintel # 5 == 1) then {
	_agrp spawn d_fnc_IsleDefMarkerMove;
};
#endif
{
        private _vec = _x;
	{
	   _x enableSimulation true;
	   _x enableDynamicSimulation false;   
	} forEach (crew _vec);
	_vec enableDynamicSimulation false;
	_vec setUnloadInCombat [false, false];
	_vec forceFollowRoad true;
	_vec setConvoySeparation 50;
	_vec addEventHandler ["GetOut", {(_this # 2) setDamage 1;(_this # 0) setDamage 1}];	
	_vec allowCrewInImmobile true;
	_vec setVariable ["d_cur_pos", getPosASL _x];
	_vec lock true;
} forEach _vecs;
_agrp call d_fnc_addgrp2hc;
[_agrp, _units, _vecs]
