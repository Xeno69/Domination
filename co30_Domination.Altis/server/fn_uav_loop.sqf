// by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"


while {true} do {
	{
		private _m = magazinesAmmo _x;
		private _missile_maginfo = _m select { _x # 0 == "6Rnd_LG_scalpel" };
		if (!alive _x || {_missile_maginfo isEqualTo []}) then {
			diag_log [format["no more missiles, time to despawn this vehicle _vecu: %1", _x]];
			sleep 17;
			d_cur_uav_combat deleteAt (d_cur_uav_combat find _x);
			publicVariable "d_cur_uav_combat";
			deleteVehicle _x;
		} else {
			if (d_cur_tgt_pos isNotEqualTo [] && {(_x getVariable "d_loiter_pos") isNotEqualTo d_cur_tgt_pos}) then {
				diag_log ["maintarget pos has changed, moving combat UAV to new maintarget"];
				private _loiter_pos = d_cur_tgt_pos;
				private _grp = group _x;
				// set loiter waypoint
				private _loiter_radius = 800;
				if (d_cur_target_radius > 0) then {
					_loiter_radius = d_cur_target_radius + 500;
				};
				
				// must first order MOVE before LOITER for some reason...
				deleteWaypoint [_grp, 1];
				_wp = _grp addWaypoint [_loiter_pos, 1];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
				_wp setWaypointCombatMode "BLUE";
				_grp setCurrentWaypoint [_grp, 1];
				
				sleep 3;
				
				// order LOITER
				deleteWaypoint [_grp, 2];
				_wp = _grp addWaypoint [_loiter_pos, 2];
				_wp setWaypointType "LOITER";
				_wp setWaypointLoiterType "CIRCLE_L";
				_wp setWaypointLoiterRadius _loiter_radius;
				_wp setWaypointBehaviour "CARELESS";
				_wp setWaypointCombatMode "BLUE";
				_grp setCurrentWaypoint [_grp, 2];
				
				_x setVariable["d_loiter_pos", _loiter_pos, true];
			};
		};
	} forEach d_cur_uav_combat;
	sleep 7;
};