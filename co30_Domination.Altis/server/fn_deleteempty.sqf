// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_delpos", "_tradius", "_delfirebase_objects", "_mtmissionobjs", "_delvecsmt", "_house_objects"];

{
	_delfirebase_objects pushBackUnique _x;
	_x setVariable ["d_v_p_mt_t", getPosATL _x];
	sleep 0.01;
} forEach _delvecsmt;

private _tradplus = _tradius + 100;
private _delmines = allMines select {_x distance2D _delpos < _tradplus};
__TRACE_2("","_tradplus","_delmines")

sleep 90 + random 60;

__TRACE("90+ secs sleep over")

if (!isNil "d_delstuff_run") then {
	__TRACE("Waiting for d_delstuff_run")
	waitUntil {sleep 1; isNil "d_delstuff_run"};
};

d_delempty_run = true;

private _vecs = [];
{_vecs append _x; sleep 0.01} forEach (missionNamespace getVariable format ["d_veh_a_%1", d_enemy_side_short]);
__TRACE_1("","_vecs")

// all entities of enemy type
private _no = _delpos nearEntities [_vecs, _tradius];
__TRACE_1("","_no")

if (_no isNotEqualTo []) then {
	{
		if (_x getVariable "d_do_not_delete" != 1) then {
			if ((crew _x) findIf {_x call d_fnc_isplayer} == -1) then {
				_x call d_fnc_DelVecAndCrew;
			} else {
				_x call d_fnc_dpcpbv;
			};
		};
		sleep 0.1;
	} forEach _no;
};

if (_delfirebase_objects isNotEqualTo []) then {
	{
		private _d_v_p_mt_t = _x getVariable "d_v_p_mt_t";
		if (isNil "_d_v_p_mt_t") then {
			_x call d_fnc_DelVecAndCrew;
		} else {
			if (_x distance2D _d_v_p_mt_t < 100) then {
				_x call d_fnc_DelVecAndCrew;
			};
		};
		sleep 0.1;
	} forEach (_delfirebase_objects select {!isNull _x});
};

deleteVehicle _delmines;

{
	if (_x isKindOf "House") then {_x setDamage 0};
	deleteVehicle _x;
	sleep 0.3;
} forEach (_mtmissionobjs select {!isNull _x});

sleep 0.1;

{
	_x setDamage 0;
	sleep 0.3;
} forEach _house_objects;

d_delempty_run = nil;

__TRACE("Done")

