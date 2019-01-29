// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerrank.sqf"
#include "..\..\x_setup.sqf"

private _score = score player;
private _d_player_old_rank = player getVariable ["d_player_old_rank", 0];
if (_score < d_points_needed # 0 && {_d_player_old_rank != 0}) exitWith {
	if (player getVariable ["d_player_old_score", 0] >= d_points_needed # 0) then {[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_664", _d_player_old_rank call d_fnc_GetRankIndex2]};
	_d_player_old_rank = 0;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	player setVariable ["d_player_old_score", _score];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};
if (_score < d_points_needed # 1 && {_score >= d_points_needed # 0 && {_d_player_old_rank != 1}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 1) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_665");
		playSound "d_fanfare";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_666", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 1;
	player setRank (_d_player_old_rank  call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};
if (_score < d_points_needed # 2 && {_score >= d_points_needed # 1 && {_d_player_old_rank != 2}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 2) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_667");
		playSound "d_fanfare";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_668", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 2;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};
if (_score < d_points_needed # 3 && {_score >= d_points_needed # 2 && {_d_player_old_rank != 3}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 3) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_669");
		playSound "d_fanfare";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_670", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 3;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};
if (_score < d_points_needed # 4 && {_score >= d_points_needed # 3 && {_d_player_old_rank != 4}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 4) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_671");
		playSound "d_fanfare";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_672", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 4;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};
if (_score < d_points_needed # 5 && {_score >= d_points_needed # 4 && {_d_player_old_rank != 5}}) exitWith {		
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 5) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_673");
		playSound "d_fanfare";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_674", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 5;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};
if (_score < d_points_needed # 6 && {_score >= d_points_needed # 5 && {_d_player_old_rank != 6}}) exitWith {		
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 6) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_675");
		playSound "d_fanfare";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_674a", "General"];
	};
	player setRank "Colonel";
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", 6, true];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};
if (_score >= d_points_needed # 6 && {_d_player_old_rank != 7}) exitWith {
	player setRank "Colonel";
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_675a");
	playSound "d_fanfare";
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", 7, true];
	if (d_with_ranked) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
};