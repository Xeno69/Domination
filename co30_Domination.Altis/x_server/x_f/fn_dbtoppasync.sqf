// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dbtoppasync.sqf"
#include "..\..\x_setup.sqf"

while {true} do {;
	sleep 600;
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
				false
			} count (_dbresult # 1);
			missionNamespace setVariable ["d_top10_db_players", _dbresult # 1, true];
		};
	};
};