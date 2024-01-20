// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_trig", "_type"];

private _vec = _trig getVariable "d_vec";
private _timetotake = _vec getVariable "d_timetotake";

__TRACE_2("","_vec","_timetotake")

private _last_t = time;

while {true} do {
	sleep 1;
	if (_vec getVariable ["d_mt_done", false]) exitWith {};
	private _t = _vec getVariable "d_taketime";
	_t = _t + (time - _last_t);
	__TRACE_1("","_t")
	_vec setVariable ["d_taketime", _t, true];
	_last_t = time;
	__TRACE_1("","_last_t")
	
	if (_t >= _timetotake) exitWith {
		isNil {
			if (_type == 0) exitWith {
				private _etrig = _vec getVariable "d_bar_trig";
				if (!isNil "_etrig") then {
					deleteVehicle _etrig;
				};
				private _mt_done = _vec getVariable ["d_mt_done", false];
				__TRACE_1("","_mt_done")
				if (!_mt_done) then {
					d_num_barracks_objs = d_num_barracks_objs - 1;
					d_groups_respawn_time_add = d_groups_respawn_time_add + 20 + (random 8);
					publicVariable "d_num_barracks_objs";
					__TRACE_1("","d_num_barracks_objs")
				};
				if (d_num_barracks_objs == 0) then {
					if (!_mt_done) then {
						d_mt_barracks_down = true;
#ifndef __TT__
						[51] call d_fnc_DoKBMsg;
#else
						[57] call d_fnc_DoKBMsg;
#endif
					};
				} else {
					if (!_mt_done) then {
#ifndef __TT__
						[55, d_num_barracks_objs] call d_fnc_DoKBMsg;
#else
						[58, d_num_barracks_objs] call d_fnc_DoKBMsg;
#endif
					};
				};
				if (!_mt_done) then {
					{
						if (isPlayer [_x]) then {
							[_x, 1] call d_fnc_addScore;
#ifdef __TT__
							[d_tt_points # 2, _x, false] call d_fnc_AddPoints;
							if (side (group _x) == blufor) then {
								[59, "WEST"] call d_fnc_DoKBMsg
							} else {
								if (side (group _x) == opfor) then {
									[59, "EAST"] call d_fnc_DoKBMsg
								};
							};
#endif
						};
					} forEach list _trig;
				};
				d_mt_barracks_obj_ar = d_mt_barracks_obj_ar - [_vec, objNull];
				d_mt_barmhq_ar = d_mt_barmhq_ar - [_vec, objNull];
				publicVariable "d_mt_barmhq_ar";
				_vec setDamage 1;
				_vec spawn {
					scriptName "barmhqtrig spawn";
					sleep 20;
					deleteVehicle _this;
				};
				deleteVehicle _trig;
			};
			if (_type == 1) exitWith {
				d_mt_mobile_hq_down = true;
				publicVariable "d_mt_mobile_hq_down";
				private _mt_done = _vec getVariable ["d_mt_done", false];
				__TRACE_1("","_mt_done")
				if (!_mt_done) then {
#ifndef __TT__
					if (d_force_isstreamfriendlyui == 1) then {
						// todo - add an audio notification
					} else {
						[53] call d_fnc_DoKBMsg;
					};
#else
					[60] call d_fnc_DoKBMsg;
#endif
				};
				if (!_mt_done) then {
					{
						if (isPlayer [_x]) then {
							[_x, 2] call d_fnc_addScore;
						};
					} forEach list _trig;
				};
				_vec spawn {
					scriptName "spawn barmhqtrig 2";
					sleep 20;
					deleteVehicle _this;
				};
				deleteVehicle _trig;
			};
		};
	};
};
