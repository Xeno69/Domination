// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initPlayerServer.sqf"
#include "..\x_setup.sqf"

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerServer.sqf"];
#endif
__TRACE_1("","_this")

params ["_pl"];

if (remoteExecutedOwner != owner _pl) exitWith {};

if (_pl isKindOf "HeadlessClient_F") exitWith {
	__TRACE_2("","_pl","owner _pl")
	diag_log ["Dom initplayerserver headleass client connected"];
	d_hc_array pushBack _pl;
	if (time > 10) then {
		if (!isNil "d_recreatehcs_handle") then {
			terminate d_recreatehcs_handle;
		};
		d_recreatehcs_handle = 0 spawn d_fnc_recreatehcs;
	};
};

private _uid = getPlayerUID _pl;

if (_pl isKindOf "VirtualSpectator_F") exitWith {
	if (d_database_found) then {
		d_virtual_spectators pushBack _uid;
	};
};

if (isNull _pl || {_uid isEqualTo ""}) exitWith {
	diag_log "Domination ATTENTION!!!!!! A player connected as null object or with an empty UID";
	diag_log ["_this", _this];
	diag_log "This means the player has not connected properly, resulting in a no unit message!!!!!";
	diag_log "This may break scripts!!!!";
};

#ifndef __TT__
[_pl, 18] call d_fnc_setekmode;
#endif

private _name = name _pl;

private _p = d_player_hash getOrDefault [_uid, []];
private _f_c = false;
private _sidepl = side (group _pl);
__TRACE_1("","_sidepl")
if (_p isEqualTo []) then {
	_p = [time + d_AutoKickTime, time, "", 0, "", _sidepl, _name, 0, [-2, xr_max_lives] select (xr_max_lives != -1), [0, 0], "", [], [], 0, 0, [], 0, 0, getPlayerID _pl];
	d_player_hash set [_uid, _p];
	_f_c = true;
	diag_log ["Dom initplayerserver, new player for this session:", _name, "_uid:", _uid, "getPlayerID _pl:", getPlayerID _pl];
	__TRACE_3("Player not found in d_player_hash","_uid","_name","_p")
} else {
	__TRACE_1("player store before change","_p")
	if (_name != _p # 6) then {
		[22, _name, _p # 6] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
		diag_log format [localize "STR_DOM_MISSIONSTRING_942", _name, _p # 6, _uid];
	};
	if ((_p # 9) # 0 > 0 && {time - ((_p # 9) # 0) > 900}) then {
		_p set [8, [-2, xr_max_lives] select (xr_max_lives != -1)];
		_p set [9, [0, (_p # 9) # 1]];
	};
	if (_p # 0 > -1) then {
		_p set [0, time + (_p # 0)];
	};
	_p set [1, time];
	_p set [6, _name];
	_p set [14, 0];
	_p set [18, getPlayerID _pl];
#ifdef __TT__
	if (_sidepl != _p # 5) then {
		if ((_p # 9) # 1 > 0 && {time - ((_p # 9) # 1) < 1800}) then {
			_pl setVariable ["d_no_side_change", true, true];
			__TRACE_1("d_no_side_change set to","_pl")
		} else {
			_p set [5, _sidepl];
			_f_c = true;
			d_player_hash deleteAt (_uid + "_scores");
			_p set [11, []];
			_p set [12, []];
			if ((_p # 9) # 1 > 0) then {
				_p set [9, [(_p # 9) # 0, 0]];
			};
		};
	};
#endif
	diag_log ["Dom initplayerserver, player joins session again:", _name, "_uid:", _uid, "getPlayerID _pl:", getPlayerID _pl];
	__TRACE_1("player store after change","_p")
};

if (d_database_found) then {
	private _dbresult = [];
	call {
		if (d_db_type == 0) exitWith {
			_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:playerGetTS:%1", _uid]);
			if (_dbresult # 0 == 1) then {
				_dbresult = _dbresult # 1;
			} else {
				_dbresult = [];
			};
		};
		if (d_db_type == 1) exitWith {
			_dbresult = ["playerGetTS", [_uid]] call d_fnc_queryconfig;
		};
	};
	diag_log ["Dom initplayerserver database playerGetTS result", _dbresult];

	__TRACE_1("","_dbresult")
	if (_dbresult isEqualTo []) then {
		// create new database entry for UID
		__TRACE("creating new db entry");
		call {
			if (d_db_type == 0) exitWith {
				"extdb3" callExtension format ["1:dom:playerInsert:%1:%2", _uid, _name];
				diag_log ["Dom initplayerserver database extdB3 player Insert", _name];
			};
			if (d_db_type == 1) exitWith {
				["playerInsert", [_uid, _name]] call d_fnc_queryconfigasync;
				diag_log ["Dom initplayerserver database InterceptDB player Insert", _name];
			};
		};
	} else {
		__TRACE("adding nums played for player in db");
		call {
			if (d_db_type == 0) exitWith {
				"extdb3" callExtension format ["1:dom:numplayedAdd:%1:%2", _name, _uid];
				diag_log ["Dom initplayerserver database extdB3 updating numplayed:", _name];
			};
			if (d_db_type == 1) exitWith {
				["numplayedAdd", [_name, _uid]] call d_fnc_queryconfigasync;
				diag_log ["Dom initplayerserver database InterceptDB updating numplayed", _name];
			};
		};
		__TRACE_1("","_f_c")
		if (isNil "d_set_pl_score_db") then {
			d_set_pl_score_db = true;
			publicVariable "d_set_pl_score_db";
		};
		if (d_set_pl_score_db && {_f_c && {(d_player_hash getOrDefault [_uid + "_scores", []]) isEqualTo []}}) then {
			__TRACE("Adding score");
			__TRACE_1("","_dbresult select 0")
			__TRACE_1("","score _pl")
			d_player_hash set [_uid + "_scores", [(_dbresult # 0) # 1, (_dbresult # 0) # 2, (_dbresult # 0) # 3, (_dbresult # 0) # 4, (_dbresult # 0) # 5, (_dbresult # 0) # 0]];
			[_pl, _dbresult # 0] spawn d_fnc_initdbplscores;
		};
		call {
			if (d_db_type == 0) exitWith {
				_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:playerGet:%1", _uid]);
				if (_dbresult # 0 == 1) then {
					_dbresult = _dbresult # 1;
				} else {
					_dbresult = [];
				};
			};
			if (d_db_type == 1) exitWith {
				_dbresult = ["playerGet", [_uid]] call d_fnc_queryconfig;
			};
		};
		diag_log ["Dom initplayerserver database playerGet result", _dbresult];
		__TRACE_1("","_dbresult")
		if (_dbresult isNotEqualTo []) then {
			_dbresult params ["_pres"];
			if (_pres isNotEqualTo []) then {
				if (count _pres > 14) then {
					_p set [15, _pres # 14];
				};
				if (count _pres > 15) then {
					_p set [16, _pres # 15];
				};
				if (count _pres > 16) then {
					_p set [17, _pres # 16];
				};
				__TRACE_1("44","_p")
				_pres set [1, (_pres # 1) call d_fnc_convtime];
				__TRACE_1("44","_pres")
				_pres deleteAt 14;
				__TRACE_1("55","_pres")
				if (isMultiplayer) then {
					if (remoteExecutedOwner isEqualTo 0) exitWith {};
					_pres remoteExecCall ["d_fnc_setdbstart", remoteExecutedOwner];
				} else {
					_pres call d_fnc_setdbstart;
				};
			};
		};
	};
};

if (remoteExecutedOwner isEqualTo 0) exitWith {};
_p remoteExecCall ["d_fnc_player_stuff", remoteExecutedOwner];

_pl spawn {
	scriptName "spawn_init_playerserver2";
	sleep 1;
	[_this] call d_fnc_addceo;
};

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerServer.sqf processed"];
#endif

if (d_MissionType != 2) then {
	_pl addEventhandler ["HandleScore", {call d_fnc_handlescore}];
};

(group _pl) setVariable ["d_pl_gr", true];
