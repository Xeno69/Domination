// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _points_blufor_old = -1;
private _points_opfor_old = -1;
private _kill_points_blufor_old = -1;
private _kill_points_opfor_old = -1;

while {true} do {
	sleep 1.516;
	if (d_public_points) then {
		__TRACE_2("","d_points_blufor","_points_blufor_old")
		if (d_points_blufor != _points_blufor_old || {d_points_opfor != _points_opfor_old || {d_kill_points_blufor != _kill_points_blufor_old || {d_kill_points_opfor != _kill_points_opfor_old}}}) then {
			d_points_array = [d_points_blufor,d_points_opfor,d_kill_points_blufor,d_kill_points_opfor];
			publicVariable "d_points_array";
			_points_blufor_old = d_points_blufor;
			_points_opfor_old = d_points_opfor;
			_kill_points_blufor_old = d_kill_points_blufor;
			_kill_points_opfor_old = d_kill_points_opfor;
		};
	};
};
