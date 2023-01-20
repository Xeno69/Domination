// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {
	__TRACE("No interface")
};

__TRACE_1("","_this")

if (_this # 0 == -99) exitWith {
	__TRACE("Assigning, cur receiver nil")
	d_top10_db_players = d_top10_db_players_client;
	d_top10_db_players_client = [];
	__TRACE_1("","d_top10_db_players")
};

d_top10_db_players_client pushBack (_this # 1);
