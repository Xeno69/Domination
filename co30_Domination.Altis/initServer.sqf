// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initServer.sqf"];
if (d_with_bis_dynamicgroups == 0) then {
	diag_log "DOM initServer.sqf: BIS DynamicGroups initialzing!";
	["Initialize", [true]] call d_fnc_dynamicGroups;
};

d_db_savegames = [];
if (!d_tt_ver) then {
	d_bonus_vecs_db = [];
} else {
	d_bonus_vecs_db_w = [];
	d_bonus_vecs_db_e = [];
};

// Set to true to enable autosave to sql database each time a main target gets cleared (auto save entry in DB will get deleted after last main target)
// Does load the autosave automatically if worldname and briefingName match to those saved at mission start
if (isNil "d_db_auto_save") then {
	d_db_auto_save = false;
};

if (d_database_found) then {
	diag_log ["DOM initServer.sqf: Reading DB data! World name:", worldname];
	if (!d_tt_ver) then {
		__TRACE_1("","worldname")
		private _dbresult = [];
		call {
			if (d_db_type == 0) exitWith {
				_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:missionsGet:%1", tolower worldname]);
				if (_dbresult # 0 == 1) then {
					_dbresult = _dbresult # 1;
				} else {
					_dbresult = [];
				};
			};
			if (d_db_type == 1) exitWith {
				_dbresult = ["missionsGet", [tolower worldname]] call d_fnc_queryconfig;
			};
			if (d_db_type == 2) exitWith {
				private _pn_missionsave = missionProfileNamespace getVariable "dom_missionsave";
				if (!isNil "_pn_missionsave") then {
					__TRACE_1("new","_pn_missionsave")
					private _wn = tolower worldname;
					__TRACE_1("","_wn")
					{
						if (_x # 11 == _wn) then {
							_dbresult pushBack _x;
						};
					} forEach _pn_missionsave;
				};
			};
		};
		__TRACE_1("missionsGet","_dbresult")
		if (_dbresult isNotEqualTo []) then {
			diag_log "DOM mission save games:";
			{
				d_db_savegames pushBack (_x # 0);
				diag_log ["DOM one save:", _x # 0];
			} forEach _dbresult;
			__TRACE_1("","d_db_savegames")
		};
	} else {
		private _dbresult = [];
		call {
			if (d_db_type == 0) exitWith {
				_dbresult = parseSimpleArray ("extdb3" callExtension format ["0:dom:missionsttGet:%1", tolower worldname]);
				if (_dbresult # 0 == 1) then {
					_dbresult = _dbresult # 1;
				} else {
					_dbresult = [];
				};
			};
			if (d_db_type == 1) exitWith {
				_dbresult = ["missionsttGet", [tolower worldname]] call d_fnc_queryconfig;
			};
			if (d_db_type == 2) exitWith {
				_pn_missionsave = missionProfileNamespace getVariable "dom_missionsavett";
				if (!isNil "_pn_missionsave") then {
					__TRACE_1("new","_pn_missionsave")
					private _wn = tolower worldname;
					__TRACE_1("","_wn")
					{
						__TRACE_1("","_x")
						if ((_x # 12) isEqualType "" && {_x # 12 == _wn}) then {
							_dbresult pushBack _x;
						};
					} forEach _pn_missionsave;
				};
			};
		};
		__TRACE_1("missionsttGet","_dbresult")
		if (_dbresult isNotEqualTo []) then {
			diag_log "DOM mission save games:";
			{
				d_db_savegames pushBack (_x # 0);
				diag_log ["DOM one save:", _x # 0];
			} forEach _dbresult;
			__TRACE_1("","d_db_savegames")
		};
	};

	call {
		if (d_db_type == 0) exitWith {
			_dbresult = parseSimpleArray ("extdb3" callExtension "0:dom:getTop10Players");
			if (_dbresult # 0 == 1) then {
				_dbresult = _dbresult # 1;
			} else {
				_dbresult = [];
			};
			__TRACE_1("getTop10Players","_dbresult")
			if (_dbresult isNotEqualTo []) then {
				diag_log "DOM Top 10 players found";
				{
					_x set [1, (_x # 1) call d_fnc_convtime];
				} forEach _dbresult;
				d_top10_db_players_serv = _dbresult;
				__TRACE_1("","d_top10_db_players_serv")

				0 spawn d_fnc_dbtoppasync;
			};
		};
		if (d_db_type == 1) exitWith {
			call d_fnc_gettoppplayers;
			//_dbresult = ["getTop10Players"] call d_fnc_queryconfig;
			0 spawn d_fnc_dbtoppasync;
		};
		if (d_db_type == 2) exitWith {
			private _tmphash = missionProfileNamespace getVariable "d_player_hashmap";
			if (isNil "_tmphash") then {
				__TRACE("_tmphash is nil")
				missionProfileNamespace setVariable ["d_player_hashmap", createHashMap];
				saveMissionProfileNamespace;
				d_top10_db_players_serv = [];
			} else {
				private _ar = [];
				{
					_ar pushBack [_y # 7, _x];
				} forEach _tmphash;
				_ar sort false;
				private _num = [(count _ar) - 1, 24] select (count _ar > 25);
				d_top10_db_players_serv = [];
				private "_har";
				for "_i" from 0 to _num do {
					_har =+ _tmphash get ((_ar # _i) # 1);
					_har set [1, (_har # 1) call d_fnc_convtime];
					_har deleteAt 14;
					d_top10_db_players_serv pushBack _har;
				};
				__TRACE_1("","d_top10_db_players_serv")
			};
			0 spawn d_fnc_dbtoppasync;
		};
	};

	0 spawn d_fnc_getplayerscores;
	
	// if set to true player total score saved into the external database will be added to the player score at connect (only if d_database_found is true of course)
	if (isNil "d_set_pl_score_db") then {
		d_set_pl_score_db = true;
		publicVariable "d_set_pl_score_db";
		diag_log ["DOM initServer d_set_pl_score_db:", d_set_pl_score_db];
	};
	
	__TRACE("initServer before loading db save games")
	if (d_db_auto_save || {d_db_type == 2 && {d_save_to_mpns == 1}}) then {
		diag_log "DOM initServer.sqf: Trying to read db autosave";
		if (!isNil "d_target_names") then {
			["d_dom_db_autosave", objNull] call d_fnc_db_loadsavegame_server;
		} else {
			0 spawn {
				scriptName "spawn_initserver2";
				waitUntil {!isNil "d_target_names"};
				["d_dom_db_autosave", objNull] call d_fnc_db_loadsavegame_server;
			};
		};
	};
};

publicVariable "d_db_savegames";

if (isDedicated) then {
	0 spawn {
		scriptName "spawn_initserver";
		waitUntil {time > 0};
		sleep 0.1;
		enableEnvironment [false, false];
		diag_log "DOM initServer environment disabled!";
	};
};

diag_log [diag_frameno, diag_ticktime, time, "MPF initServer.sqf processed"];