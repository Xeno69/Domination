// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createsecondary.sqf"
#include "..\..\x_setup.sqf"

__TRACE("Create Secondary")

if !(call d_fnc_checkSHC) exitWith {};

params ["_wp_array", "_mtradius", "_trg_center"];

sleep 3.120;

private _mtmhandle = _wp_array spawn d_fnc_getmtmission;

waitUntil {sleep 0.321; scriptDone _mtmhandle};

sleep 3.0123;

private _poss = [_trg_center, _mtradius, 3, 1, 0.3, 30, 0] call d_fnc_GetRanPointCircleBig;
private _iccount = 0;
while {_poss isEqualTo []} do {
	_iccount = _iccount + 1;
	_poss = [_trg_center, _mtradius, 3, 1, 0.3, 30, 0] call d_fnc_GetRanPointCircleBig;
	if (_iccount >= 50 && {!(_poss isEqualTo [])}) exitWith {};
};
if (isNil "_poss" || {_poss isEqualTo []}) then {
	_poss = [_trg_center, _mtradius] call d_fnc_getranpointcircle;
};
_poss set [2, 0];
private _vec = createVehicle [d_illum_tower, _poss, [], 0, "NONE"];
_vec setPos _poss;
_vec setVectorUp [0,0,1];
[_vec] call d_fnc_CheckMTHardTarget;
d_mt_radio_down = false;
[missionNamespace, ["d_mt_radio_down", false]] remoteExecCall ["setVariable", 2];
["d_main_target_radiotower", _poss,"ICON","ColorBlack",[0.5,0.5],localize "STR_DOM_MISSIONSTRING_521",0,"mil_dot"] remoteExecCall ["d_fnc_CreateMarkerGlobal", 2];

#ifndef __TT__
[9] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
[10] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
sleep 1.0112;

private _newgroup = [d_side_enemy] call d_fnc_creategroup;
__TRACE("from createsecondary 1")
[_poss, ["specops", d_enemy_side_short] call d_fnc_getunitlistm, _newgroup] spawn d_fnc_makemgroup;
_newgroup deleteGroupWhenEmpty true;
sleep 1.0112;
_newgroup allowFleeing 0;
_newgroup setVariable ["d_defend", true];
[_newgroup, _poss] spawn d_fnc_taskDefend;
if (d_with_dynsim == 0) then {
	_newgroup spawn {
		sleep 10;
		_this enableDynamicSimulation true;
	};
};

#ifndef __TT__
sleep 1;
[54] remoteExecCall ["d_fnc_DoKBMsg", 2];
sleep 2.234;
#else
sleep 3.234;
#endif

d_mt_spotted = false;
d_create_new_paras = false;
#ifndef __TT__
d_f_check_trigger = ([d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["ANYPLAYER", d_enemy_side + " D", false], ["this", "0 = 0 spawn {if (!d_create_new_paras) then {d_create_new_paras = true;0 execFSM 'fsms\fn_Parahandler.fsm'};d_mt_spotted = true;if (d_mt_respawngroups == 0) then {execFSM 'fsms\fn_RespawnGroups.fsm'};[12] remoteExecCall ['d_fnc_DoKBMsg', 2];sleep 5; deleteVehicle d_f_check_trigger}", ""]] call d_fnc_createtriggerlocal);
#else
d_f_check_trigger = ([d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["ANYPLAYER", d_enemy_side + " D", false], ["this", "0 = 0 spawn {if (!d_create_new_paras) then {d_create_new_paras = true;0 execFSM 'fsms\fn_Parahandler.fsm'};d_mt_spotted = true;[13] remoteExecCall ['d_fnc_DoKBMsg', 2];[14] remoteExecCall ['d_fnc_DoKBMsg', 2];sleep 5; deleteVehicle d_f_check_trigger}", ""]] call d_fnc_createtriggerlocal);
#endif

sleep 3.234;
#ifndef __TT__
private _nrcamps = (ceil random 5) max 3;
#else
private _nrcamps = (ceil random 6) max 4;
#endif

d_sum_camps = _nrcamps;
if (!isServer) then {
	[missionNamespace, ["d_sum_camps", _nrcamps]] remoteExecCall ["setVariable", 2];
};

private _sizecamp = sizeOf d_wcamp;

for "_i" from 1 to _nrcamps do {
	_poss = [_trg_center, _mtradius, 4, 1, 0.3, _sizecamp, 0] call d_fnc_GetRanPointCircleBig;
	_iccount = 0;
	while {_poss isEqualTo []} do {
		_iccount = _iccount + 1;
		_poss = [_trg_center, _mtradius, 4, 1, 0.3, _sizecamp, 0] call d_fnc_GetRanPointCircleBig;
		if (_iccount >= 50 && {!(_poss isEqualTo [])}) exitWith {};
	};
	if (isNil "_poss" || {_poss isEqualTo []}) then {
		_poss = [_trg_center, _mtradius] call d_fnc_getranpointcircle;
	};
	_poss set [2, 0];
	__TRACE_1("","_poss")
	private _wf = createVehicle [d_wcamp, _poss, [], 0, "NONE"];
	sleep 0.5;
	__TRACE_1("","_wf")
	_wf setDir floor random 360;
	private _nnpos = getPosASL _wf;
	_nnpos set [2, 0];
	__TRACE_1("1","_nnpos")
	if !(d_currentcamps isEqualTo []) then {
		private _doexit = false;
		private _xcountx = 0;
		while {_xcountx < 50} do {
			__TRACE_2("","_xcountx","d_currentcamps")
			private _wfokc = 0;
			{
				__TRACE_2("","_nnpos","_x")
				if (!(_nnpos isEqualTo []) && {_nnpos distance2D _x > 130}) then {_wfokc = _wfokc + 1};
			} forEach d_currentcamps;
			__TRACE_2("","_wfokc","count d_currentcamps")
			if (_wfokc != count d_currentcamps) then {
				private _tnnpos = [_nnpos, _mtradius / 2, 4, 1, 0.3, _sizecamp, 0] call d_fnc_GetRanPointCircleBig;
				__TRACE_1("2","_tnnpos")
				if !(_tnnpos isEqualTo []) then {_nnpos = _tnnpos};
			} else {
				if (_wf distance2D _nnpos > 130) then {
					_poss = _nnpos;
					_doexit = true;
				} else {
					private _tnnpos = [_nnpos, _mtradius / 2, 4, 1, 0.3, _sizecamp, 0] call d_fnc_GetRanPointCircleBig;
					__TRACE_1("3","_tnnpos")
					if !(_tnnpos isEqualTo []) then {_nnpos = _tnnpos};
				};
			};
			if (_doexit) exitWith {};
			_xcountx = _xcountx + 1;
		};
	};
	__TRACE_1("","_poss")
	_poss set [2, 0];
	_wf setPos _poss;
	d_currentcamps pushBack _wf;
	_wf setVariable ["d_SIDE", d_enemy_side, true];
	//_wf setVariable ["d_INDEX", _i, true];
	_wf setVariable ["d_CAPTIME", 40 + (floor random 10), true];
	_wf setVariable ["d_CURCAPTIME", 0, true];
#ifndef __TT__
	_wf setVariable ["d_CURCAPTURER", d_own_side];
#else
	_wf setVariable ["d_CURCAPTURER", ""];
#endif
	_wf setVariable ["d_STALL", false, true];
	_wf setVariable ["d_TARGET_MID_POS", _trg_center];
	_fwfpos = getPosATL _wf;
	_fwfpos set [2, 4.3];
	private _flagPole = createVehicle [d_flag_pole, _fwfpos, [], 0, "NONE"];
	_flagPole setPos _fwfpos;
	_wf setVariable ["d_FLAG", _flagPole, true];
	private _maname = format["d_camp_%1", _wf];
	[_maname, _poss, "ICON", "ColorBlack", [0.5,0.5], str _i, 0, d_strongpointmarker] remoteExecCall ["d_fnc_CreateMarkerGlobal", 2];
	if (!isServer) then {
		[_wf, ["d_camp_mar", _maname]] remoteExecCall ["setVariable", 2];
	} else {
		_wf setVariable ["d_camp_mar", _maname];
	};
	_flagPole setFlagTexture (call d_fnc_getenemyflagtex);
	
	_wf addEventHandler ["HandleDamage", {0}];
	//[_wf, _flagPole] call d_fnc_HandleCamps2;
#ifndef __TT__
	[_wf, _flagPole] execFSM "fsms\fn_HandleCamps2.fsm";
#else
	[_wf, _flagPole] execFSM "fsms\fn_HandleCampsTT2.fsm";
#endif

	sleep 0.5;
	
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	__TRACE("from createsecondary 2")
	[_poss, ["specops", d_enemy_side_short] call d_fnc_getunitlistm, _newgroup] spawn d_fnc_makemgroup;
	_newgroup deleteGroupWhenEmpty true;
	sleep 1.0112;
	_newgroup allowFleeing 0;
	_newgroup setVariable ["d_defend", true];
	[_newgroup, _poss] spawn d_fnc_taskDefend;
	if (d_with_dynsim == 0) then {
		_newgroup spawn {
			sleep 10;
			_this enableDynamicSimulation true;
		};
	};
};

publicVariable "d_currentcamps";
d_numcamps = count d_currentcamps; publicVariable "d_numcamps";
d_campscaptured = 0; publicVariable "d_campscaptured";

#ifndef __TT__
[15, _nrcamps] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
[16, _nrcamps] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif

if (random 100 > 70) then {
	[_mtradius, _trg_center] call d_fnc_minefield;
};

sleep 5.213;
d_main_target_ready = true;
if (!isServer) then {
	[missionNamespace, ["d_main_target_ready", true]] remoteExecCall ["setVariable", 2];
};
