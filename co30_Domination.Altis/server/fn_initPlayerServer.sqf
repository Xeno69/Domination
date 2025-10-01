// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerServer.sqf"];
#endif
__TRACE_1("","_this")

if (!isMultiplayer) exitWith {};

params ["_pl"];

if (isNull _pl) exitWith {
	diag_log "Domination ATTENTION!!!!!! A player connected as null object";
	diag_log ["_this", _this];
	diag_log "This means the player has not connected properly, resulting in a no unit message!!!!!";
	diag_log "This may break scripts!!!!";
};

private _plid = getPlayerID _pl;
__TRACE_1("","_plid")
__TRACE_1("","getUserInfo _plid")

if (_plid getUserInfo 7) exitWith {
	__TRACE_2("","_pl","owner _pl")
#ifdef __DEBUG__
	diag_log ["Dom initplayerserver headless client connected"];
#endif
	d_hc_array pushBack _pl;
	if (time > 10) then {
		if (!isNil "d_recreatehcs_handle") then {
			terminate d_recreatehcs_handle;
		};
		d_recreatehcs_handle = 0 spawn d_fnc_recreatehcs;
	};
};

if (remoteExecutedOwner != owner _pl || {_pl isKindOf "VirtualSpectator_F"}) exitWith {
	__TRACE_2("","_pl","owner _pl")
};

private _uid = _plid getUserInfo 2;

if (_uid isEqualTo "") exitWith {
	diag_log "Domination ATTENTION!!!!!! A player connected with an empty UID";
	diag_log ["_this", _this];
	diag_log "This means the player has not connected properly, resulting in a no unit message!!!!!";
	diag_log "This may break scripts!!!!";
};

#ifndef __TT__
[_pl, 18] call d_fnc_setekmode;
#endif

_pl setVariable ["d_lr_ti", -1];

private _name = _plid getUserInfo 3;

private _p = d_player_hash getOrDefault [_uid, []];
private _f_c = false;
private _sidepl = side (group _pl);
__TRACE_1("","_sidepl")
if (_p isEqualTo []) then {
	_p = [time + d_AutoKickTime, time, "", 0, "", _sidepl, _name, 0, [-2, xr_max_lives] select (xr_max_lives != -1), [0, 0], "", [], [], 0, 0, [], 0, 0, _plid];
	d_player_hash set [_uid, _p];
	_f_c = true;
#ifdef __DEBUG__
	diag_log ["Dom initplayerserver, new player for this session:", _name, "_uid:", _uid, "_plid:", _plid];
#endif
	__TRACE_3("Player not found in d_player_hash","_uid","_name","_p")
} else {
	__TRACE_1("player store before change","_p")
	if (_name != _p # 6) then {
		[22, _name, _p # 6] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
#ifdef __DEBUG__
		diag_log format [localize "STR_DOM_MISSIONSTRING_942", _name, _p # 6, _uid];
#endif
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
	_p set [18, _plid];
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
#ifdef __DEBUG__
	diag_log ["Dom initplayerserver, player joins session again:", _name, "_uid:", _uid, "_plid:", _plid];
#endif
	__TRACE_1("player store after change","_p")
};

// Wait until missionProfileNamespace is loaded on the server before using it when running without an external DB
if (d_db_type == 2) then {
	// Arma 3 2.10+ adds isMissionProfileNamespaceLoaded. Only wait on server side.
    waitUntil { isMissionProfileNamespaceLoaded };
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
		if (d_db_type == 2) exitWith {
            private _tmphash = missionProfileNamespace getVariable ["d_player_hashmap", createHashMap];
if (!isNil "_tmphash") then {
				__TRACE_1("","_tmphash")
				private _tmpar = _tmphash get _uid;
				if (!isNil "_tmpar") then {
					_dbresult = [[_tmpar # 7, _tmpar # 2, _tmpar # 3, _tmpar # 4, _tmpar # 5, _tmpar # 6]];
					__TRACE_1("11","_dbresult")
				};
			};
		};
	};
#ifdef __DEBUG__
	diag_log ["Dom initplayerserver database playerGetTS result", _dbresult];
#endif

	__TRACE_1("","_dbresult")
	if (_dbresult isEqualTo []) then {
		// create new database entry for UID
		__TRACE("creating new db entry");
		call {
			if (d_db_type == 0) exitWith {
				"extdb3" callExtension format ["1:dom:playerInsert:%1:%2", _uid, _name];
#ifdef __DEBUG__
				diag_log ["Dom initplayerserver database extdB3 player Insert", _name];
#endif
			};
			if (d_db_type == 1) exitWith {
				["playerInsert", [_uid, _name]] call d_fnc_queryconfigasync;
#ifdef __DEBUG__
				diag_log ["Dom initplayerserver database InterceptDB player Insert", _name];
#endif
			};
			if (d_db_type == 2) exitWith {
                private _tmphash = missionProfileNamespace getVariable ["d_player_hashmap", createHashMap];
if (!isNil "_tmphash") then {
					_tmphash set [_uid, [_name, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, [], 0, 0]];
					__TRACE_1("player insert","_tmphash")
					saveMissionProfileNamespace;
#ifdef __DEBUG__
					diag_log ["Dom initplayerserver database missionProfileNamespace player Insert", _name];
#endif
				};
			};
		};
	} else {
		__TRACE("adding nums played for player in db");
		call {
			if (d_db_type == 0) exitWith {
				"extdb3" callExtension format ["1:dom:numplayedAdd:%1:%2", _name, _uid];
#ifdef __DEBUG__
				diag_log ["Dom initplayerserver database extdB3 updating numplayed:", _name];
#endif
			};
			if (d_db_type == 1) exitWith {
				["numplayedAdd", [_name, _uid]] call d_fnc_queryconfigasync;
#ifdef __DEBUG__
				diag_log ["Dom initplayerserver database InterceptDB updating numplayed", _name];
#endif
			};
			if (d_db_type == 2) exitWith {
                private _tmphash = missionProfileNamespace getVariable ["d_player_hashmap", createHashMap];
if (!isNil "_tmphash") then {
					__TRACE_1("num played","_tmphash")
					private _tmpar = _tmphash get _uid;
					if (!isNil "_tmpar") then {
						_tmpar set [10, (_tmpar # 10) + 1];
						__TRACE_1("num played","_tmpar")
					};
#ifdef __DEBUG__
					diag_log ["Dom initplayerserver database missionProfileNamespace updating numplayed", _name];
#endif
				};
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
			if (d_db_type == 2) exitWith {
                private _tmphash = missionProfileNamespace getVariable ["d_player_hashmap", createHashMap];
if (!isNil "_tmphash") then {
					__TRACE_1("playerGet","_tmphash")
					private _tmpar = _tmphash get _uid;
					if (!isNil "_tmpar") then {
						__TRACE_1("playerGet","_tmpar")
						_dbresult = [_tmpar];
						__TRACE_1("playerGet","_dbresult")
					};
				};
			};
		};
#ifdef __DEBUG__
		diag_log ["Dom initplayerserver database playerGet result", _dbresult];
#endif
		__TRACE_1("","_dbresult")
		if (_dbresult isNotEqualTo []) then {
			_dbresult params ["_pres"];
			if (_pres isNotEqualTo []) then {
				private _arpr =+ _pres;
				__TRACE_1("4xx4","_arpr")
				if (count _arpr > 14) then {
					_p set [15, _arpr # 14];
				};
				if (count _arpr > 15) then {
					_p set [16, _arpr # 15];
				};
				if (count _arpr > 16) then {
					_p set [17, _arpr # 16];
				};
				__TRACE_1("44","_p")
				_arpr set [1, (_arpr # 1) call d_fnc_convtime];
				__TRACE_1("44","_arpr")
				_arpr deleteAt 14;
				__TRACE_1("55","_arpr")
				if (isMultiplayer) then {
					if (remoteExecutedOwner isEqualTo 0) exitWith {};
					_arpr remoteExecCall ["d_fnc_setdbstart", remoteExecutedOwner];
				} else {
					_arpr call d_fnc_setdbstart;
				};
			};
		};
	};
};

if (!isNil "d_pl_mt_score_hash") then {
	[_uid, _pl, _name] spawn {
		params ["_uid", "_pl", "_name"];
		scriptName "spawn_init_playerserver3";
		sleep 1;
		if (!isNil "d_pl_mt_score_hash" && {!isNull _pl}) then {
			if !(_uid in d_pl_mt_score_hash) then {
				__TRACE_1("adding player to d_pl_mt_score_hash","_uid")
				__TRACE_3("","score _pl","_pl","_name")
				d_pl_mt_score_hash set [_uid, [score _pl, _pl, _name]];
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

