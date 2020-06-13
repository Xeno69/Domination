// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_playerconnected.sqf"
#include "..\x_setup.sqf"

__TRACE_1("Start","_this")

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

if (_name == "__SERVER__") exitWith {
	diag_log ["DOM playerconnected, Server connect: _this", _this];
};

if (_uid isEqualTo "") exitWith {};

//if (_name select [0, 9] == "HC_D_UNIT" || {_name select [0, 14] == "headlessclient"}) exitWith {};

private _pl = objectFromNetId _id;

__TRACE_1("","_pl")

if (_pl isKindOf "HeadlessClient_F") exitWith {
	__TRACE_2("","_pl","owner _pl")
	d_hc_array pushBack _pl;
	if (time > 10) then {
		if (!isNil "d_recreatehcs_handle") then {
			terminate d_recreatehcs_handle;
		};
		d_recreatehcs_handle = 0 spawn d_fnc_recreatehcs;
	};
};

if (isNull _pl || {_uid isEqualTo ""}) exitWith {
	diag_log "Domination ATTENTION!!!!!! A player connected as null object or with an empty UID";
	diag_log ["_this", _this];
	diag_log "This means the player has not connected properly, resulting in a no unit message!!!!!";
	diag_log "This may break scripts!!!!";
	if (!isNull _pl) then {
		remoteExecCall ["d_fnc_remplnounit", _pl];
	};
};

if (_pl isKindOf "VirtualSpectator_F") exitWith {
	if (d_database_found) then {
		d_virtual_spectators pushBack _uid;
	};
};

_name = _name splitString """'" joinString "";
_pl setVariable ["d_plname", _name, true];

private _p = d_player_store getVariable _uid;
private _f_c = false;
private _sidepl = side (group _pl);
__TRACE_1("","_sidepl")
if (isNil "_p") then {
	_p = [time + d_AutoKickTime, time, "", 0, str _pl, _sidepl, _name, 0, [-2, xr_max_lives] select (xr_max_lives != -1), 0, "", [], []];
	d_player_store setVariable [_uid, _p];
	_f_c = true;
	__TRACE_3("Player not found","_uid","_name","_p")
} else {
	__TRACE_1("player store before change","_p")
	if (_name != _p # 6) then {
		[11, _name, _p # 6] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
		diag_log format [localize "STR_DOM_MISSIONSTRING_942", _name, _p # 6, _uid];
	};
	if (time - (_p # 9) > 900) then {
		_p set [8, xr_max_lives];
	};
	if (_p # 0 > -1) then {
		_p set [0, time + (_p # 0)];
	};
	_p set [1, time];
	_p set [4, str _pl];
	_p set [6, _name];
#ifdef __TT__
	if (_sidepl != _p # 5) then {
		if (time - (_p # 9) < 1800) then {
			_pl setVariable ["d_no_side_change", true, true];
		} else {
			_p set [5, _sidepl];
			_f_c = true;
			d_player_store setVariable [_uid + "_scores", nil];
			_p set [11, []];
			_p set [12, []];
		};
	};
#endif
	__TRACE_1("player store after change","_p")
};

_p remoteExecCall ["d_fnc_player_stuff", owner _pl];

if (d_database_found) then {
	private _dbresult = [];
#ifndef __INTERCEPTDB__
	_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:playerGetTS:%1", _uid]);
	if (_dbresult # 0 == 1) then {
		_dbresult = _dbresult # 1;
	} else {
		_dbresult = [];
	};
#else
	// TODO Does the following work?
	//if (isNil "D_DB_plgetts_query") then {
	//	D_DB_plgetts_query = dbPrepareQueryConfig ["playerGetTS", [_uid]];
	//} else {
	//	D_DB_plgetts_query dbBindValue _uid;
	//};
	//_res = D_DB_CON dbExecute D_DB_plgetts_query;
	
	if (d_interceptdb) then {
		_dbresult = ["playerGetTS", [_uid]] call dsi_fnc_queryconfig;
	};
#endif
	diag_log ["Dom Database playerGetTS result", _dbresult];
	
	__TRACE_1("","_dbresult")
	if (_dbresult isEqualTo []) then {
		// create new database entry for UID
		__TRACE("creating new db entry");
#ifndef __INTERCEPTDB__
		"extdb3" callExtension format ["1:dom:playerInsert:%1:%2", _uid, _name];
#else
		if (d_interceptdb) then {
			["playerInsert", [_uid, _name]] call dsi_fnc_queryconfigasync;
		};
#endif
	} else {
		__TRACE("adding nums played for player in db");
#ifndef __INTERCEPTDB__
		"extdb3" callExtension format ["1:dom:numplayedAdd:%1:%2", _name, _uid];
		diag_log ["Dom Database extdb3 updating numplayed"];
#else
		if (d_interceptdb) then {
			["numplayedAdd", [_name, _uid]] call dsi_fnc_queryconfigasync;
		};
#endif
		__TRACE_1("","_f_c")
#ifdef __DEBUG__
		_uidscores = isNil {d_player_store getVariable (_uid + "_scores")};
		__TRACE_1("","_uidscores")
#endif
		if (isNil "d_set_pl_score_db") then {
			d_set_pl_score_db = true;
			publicVariable "d_set_pl_score_db";
		};
		if (d_set_pl_score_db && {_f_c && {isNil {d_player_store getVariable (_uid + "_scores")}}}) then {
			__TRACE("Adding score");
			__TRACE_1("","_dbresult select 0")
			__TRACE_1("","score _pl")
			d_player_store setVariable [_uid + "_scores", [(_dbresult # 0) # 1, (_dbresult # 0) # 2, (_dbresult # 0) # 3, (_dbresult # 0) # 4, (_dbresult # 0) # 5, (_dbresult # 0) # 0]];
			[_pl, _dbresult # 0] spawn d_fnc_initdbplscores;
		};
#ifndef __INTERCEPTDB__
		_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:playerGet:%1", _uid]);
		if (_dbresult # 0 == 1) then {
			_dbresult = _dbresult # 1;
		} else {
			_dbresult = [];
		};
#else
		if (d_interceptdb) then {
			_dbresult = ["playerGet", [_uid]] call dsi_fnc_queryconfig;
		};
#endif
		diag_log ["Dom Database playerGet result", _dbresult];
		__TRACE_1("","_dbresult")
		if !(_dbresult isEqualTo []) then {
			_dbresult params ["_pres"];
			if !(_pres isEqualTo []) then {
				_pres set [1, (_pres # 1) call d_fnc_convtime];
				[missionNamespace, ["d_pl_db_mstart", _pres]] remoteExecCall ["setVariable", _pl];
			};
		};
	};
};

_pl spawn {
	scriptName "spawn_init_playerserver2";
	sleep 1;
	[_this] call d_fnc_addceo;
};

if (d_MissionType != 2) then {
	_pl addEventhandler ["HandleScore", {_this call d_fnc_handlescore}];
};

__TRACE_1("End","_this")
