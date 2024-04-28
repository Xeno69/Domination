// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_killed", "_killer", "_insti"];
if (isNull _insti) then {_insti = UAVControl vehicle _killer # 0}; // UAV/UGV player operated road kill
if (isNull _insti) then {_insti = _killer}; // player driven vehicle road kill

if (isNull _insti) exitWith {};

if !(_insti call d_fnc_isplayer) exitWith {};

private _score = 0;
private _type = "";
call {
	if (_killed isKindOf "Fowl_Base_F") exitWith {
		_score = -3;
		_type = "STR_DOM_MISSIONSTRING_2110"
	};
	if (_killed isKindOf "Goat_Base_F" || {_killed isKindOf "Sheep_random_F"}) exitWith {
		_score = -5;
		_type = "STR_DOM_MISSIONSTRING_2111"
	};
	if (_killed isKindOf "Dog_Base_F") exitWith {
		_score = -10;
		_type = "STR_DOM_MISSIONSTRING_2112"
	};
	if (_killed isKindOf "Snake_random_F") exitWith {
		_score = -1;
		_type = "STR_DOM_MISSIONSTRING_2113"
	};
	0
};

if (_score == 0) exitWith {};

_insti addScore _score;
[15, abs _score, _type] remoteExecCall ["d_fnc_scoreadded", _insti];
