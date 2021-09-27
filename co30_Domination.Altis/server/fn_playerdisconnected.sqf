// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

diag_log ["DOM playerdisconnected: _this", _this];

__TRACE_1("","_this")

params ["", "_uid", "_name"];

if (_uid isEqualTo "") exitWith {
	diag_log ["DOM playerdisconnected, _uid is an empty string, _this:", _this];
};

private _gui = getUserInfo (_this # 5);
__TRACE_1("","_gui")

diag_log ["DOM playerdisconnected: getUserInfo", _gui];

if (_gui # 7) exitWith {
	diag_log ["DOM playerdisconnected, headless client disconnect, _this:", _this];
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
	diag_log ["DOM playerdisconnected, virtual spectator, _this:", _this];
};

if (!d_database_found) exitWith {};

if (!isNil {_unit getVariable "d_no_side_change"}) exitWith {
	__TRACE_2("No database update","_unit","_name")
	diag_log ["DOM playerdisconnected: No database update, _this:", _this];
};

private _pa = d_player_hash getOrDefault [_uid, []];
if (_pa isEqualTo []) exitWith {
	diag_log ["DOM playerdisconnected uid not found in player hash, _this:", _this];
};

diag_log ["DOM playerdisconnected _unit:", _unit];

private _ps = if (!isNull _unit) then {getPlayerScores _unit} else {_pa # 12};
private _scpl = if (!isNull _unit) then {score _unit} else {-1};
__TRACE_1("","_scpl")
__TRACE_1("","getPlayerScores _unit")
__TRACE_1("","_ps")
diag_log ["DOM playerdisconnected _pa", _pa, " _ps", _ps, " _scpl", _scpl];
if (_ps isEqualTo [] || {_ps isEqualTo [0, 0, 0, 0, 0, 0]}) exitWith {
	diag_log ["DOM playerdisconnected playerscores is either an empty array or has only entries with 0, _ps:", _ps, "_this:", _this];
};
//  [infantry kills, soft vehicle kills, armor kills, air kills, deaths, total score]
private _usc = _uid + "_scores";
private _t_ps = d_player_hash getOrDefault [_usc, [0, 0, 0, 0, 0, 0]];
__TRACE_1("","_t_ps")
diag_log ["DOM playerdisconnected: _t_ps", _t_ps];
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

diag_log ["DOM playerdisconnected: _totalscore", _totalscore];

if (_totalscore <= 0) exitWith {
	diag_log ["DOM playerdisconnected _totalscore <= 0, _this:", _this];
};

private _playtime = round (time - (_pa # 1));

diag_log ["DOM playerdisconnected: _playtime", _playtime];

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
};

_pa set [14, 0];
