// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _score = score player;
private _d_player_old_rank = player getVariable ["d_player_old_rank", 0];
if (_score < d_points_needed # 0 && {_d_player_old_rank == 0}) exitWith {};
if (_score < d_points_needed # 0 && {_d_player_old_rank != 0}) exitWith {
	if (player getVariable ["d_player_old_score", 0] >= d_points_needed # 0) then {[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_664", _d_player_old_rank call d_fnc_GetRankIndex2]};
	_d_player_old_rank = 0;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	player setVariable ["d_player_old_score", _score];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 1) then {
				player setUnitTrait ["loadCoef", 1];
			};
		};
	};
};
if (_score < d_points_needed # 1 && {_score >= d_points_needed # 0 && {_d_player_old_rank == 1}}) exitWith {};
if (_score < d_points_needed # 1 && {_score >= d_points_needed # 0 && {_d_player_old_rank != 1}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 1) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_665");
		//playSound "d_fanfare";
		playSound "d_rankup";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_666", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 1;
	player setRank (_d_player_old_rank  call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 0.9) then {
				player setUnitTrait ["loadCoef", 0.9];
			};
		};
	};
};
if (_score < d_points_needed # 2 && {_score >= d_points_needed # 1 && {_d_player_old_rank == 2}}) exitWith {};
if (_score < d_points_needed # 2 && {_score >= d_points_needed # 1 && {_d_player_old_rank != 2}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 2) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_667");
		//playSound "d_fanfare";
		playSound "d_rankup";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_668", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 2;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 0.8) then {
				player setUnitTrait ["loadCoef", 0.8];
			};
		};
	};
};
if (_score < d_points_needed # 3 && {_score >= d_points_needed # 2 && {_d_player_old_rank == 3}}) exitWith {};
if (_score < d_points_needed # 3 && {_score >= d_points_needed # 2 && {_d_player_old_rank != 3}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 3) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_669");
		//playSound "d_fanfare";
		playSound "d_rankup";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_670", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 3;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 0.7) then {
				player setUnitTrait ["loadCoef", 0.7];
			};
		};
	};
};
if (_score < d_points_needed # 4 && {_score >= d_points_needed # 3 && {_d_player_old_rank == 4}}) exitWith {};
if (_score < d_points_needed # 4 && {_score >= d_points_needed # 3 && {_d_player_old_rank != 4}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 4) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_671");
		//playSound "d_fanfare";
		playSound "d_rankup";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_672", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 4;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 0.6) then {
				player setUnitTrait ["loadCoef", 0.6];
			};
		};
	};
};
if (_score < d_points_needed # 5 && {_score >= d_points_needed # 4 && {_d_player_old_rank == 5}}) exitWith {};
if (_score < d_points_needed # 5 && {_score >= d_points_needed # 4 && {_d_player_old_rank != 5}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 5) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_673");
		//playSound "d_fanfare";
		playSound "d_rankup";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_674", _d_player_old_rank call d_fnc_GetRankIndex2];
	};
	_d_player_old_rank = 5;
	player setRank (_d_player_old_rank call d_fnc_GetRankIndex2);
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", _d_player_old_rank, true];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 0.5) then {
				player setUnitTrait ["loadCoef", 0.5];
			};
		};
	};
};
if (_score < d_points_needed # 6 && {_score >= d_points_needed # 5 && {_d_player_old_rank == 6}}) exitWith {};
if (_score < d_points_needed # 6 && {_score >= d_points_needed # 5 && {_d_player_old_rank != 6}}) exitWith {
	if (player getVariable ["d_player_old_score", 0] < d_points_needed # 6) then {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_675");
		//playSound "d_fanfare";
		playSound "d_rankup";
	} else {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_674a", "General"];
	};
	player setRank "Colonel";
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", 6, true];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 0.4) then {
				player setUnitTrait ["loadCoef", 0.4];
			};
		};
	};
};
if (_score >= d_points_needed # 6 && {_d_player_old_rank != 7}) exitWith {
	player setRank "Colonel";
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_675a");
	//playSound "d_fanfare";
	playSound "d_rankup";
	player setVariable ["d_player_old_score", _score];
	player setVariable ["d_player_old_rank", 7, true];
	if (d_with_ranked && {!d_no_ranked_weapons}) then {
		0 spawn d_fnc_weaponcargo_ranked;
	};
	if (d_enablefatigue == 1) then {
		if (d_with_ranked || {d_database_found}) then {
			if (player getUnitTrait "loadCoef" != 0.3) then {
				player setUnitTrait ["loadCoef", 0.3];
			};
		};
	};
};