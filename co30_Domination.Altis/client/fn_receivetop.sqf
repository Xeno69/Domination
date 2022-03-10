// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_indata"];

if (_indata # 0 == -99) exitWith {
	d_top10_db_players = d_top10_db_players_client;
	d_top10_db_players_client = [];
	d_cur_receiver = nil;
};

if (_indata # 0 == 0 && {isNil "d_cur_receiver"}) then {
	d_cur_receiver = _indata # 2;
};

if (_indata # 0 > 0 && {d_cur_receiver != _indata # 2}) exitWith {};

d_top10_db_players_client pushBack (_indata # 1);
