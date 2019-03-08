// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_respawngroup.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

if (d_mt_done) exitWith {};

private _grptype = toLower (_this select 0);

private _isman = toLower (_this select 0) in ["allmen", "specops"];

if (_isman && {d_mt_barracks_down}) exitWith {
	__TRACE("barracks down")
};

if (!_isman && {d_mt_mobile_hq_down}) exitWith {
	__TRACE("d_mt_mobile_hq_down down")
};

private _doend = false;
private _fnc_checktime = {
	private _count = count (allPlayers - entities "HeadlessClient_F");
	if (_count == 0) then {
		__TRACE("no players")
		(time + (_this # 1))
	} else {
		__TRACE("players")
		(_this # 0)
	};
};

if (_isman) then {
	private _basetime = d_ai_groups_respawn_time # 0;
	private _maxtime = d_ai_groups_respawn_time # 1;

	__TRACE_2("","_basetime","_maxtime")

	private _endtime = time + (_basetime - ((([1, count (allPlayers - (entities "HeadlessClient_F"))] select isMultiplayer) * 5) min _maxtime)) + random 20;
	
	__TRACE_1("","_endtime")
	
	waitUntil {sleep 1; _endtime = [_endtime, _maxtime] call _fnc_checktime; time > _endtime || {d_mt_done || {d_mt_barracks_down}}};
	if (d_mt_done || {d_mt_barracks_down}) then {
		_doend = true;
	};
} else {
	private _basetime = d_ai_groups_respawn_time # 2;
	private _maxtime = d_ai_groups_respawn_time # 3;

	__TRACE_2("","_basetime","_maxtime")

	private _endtime = time + (_basetime - ((([1, count (allPlayers - (entities "HeadlessClient_F"))] select isMultiplayer) * 5) min _maxtime)) + random 40;

	__TRACE_1("","_endtime")

	waitUntil {sleep 1; _endtime = [_endtime, _maxtime] call _fnc_checktime; time > _endtime || {d_mt_done || {d_mt_mobile_hq_down}}};
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
	_this set [1, [[_resp_mid select 0, 600, 400, _resp_mid select 1] call d_fnc_GetRanPointSquare]];
	__TRACE_1("respawning","_this")
	_this call d_fnc_makegroup;
} else {
	private _d_mt_barracks_obj_pos = getPos (selectRandom d_mt_barracks_obj_ar);
	__TRACE_1("","_d_mt_barracks_obj_pos")
	_this set [1, [_d_mt_barracks_obj_pos]];
	_this set [11, _d_mt_barracks_obj_pos];
	__TRACE_1("respawning","_this")
	_this call d_fnc_makegroup;
};


