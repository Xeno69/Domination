// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifdef __DEBUG__
diag_log ["DOM playerdisconnected: _this", _this];
#endif

__TRACE_1("","_this")

if (isNull d_serv_test_obj) exitWith {
#ifdef __DEBUG__
	diag_log "DOM playerdisconnected, d_serv_test_obj is Null!!!";
#endif
};

params ["", "_uid", "_name"];

if (_uid isEqualTo "") exitWith {
#ifdef __DEBUG__
	diag_log ["DOM playerdisconnected, _uid is an empty string, _this:", _this];
#endif
};

private _gui = getUserInfo (_this # 5);
__TRACE_1("","_gui")

#ifdef __DEBUG__
diag_log ["DOM playerdisconnected: getUserInfo", _gui];
#endif

if (_gui # 7) exitWith {
#ifdef __DEBUG__
	diag_log ["DOM playerdisconnected, headless client disconnect, _this:", _this];
#endif
	0 spawn {
		scriptname "spawn pldisconnected";
		sleep 2;
		d_hc_array = d_hc_array - [objNull, grpNull];
		if (d_hc_array isNotEqualTo []) then {
			if (!isNil "d_recreatehcs_handle") then {
				terminate d_recreatehcs_handle;
			};
			d_recreatehcs_handle = 0 spawn d_fnc_recreatehcs;
		};
	};
};

private _unit = _gui # 10;

__TRACE_2("","_uid","_name")
__TRACE_1("1","_unit")

if (!isNil "_unit" && {isNull _unit}) then {
	_unit = _uid call d_fnc_getunitbyuid;
};

if (isNil "_unit" || {isNull _unit}) exitWith {};

if (local _unit && {isDedicated}) exitWith {};

if (_unit isKindOf "VirtualSpectator_F") exitWith {
#ifdef __DEBUG__
	diag_log ["DOM playerdisconnected, virtual spectator, _this:", _this];
#endif
};

if (!d_database_found) exitWith {};

if (!isNil {_unit getVariable "d_no_side_change"}) exitWith {
	__TRACE_2("No database update","_unit","_name")
#ifdef __DEBUG__
	diag_log ["DOM playerdisconnected: No database update, _this:", _this];
#endif
};

private _pa = d_player_hash getOrDefault [_uid, []];
if (_pa isEqualTo []) exitWith {
#ifdef __DEBUG__
	diag_log ["DOM playerdisconnected uid not found in player hash, _this:", _this];
#endif
};

#ifdef __DEBUG__
diag_log ["DOM playerdisconnected _unit:", _unit];
#endif

private _ps = if (!isNull _unit) then {getPlayerScores _unit} else {_pa # 12};
private _scpl = if (!isNull _unit) then {score _unit} else {-1};
__TRACE_1("","_scpl")
__TRACE_1("","getPlayerScores _unit")
__TRACE_1("","_ps")
#ifdef __DEBUG__
diag_log ["DOM playerdisconnected _pa", _pa, " _ps", _ps, " _scpl", _scpl];
#endif
if (_ps isEqualTo [] || {_ps isEqualTo [0, 0, 0, 0, 0, 0]}) exitWith {
#ifdef __DEBUG__
	diag_log ["DOM playerdisconnected playerscores is either an empty array or has only entries with 0, _ps:", _ps, "_this:", _this];
#endif
};
//  [infantry kills, soft vehicle kills, armor kills, air kills, deaths, total score]
private _usc = _uid + "_scores";
private _t_ps = d_player_hash getOrDefault [_usc, [0, 0, 0, 0, 0, 0]];
__TRACE_1("","_t_ps")
#ifdef __DEBUG__
diag_log ["DOM playerdisconnected: _t_ps", _t_ps];
#endif
// only add diff to db
private _infkills = (_ps # 0) - (_t_ps # 0);
private _softveckills = (_ps # 1) - (_t_ps # 1);
private _armorkills = (_ps # 2) - (_t_ps # 2);
private _airkills = (_ps # 3) - (_t_ps # 3);
private _deaths = (_ps # 4) - (_t_ps # 4);
private _totalscore = if (_scpl != -1) then {_scpl} else {_ps # 5};

d_player_hash set [_usc, _ps];

__TRACE_3("","_infkills","_softveckills","_armorkills")
__TRACE_3("","_airkills","_deaths","_totalscore")

#ifdef __DEBUG__
diag_log ["DOM playerdisconnected: _totalscore", _totalscore];
#endif

if (_totalscore <= 0) exitWith {
#ifdef __DEBUG__
	diag_log ["DOM playerdisconnected _totalscore <= 0, _this:", _this];
#endif
};

private _playtime = round (time - (_pa # 1));

#ifdef __DEBUG__
diag_log ["DOM playerdisconnected: _playtime", _playtime];
#endif

private _tks = _pa # 14;

__TRACE_1("","_tks")

private _distar = _pa # 15;
__TRACE_1("","_distar")

private _headshots = _pa # 16;
__TRACE_1("","_headshots")

private _rounds = _pa # 17;
__TRACE_1("","_rounds")

call {
	if (d_db_type == 0) exitWith {
		"extdb3" callExtension format ["1:dom:updatePlayer:%1:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12", _infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _tks, _distar, _headshots, _rounds, _uid];
		__TRACE("extDB3 called")
	};
	if (d_db_type == 1) exitWith {
		["updatePlayer", [_infkills, _softveckills, _armorkills, _airkills, _deaths, _totalscore, _playtime, _tks, _distar, _headshots, _rounds, _uid]] call d_fnc_queryconfigasync;
		__TRACE("interceptDB called")
	};
	if (d_db_type == 2) exitWith {
		private _tmphash = missionProfileNamespace getVariable "d_player_hashmap";
		__TRACE_1("","_tmpar")
		if (!isNil "_tmphash") then {
			private _tmpar = _tmphash get _uid;
			if (!isNil "_tmpar") then {
				__TRACE_1("1","_tmpar")
				_tmpar set [2, (_tmpar # 2) + _infkills];
				_tmpar set [3, (_tmpar # 3) + _softveckills];
				_tmpar set [4, (_tmpar # 4) + _armorkills];
				_tmpar set [5, (_tmpar # 5) + _airkills];
				_tmpar set [6, (_tmpar # 6) + _deaths];
				_tmpar set [7, _totalscore];
				_tmpar set [1, _playtime];
				_tmpar set [12, _tks];
				_tmpar set [14, _distar];
				_tmpar set [15, _headshots];
				_tmpar set [16, _rounds];
				__TRACE_1("2","_tmpar")
			};
		};
	};
};

_pa set [14, 0];
