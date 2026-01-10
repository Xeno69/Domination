// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

0 spawn {
	scriptName "spawn_dbtoppasync";
	while {true} do {
#ifndef __DEBUG__
		sleep (500 + random 120);
#else
		sleep 1;
#endif
		call {
			if (d_db_type == 0) exitWith {
				_dbresult = parseSimpleArray ("extdb3" callExtension "2:dom:getTop10Players");
				__TRACE_1("","_dbresult")
				if (_dbresult # 0 == 2) then {
					sleep 3;
					_dbresult = parseSimpleArray ("extdb3" callExtension format ["4:%1", _dbresult # 1]);
					while {_dbresult # 0 == 3} do {sleep 3};
					sleep 0.1;
					if (_dbresult # 0 == 1) then {
						{
							_x set [1, (_x # 1) call d_fnc_convtime];
						} forEach (_dbresult # 1);
						d_top10_db_players_serv = _dbresult # 1;
						objNull spawn d_fnc_sendtopplayers;
					};
				};
			};
			if (d_db_type == 1) exitWith {
				call d_fnc_gettoppplayers;
				objNull spawn d_fnc_sendtopplayers;
			};
			if (d_db_type == 2) exitWith {
				private _tmphash = missionProfileNamespace getVariable "d_player_hashmap";
				__TRACE_1("","_tmphash")
				if (count _tmphash > 0) then {
					private _ar = [];
					{
						_ar pushBack [_y # 7, _x];
					} forEach _tmphash;
					_ar sort false;
					private _num = [(count _ar) - 1, 24] select (count _ar > 25);
					private "_har";
					for "_i" from 0 to _num do {
						_har =+ _tmphash get ((_ar # _i) # 1);
						_har set [1, (_har # 1) call d_fnc_convtime];
						_har deleteAt 14;
						d_top10_db_players_serv pushBack _har;
					};
					__TRACE_1("","d_top10_db_players_serv")
					objNull spawn d_fnc_sendtopplayers;
				};
			};
		};
	};
};

while {true} do {
#ifndef __DEBUG__
	if (d_db_type == 2 && {!isDedicated}) then {
		sleep (60 + random 10);
	} else {
		sleep 300;
	};
#else
	sleep 10;
#endif
	[true] call d_fnc_db_pl_save;
};
