//#define __DEBUG__
#define THIS_FILE "fn_sidemines.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params ["_pos", "_type", ["_docreatearmor", false], ["_docreateinf", false]];

private _mines = [];
private _arrows = [];
if (_type isEqualTo "naval") then {
    for "_i" from 1 to ((ceil random 6) max 4) do {
	   private _helper = createVehicle [d_HeliHEmpty, _pos, [], 50, "NONE"];
	   private _mine = createMine ["UnderwaterMine", [getPosASL _helper # 0, getPosASL _helper # 1, random (getPosASL _helper # 2)], [], 0];
	   _mines pushBack _mine;
	   deleteVehicle _helper;
	   __TRACE_1("","_mine")
    };
} else {
	private _roads = (_pos nearRoads 150) select {count roadsConnectedto _x > 1};
	__TRACE_1("","count _roads");
	if !(_roads isEqualTo []) then {
	    for "_i" from 1 to (4 + round random 4) do {
	       private _road = selectRandom _roads;
		   _roads = _roads - [_road];
		   private _mine = createMine [selectRandom ["APERSBoundingMine", "APERSTripMine", "APERSMine", "ATMine"], [(getPos _road # 0) + 2.5 - random 5, (getPos _road # 1) + 2.5 - random 5, 0], [], 0];
		   _mine setPosATL [getPosATL _mine # 0, getPosATL _mine # 1, 0.01];
           _mines pushBack _mine;
	    };
	} else {
	    _pos = [_pos, 150] call d_fnc_getFlatArea;
	    private _arrow = "Sign_Arrow_Large_F" createVehicle [0, 0, 0];
	    _arrow setPos [_pos # 0, _pos # 1, 15];
		_arrows pushBack _arrow;
	    for "_i" from 1 to (5 + round random 5) do {
		   private _mine = createMine [selectRandom ["APERSBoundingMine","APERSTripMine","APERSMine","ATMine"], [(_pos # 0) + 25 - random 50, (_pos # 1) + 25 - random 50, 0], [], 0];
		   _mines pushBack _mine;
	    };	
	};
};

__TRACE_1("","count _mines");
#ifdef __DEBUG__
{
   [format ["mines_%1", _x], getPosASL _x, "ICON", "ColorOrange", [0.8,0.8], "mine", 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
} forEach _mines;
#endif
sleep 2;

if (_docreateinf) then {
	_diam = 300;
	if (_type isEqualTo "naval") then {
		_diam = 500;
	};
	["specops", (floor (random 4)) min 2, "allmen", (floor (random 4)) min 2, d_x_sm_pos # 0, 300, true] spawn d_fnc_CreateInf;
	sleep 2.333;
};
if (_docreatearmor) then {
	_diam = 400;
	if (_type isEqualTo "naval") then {
		_diam = 600;
	};
	[selectRandom ["aa", "tank"], 1, selectRandom ["tracked_apc", "wheeled_apc"], 2, selectRandom ["jeep_mg", "jeep_gl"], 2, d_x_sm_pos # 0, 1, 400, true] spawn d_fnc_CreateArmor;
	sleep 2.333;
	if !(_type isEqualTo "naval") then {
		["stat_mg", 1, "stat_gl", 1, "", 0, d_x_sm_pos # 0, 1, 100, false] spawn d_fnc_CreateArmor;
	};
	sleep 1;
};

{d_side_enemy revealMine _x} forEach _mines;
d_x_sm_vec_rem_ar append _mines;

private _mforceendtime = time + 4800;

while {!d_sm_resolved} do {
	sleep 5;
	if (_mines findIf {mineActive _x} == -1) exitWith {
		if (!d_sm_resolved) then {
			d_sm_winner = 2;
		};
		d_sm_resolved = true;
		if (d_IS_HC_CLIENT) then {
			[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
			[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
		};
	};
	sleep 0.1;
	if (isMultiplayer && {(call d_fnc_PlayersNumber) == 0}) then {
		_mforceendtime = _mforceendtime - time;
		waitUntil {sleep (1.012 + random 1); (call d_fnc_PlayersNumber) > 0};
		_mforceendtime = time + _mforceendtime;
	};
	sleep 0.1;
	if (time > _mforceendtime) exitWith {
		d_sm_winner = -1100;
		d_sm_resolved = true;
		if (d_IS_HC_CLIENT) then {
			[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
			[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
		};
	};
};
if !(_arrows isEqualTo []) then {{deleteVehicle _x} forEach _arrows};
