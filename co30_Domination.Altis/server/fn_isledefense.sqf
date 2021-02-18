// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_isledefense.sqf"
#include "..\x_setup.sqf"

#ifndef __DEBUG__
sleep 85.321;
#else
sleep 5;
d_all_igrps_vecs = [];
#endif

d_old_old_start = [0, 0, 0];

private _isle_grps = [];
for "_i" from 1 to (d_with_isledefense # 4) do {
	_isle_grps pushBack (call d_fnc_make_isle_grp);
	sleep 3.012;
};
__TRACE_1("","_isle_grps")

while {true} do {
#ifndef __DEBUG__
	sleep 300 + random 300;
#else
	sleep 10;
#endif
	{
		__TRACE_1("","_x")
		if (count _x == 3) then {
			_x params ["_igrp"];
			private _make_new = false;
#ifdef __DEBUG__
			d_all_igrps_vecs append (_x # 2);
#endif
			if (!isNull _igrp) then {
				if ((units _igrp) findIf {alive _x} == -1) then {
					_make_new = true;
				} else {
					private _dummy = (_x # 2) findIf {
#ifndef __DEBUG__
						private _ret = !alive _x || {!canMove _x || {_x distance2D (_x getVariable ["d_cur_pos", [0, 0, 0]]) < 100}};
#else
						private _ret = !alive _x || {!canMove _x || {_x distance2D (_x getVariable ["d_cur_pos", [0, 0, 0]]) < 10}};
						
						__TRACE_2("","alive _x","canMove _x")
						_dist2d = _x distance2D (_x getVariable ["d_cur_pos", [0, 0, 0]]);
						_curpos2d = _x getVariable ["d_cur_pos", [0, 0, 0]];
						__TRACE_3("","_dist2d","getPos _x","_curpos2d")
#endif
						__TRACE_1("","_ret")
						if (!_ret) then {
							_x setVariable ["d_cur_pos", getPosASL _x];
						} else {
							_make_new = true;
						};
						_ret
					};
				};
			} else {
				_make_new = true;
			};
			__TRACE_2("","_igrp","_make_new")
			sleep 0.3;
			if (_make_new) then {
#ifndef __DEBUG__
				_x pushBack (time + 300 + random 300);
#else
				_x pushBack (time + 30 + random 30);
#endif
			};
		} else {
			__TRACE_2("","_x","time")
			if (time > (_x # 3)) then {
				private _lead = leader (_x # 0);
				if (!alive _lead) then {
					private _idx = (_x # 1) findIf {alive _x};
					if (_idx != -1) then {
						_lead = (_x # 1) # _idx;
					} else {
						_idx = (_x # 2) findIf {alive _x};
						if (_idx != -1) then {
							_lead = (_x # 2) # _idx;
						};
					};
				};
				private _dodelu = true;
				if (alive _lead && {((allPlayers - entities "HeadlessClient_F") select {_x distance2D _lead < 1000}) isNotEqualTo []}) then {
					_dodelu = false;
				};
				__TRACE("Time reached for new group")
				if (_dodelu) then {
					{_x call d_fnc_DelVecAndCrew; sleep 0.01} forEach ((_x # 2) select {!isNull _x});
					sleep 0.01;
					{deleteVehicle _x; sleep 0.01} forEach (_x # 1);
					_isle_grps set [_forEachIndex, call d_fnc_make_isle_grp];
				};
				sleep 3.012;
			};
		};
#ifndef __DEBUG__
		sleep 70 + random 70;
#else
		sleep 5;
#endif
	} forEach _isle_grps;
};