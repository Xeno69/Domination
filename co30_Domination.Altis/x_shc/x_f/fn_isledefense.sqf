// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_isledefense.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

#ifndef __DEBUG__
sleep 85.321;
#else
sleep 5;
d_all_igrps_vecs = [];
#endif

__TRACE("before isServer check")

if (isMultiplayer && {isServer && {!isNil "HC_D_UNIT"}}) exitWith {};

__TRACE("after isServer check")

d_old_old_start = [0,0,0];

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
					(_x # 2) findIf {
#ifndef __DEBUG__
						private _ret = (alive _x && {_x distance2D (_x getVariable ["d_cur_pos", [0, 0, 0]]) < 100}) || {!canMove _x};
#else
						private _ret = (alive _x && {_x distance2D (_x getVariable ["d_cur_pos", [0, 0, 0]]) < 10}) || {!canMove _x};
#endif
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
				_x pushBack (time + 300 + random 300);
			};
		} else {
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
				if (alive _lead && {!(((allPlayers - entities "HeadlessClient_F") select {_x distance2D _lead < 1000}) isEqualTo [])}) then {
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
		sleep 50 + random 50;
#else
		sleep 5;
#endif
	} forEach _isle_grps;
};