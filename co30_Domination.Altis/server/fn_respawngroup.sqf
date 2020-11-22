// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_respawngroup.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (d_mt_done) exitWith {};

private _grptype = toLowerANSI (_this select 0);

private _isman = _grptype in ["allmen", "specops"];

if (_isman && {d_mt_barracks_down}) exitWith {
	__TRACE("barracks down")
};

if (!_isman && {d_mt_mobile_hq_down}) exitWith {
	__TRACE("d_mt_mobile_hq_down down")
};

private _fnc_checktime = {
	private _count = count (allPlayers - entities "HeadlessClient_F");
	if (_count == 0) then {
		(time + (_this # 1))
	} else {
		(_this # 0)
	};
};


private _doend = false;

if (_isman) then {
	private _basetime = d_ai_groups_respawn_time # 0;
	private _maxtime = d_ai_groups_respawn_time # 1;

	__TRACE_2("","_basetime","_maxtime")

	private _old_add = d_groups_respawn_time_add;
	private _endtime = time + (_basetime - ((([1, count (allPlayers - (entities "HeadlessClient_F"))] select isMultiplayer) * 5) min _maxtime)) + (random 30) + d_groups_respawn_time_add;
	
	__TRACE_1("","_endtime")
	__TRACE_1("","d_groups_respawn_time_add")
	
	while {true} do {
		sleep 1;
		if (_old_add != d_groups_respawn_time_add) then {
			_endtime = _endtime + (d_groups_respawn_time_add - _old_add) + random 2;
			_old_add = d_groups_respawn_time_add;
			__TRACE_3("111","_endtime","_old_add","d_groups_respawn_time_add")
		};
		_endtime = [_endtime, _maxtime] call _fnc_checktime;
		if (time > _endtime || {d_mt_done || {d_mt_barracks_down}}) exitWith {};
	};
	if (d_mt_done || {d_mt_barracks_down}) then {
		_doend = true;
	};
} else {
	private _basetime = d_ai_groups_respawn_time # 2;
	private _maxtime = d_ai_groups_respawn_time # 3;

	__TRACE_2("","_basetime","_maxtime")
	
	private _extratime = [0, d_launcher_cooldown / 2] select (d_launcher_cooldown > 0);

	private _endtime = time + (_basetime - ((([1, count (allPlayers - (entities "HeadlessClient_F"))] select isMultiplayer) * 5) min _maxtime)) + (random 40) + _extratime;

	__TRACE_1("","_endtime")

	while {true} do {
		sleep 1;
		_endtime = [_endtime, _maxtime] call _fnc_checktime;
		if (time > _endtime || {d_mt_done || {d_mt_mobile_hq_down}}) exitWith {};
	};
	if (d_mt_done || {d_mt_mobile_hq_down}) then {
		_doend = true;
	};
};

if (_doend) exitWith {
	__TRACE_1("Doend","_this")
};

if (!_isman) then {
	private _resp_mid = _this select 11;
	__TRACE_1("","_resp_mid")
	if (!isNil "_resp_mid" && {_resp_mid isNotEqualTo []}) then {
		_this set [1, [[_resp_mid select 0, 600, 400, _resp_mid select 1] call d_fnc_GetRanPointSquare]];
		__TRACE_1("respawning","_this")
		_this call d_fnc_makegroup;
	} else {
		diag_log ["respawngroup, _resp_mid is either nil or empty", _this];
	};
} else {
	private "_selobj";
	private _do_end2 = false;
	while {true} do {
		__TRACE_1("Starting loop","_this")
		if (d_mt_barracks_obj_ar isEqualTo []) exitWith {_doend = true};
		
		_selobj = selectRandom d_mt_barracks_obj_ar;
		private _trig = _selobj getVariable "d_bar_trig";
		if (isNil "_trig") exitWith {
			__TRACE("no d_bar_trig var")
		};
		if ((list _trig) isEqualTo []) exitWith {};
		__TRACE_1("trigger list not empty","list _trig")
		while {true} do {
			sleep 1;
			if (d_mt_done || {d_mt_barracks_down}) exitWith {
				_doend = true;
			};
			if (!alive _selobj) exitWith {
				if (d_mt_barracks_obj_ar isEqualTo []) then {
					_doend = true;
				};
			};
			if (time >= (_selobj getVariable ["d_nextspawn", -1]) && {(list _trig) isEqualTo []}) exitWith {
				_do_end2 = true;
			};
		};
		if (_doend || {_do_end2}) exitWith {};
	};
	if (_doend || {isNil "_selobj"}) exitWith {};
	
	_selobj setVariable ["d_nextspawn", time + 10];
	
	private _d_mt_barracks_obj_pos = getPos _selobj;
	__TRACE_1("","_d_mt_barracks_obj_pos")
	_this set [1, [_d_mt_barracks_obj_pos]];
	_this set [11, _d_mt_barracks_obj_pos];
	__TRACE_1("respawning","_this")
	sleep 0.1;
	_this call d_fnc_makegroup;
};