//#define __DEBUG__
#define THIS_FILE "fn_sidemines.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params["_pos", "_type"];

private _mines = [];
private _arrows = [];
if (_type isEqualTo "naval") then {
    for "_i" from 1 to ((ceil random 8) max 4) do {
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
	    for "_i" from 1 to (5 + round random 5) do {
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
   false
} count _mines;
#endif

{d_side_enemy revealMine _x;false} count _mines;
d_x_sm_vec_rem_ar append _mines;

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
};
if !(_arrows isEqualTo []) then {{deleteVehicle _x;false} count _arrows};
