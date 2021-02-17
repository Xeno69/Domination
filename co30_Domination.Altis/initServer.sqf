// by Xeno
//#define __DEBUG__
#define THIS_FILE "initServer.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initServer.sqf"];
if (d_with_bis_dynamicgroups == 0) then {
	diag_log "DOM initServer.sqf: BIS DynamicGroups initialzing!";
	["Initialize", [true]] call BIS_fnc_dynamicGroups;
};

// Set to true to enable autosave to sql database each time a main target gets cleared (auto save entry in DB will get deleted after last main target)
// Does load the autosave automatically if worldname and briefingName match to those saved at mission start
if (isNil "d_db_auto_save") then {
	d_db_auto_save = false;
};

if (d_database_found) then {
	diag_log ["DOM initServer.sqf: Reading DB data! World name:", worldname];
	if (!d_tt_ver) then {
		d_bonus_vecs_db = [];
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
		};
		__TRACE_1("missionsGet","_dbresult")
		if (_dbresult isNotEqualTo []) then {
			diag_log "DOM mission save games:";
			d_db_savegames = [];
			{
				d_db_savegames pushBack (_x # 0);
				diag_log ["DOM one save:", _x # 0];
			} forEach _dbresult;
			publicVariable "d_db_savegames";
			__TRACE_1("","d_db_savegames")
		};
	} else {
		d_bonus_vecs_db_w = [];
		d_bonus_vecs_db_e = [];
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
		};
		__TRACE_1("missionsttGet","_dbresult")
		if (_dbresult isNotEqualTo []) then {
			diag_log "DOM mission save games:";
			d_db_savegames = [];
			{
				d_db_savegames pushBack (_x # 0);
				diag_log ["DOM one save:", _x # 0];
			} forEach _dbresult;
			publicVariable "d_db_savegames";
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
				missionNamespace setVariable ["d_top10_db_players", _dbresult, true];

				0 spawn d_fnc_dbtoppasync;
			};
		};
		if (d_db_type == 1) exitWith {
			call d_fnc_gettoppplayers;
			//_dbresult = ["getTop10Players"] call d_fnc_queryconfig;
			0 spawn d_fnc_dbtoppasync;
		};
	};

	0 spawn d_fnc_getplayerscores;
};

// if set to true player total score saved into the external database will be added to the player score at connect (only if d_database_found is true of course)
if (isNil "d_set_pl_score_db") then {
	d_set_pl_score_db = true;
	publicVariable "d_set_pl_score_db";
	diag_log ["DOM initServer d_set_pl_score_db:", d_set_pl_score_db];
};

if (d_database_found && {d_db_auto_save}) then {
	diag_log "DOM initServer.sqf: Trying to read db autosave";
	["d_dom_db_autosave", objNull] call d_fnc_db_loadsavegame_server;
};

if (isDedicated) then {
	0 spawn {
		scriptName "spawn_initserver";
		waitUntil {time > 0};
		enableEnvironment [false, false];
		diag_log "DOM initServer environment disabled!";
	};
};

diag_log [diag_frameno, diag_ticktime, time, "MPF initServer.sqf processed"];