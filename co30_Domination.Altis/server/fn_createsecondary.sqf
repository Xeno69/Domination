// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("Create Secondary")

__TRACE_1("","_this")

params ["_wp_array", "_mtradius", "_trg_center"];

sleep 1.120;

if (!d_preemptive_special_event) then {
	_this call d_fnc_getmtmission;
};

sleep 1.0123;

private _mindists = 5;
private _mslope = 0.3;

private _dobigtower = call {
	if (d_cargotower isEqualTo "" || {d_cup || {d_ifa3 || {d_gmcwg || {d_unsung || {d_csla || {d_vn || {d_spe}}}}}}}) exitWith {
		_dobigtower = false;
		false;
	};
	_mindists = 24;
	_mslope = 0.1;
	true;
};

private _get_possfortower = {
	params ["_mdist", "_slope"];
	__TRACE_1("_get_possfortower","_this")
	private _npos = [_trg_center, _mtradius, _mdist, _slope, 0, false, true] call d_fnc_GetRanPointCircleBig;
	private _iccount = 0;
	if (d_tanoa) then {
		_npos = [_npos] call d_fnc_tanoafix;
	};
	__TRACE_1("_get_possfortower 1","_npos")
	
	if (_npos isEqualTo _trg_center) then {
		_npos = [];
	};

	while {_npos isEqualTo []} do {
		_iccount = _iccount + 1;
		_npos = [_trg_center, _mtradius, _mdist, _slope, 0, false, true] call d_fnc_GetRanPointCircleBig;
		if (d_tanoa) then {
			_npos = [_npos] call d_fnc_tanoafix;
		};
		__TRACE_1("_get_possfortower 2","_npos")
		if (_iccount >= 50) exitWith {
			__TRACE_1("_get_possfortower ExitWith","_npos")
			_npos = [];
		};
		if (_npos isEqualTo _trg_center) then {
			_npos = [];
		};
		sleep 0.01;
	};
	_npos
};

private _poss = [_mindists, _mslope] call _get_possfortower;
if !(d_preemptive_special_event_startpos_opfor isEqualTo []) then {
	// special location for radiotower when pre-emptive event is running
	_poss = [[[d_preemptive_special_event_startpos_opfor, 50]],["water"]] call BIS_fnc_randomPos;
};
__TRACE_1("1","_poss")
__TRACE_1("1","_trg_center")
if (_trg_center isEqualTo _poss) then {
	_poss = [];
};
if (_poss isEqualTo []) then {
	_poss = [5, 0.3] call _get_possfortower;
	__TRACE_1("2","_poss")
	_dobigtower = false;
};
__TRACE_1("1","_dobigtower")

if (isNil "_poss" || {_poss isEqualTo []}) then {
	_poss = [_trg_center, _mtradius] call d_fnc_getranpointcircle;
	_dobigtower = false;
};
_poss set [2, 0];
private "_vec";
if (_dobigtower && {!d_preemptive_special_event}) then {
	_vec = _poss call d_fnc_makenewtower;
} else {
	_vec = createVehicle [d_illum_tower, _poss, [], 0, "NONE"];
	_vec setVectorUp [0, 0, 1];
};
d_mt_tower_pos = getPos _vec;
publicVariable "d_mt_tower_pos";
[_vec] call d_fnc_CheckMTHardTarget;
d_mt_radio_down = false;
if (d_ao_markers == 1) then {
	["d_m_t_rt", _poss, "ICON","ColorBlack", [0.5,0.5], localize "STR_DOM_MISSIONSTRING_521", 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
	["d_m_t_rt", "STR_DOM_MISSIONSTRING_521"] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
};

if (d_with_dynsim == 0) then {
	[_vec, 5] spawn d_fnc_enabledynsim;
};

#ifndef __TT__
[9] call d_fnc_DoKBMsg;
#else
[10] call d_fnc_DoKBMsg;
#endif
sleep 1.0112;

if (!d_preemptive_special_event) then {
	// no specops when a special event is already running
	["specops", [_poss], _trg_center, 0, "guard", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _mtradius]] call d_fnc_makegroup;
};

#ifndef __TT__
sleep 1;
[54] call d_fnc_DoKBMsg;
#else
[56] call d_fnc_DoKBMsg;
#endif
sleep 1.234;

d_mt_spotted = false;
d_create_new_paras = false;
#ifndef __TT__
d_f_check_trigger = ([d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["ANYPLAYER", d_enemy_side + " D", false], ["this", "0 = 0 spawn {scriptName 'spawn createsecondary3';if (!d_create_new_paras) then {d_create_new_paras = true;if (d_transport_chopper isNotEqualTo []) then {d_parahhandle = 0 spawn d_fnc_parahandler}};d_mt_spotted = true;[12] call d_fnc_DoKBMsg;0 spawn d_fnc_createambient;sleep 5; deleteVehicle d_f_check_trigger}", ""]] call d_fnc_createtriggerlocal);
#else
d_f_check_trigger = ([d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["ANYPLAYER", d_enemy_side + " D", false], ["this", "0 = 0 spawn {scriptName 'spawn createsecondary4';if (!d_create_new_paras) then {d_create_new_paras = true;if (d_transport_chopper isNotEqualTo []) then {d_parahhandle = 0 spawn d_fnc_parahandler}};d_mt_spotted = true;[13] call d_fnc_DoKBMsg;0 spawn d_fnc_createambient;sleep 5; deleteVehicle d_f_check_trigger}", ""]] call d_fnc_createtriggerlocal);
#endif

if (d_ao_check_for_ai in [0, 1]) then {
	sleep 1.234;
#ifndef __TT__
	private "_nrcamps";
	if (d_max_camp_cnt > 0) then {
		_nrcamps = d_max_camp_cnt
	} else {
		_nrcamps = (ceil random 5) max 3;
	};
#else
	private _nrcamps = (ceil random 6) max 4;
#endif

	d_sum_camps = _nrcamps;

	__TRACE_1("","_nrcamps")

	//private _sizecamp = sizeOf d_wcamp;
	//__TRACE_1("","_sizecamp")
	private _dist_for_points = -1;

	private _isFirstCamp = true;

	private _parray = [_trg_center, d_cur_target_radius + (0.666 * d_cur_target_radius), 5, 0.3, 0, false, true] call d_fnc_GetRanPointCircleBigArray;

	for "_i" from 1 to _nrcamps do {
		private _wf = objNull;
		private _poss =+ _trg_center;

		if (d_camp_center == 1 && {_isFirstCamp}) then {
			//try to place the first camp very close (10m) to the center of the target
			_poss set [2, 0];
			_wf = createVehicle [d_wcamp, _poss, [], 10, "NONE"];
			_wf allowDamage false;
			_wf setDir (_wf getDir _trg_center);
			_wf addEventHandler ["HandleDamage", {0}];
			_wf addEventHandler ["killed", {(_this #0) setDamage 0}];
			if (d_with_dynsim == 0) then {
				[_wf, 5] spawn d_fnc_enabledynsim;
			};
			sleep 0.3;
			_poss = getPosASL _wf;
			_isFirstCamp = false;
		} else {
			private _idx = floor random (count _parray);
			_poss = _parray # _idx;
			if (d_tanoa) then {
				_poss = [_poss] call d_fnc_tanoafix;
				private _tcounter = 0;
				while {_poss isEqualTo []} do {
					_idx = floor random (count _parray);
					_poss = _parray # _idx;
					_poss = [_poss] call d_fnc_tanoafix;
					if (_tcounter >= 70 && {_poss isNotEqualTo []}) exitWith {};
					_tcounter = _tcounter + 1;
				};
			};
			__TRACE_1("1","_poss")

			if (d_currentcamps isNotEqualTo []) then {
				private _fidx = d_currentcamps findIf {_x distance2D _poss < 130};
				if (_fidx != -1) then {
					private _icounter = 0;
					while {_icounter < 50 || {_fidx != -1}} do {
						_idx = floor random (count _parray);
						_poss = _parray # _idx;
						_fidx = d_currentcamps findIf {_x distance2D _poss < 130};
						_icounter = _icounter + 1;
					};
				};
			};

			_poss set [2, 0];
			_wf = createVehicle [d_wcamp, _poss, [], 0, "NONE"];
			_wf allowDamage false;
			_wf setDir (_wf getDir _trg_center);
			_wf addEventHandler ["HandleDamage", {0}];
			_wf addEventHandler ["killed", {(_this #0) setDamage 0}];
			if (d_with_dynsim == 0) then {
				[_wf, 5] spawn d_fnc_enabledynsim;
			};
			sleep 0.3;
			__TRACE_1("1111","_wf")

			_parray deleteAt _idx;
		};

		__TRACE_1("5","_poss")
		if (d_with_ranked || {d_database_found}) then {
			if (_dist_for_points < _wf distance2D _trg_center) then {
				_dist_for_points = _wf distance2D _trg_center;
			};
			__TRACE_1("","_dist_for_points")
		};
		d_currentcamps pushBack _wf;
		_wf setVariable ["d_SIDE", d_enemy_side, true];
		_wf setVariable ["d_CAPTIME", round (40 + (floor random 10)), true];
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
		__TRACE_1("","_fwfpos")
		private _flagPole = createVehicle [d_flag_pole, _fwfpos, [], 0, "NONE"];
		_flagPole setPos _fwfpos;
		_wf setVariable ["d_FLAG", _flagPole, true];
		if (d_ao_markers == 1) then {
			private _maname = format ["d_camp_%1", _wf call d_fnc_markername];
			__TRACE_2("","_i","_maname")
			deleteMarker _maname;
			[_maname, _poss, "ICON", "ColorBlack", [0.5, 0.5], str _i, 0, d_strongpointmarker] call d_fnc_CreateMarkerGlobal;
			_wf setVariable ["d_camp_mar", _maname];
		};
		_flagPole setFlagTexture (call d_fnc_getenemyflagtex);
		if (d_with_dynsim == 0) then {
			[_flagPole, 5] spawn d_fnc_enabledynsim;
		};

	#ifndef __TT__
		[_wf, _flagPole] execFSM "fsms\fn_HandleCamps2.fsm";
	#else
		[_wf, _flagPole] execFSM "fsms\fn_HandleCampsTT2.fsm";
	#endif

		sleep 0.5;

		if (_wf distance2D _trg_center > d_cur_target_radius || {random 100 > 30}) then {
			if (d_preemptive_special_event) exitWith {}; // no secondary when a special event is already running
			private _retgr = ["specops", [_poss], _trg_center, 0, "guard", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _mtradius]] call d_fnc_makegroup;
			(_retgr # 1) spawn {
				scriptname "spawn 5_createsecondary";
				sleep 20;
				{
					if (d_with_dynsim == 0) then {
						_x enableDynamicSimulation false;
						sleep 0.2;
					};
					if (animationState _x == "afalpercmstpsraswrfldnon") then {
						private _hpos = getPosWorld _x;
						_x setPos [_hpos # 0, _hpos # 1, 0];
					};
					if (d_with_dynsim == 0) then {
						_x enableDynamicSimulation true;
					};
				} forEach (_this select {alive _x});
			};
		};
	};

	publicVariable "d_currentcamps";
	remoteExecCall ["d_fnc_curcampsclient", [0, -2] select isDedicated];
	d_numcamps = count d_currentcamps; publicVariable "d_numcamps";
	d_campscaptured = 0; publicVariable "d_campscaptured";
	
	if (d_with_ranked || {d_database_found}) then {
		d_dist_for_points = _dist_for_points + 10;
		publicVariable "d_dist_for_points";
	};
	
#ifndef __TT__
	[15, _nrcamps] call d_fnc_DoKBMsg;
#else
	[16, _nrcamps] call d_fnc_DoKBMsg;
#endif
};

sleep 0.1;

if (d_with_minefield == 0 && {!d_preemptive_special_event && {random 100 > 80}}) then {
	[_mtradius, _trg_center] call d_fnc_minefield;
};

sleep 1;

private _speedboatavailable = !isNil "d_sm_speedboat";
if (!isNil "d_sm_speedboat") then {
	_speedboatavailable = if (d_sm_speedboat isEqualType []) then {d_sm_speedboat isNotEqualTo []} else {d_sm_speedboat != ""};
	if (_speedboatavailable && {!d_preemptive_special_event}) then {
		[_trg_center, _mtradius] spawn d_fnc_seapatrol;
	};
};

sleep 0.1;
if (d_IllumMainTarget == 0) then {
	if (!d_spe) then {
		[_trg_center, _mtradius] spawn {
			params ["_trg_center", "_mtradius"];
			scriptName "spawn_illum createsecondary";
			for "_i" from 1 to 6 do {
				[_trg_center, _mtradius] execFSM "fsms\fn_Illum.fsm";
				sleep (1 + selectRandom [1, 2, 3, 4]);
			};
		};
	} else {
		[_trg_center, _mtradius] spawn d_fnc_spe_illum;
	};
};
if (worldname == "Altis" && {diag_fps > 30}) then {
	[_trg_center, _mtradius] spawn d_fnc_ambientanimals;
};

if (!isNil "d_cur_tgt_civ_units" && {count d_cur_tgt_civ_units != 0}) then {
	// civilians exist, remove civilians spawned too close to any maintarget objectives
	{
		private _civ = _x;
		if ((getPos _civ) distance2D d_mt_tower_pos < 15) exitWith {
			diag_log ["civ cleanup - too close to tower"];
			deleteVehicle _civ;
		};
		{
			if ((getPos _civ) distance2D (getPos _x) < 15) exitWith {
				diag_log ["civ cleanup - too close to something in d_mt_barracks_obj_ar"];
				deleteVehicle _civ;
			};
		} forEach d_mt_barracks_obj_ar;
		
	} forEach d_cur_tgt_civ_units;
};

sleep 5.213;
d_main_target_ready = true;
