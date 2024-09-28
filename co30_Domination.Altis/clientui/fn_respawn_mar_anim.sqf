// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _old_respmar = "";
private _cur_ang = 0;

private _has_sql = _this;

while {!isNil "d_teleport_off" && {(xr_max_lives != -1 && {player getVariable ["xr_lives", 0] > -1}) || {xr_max_lives == -1}}} do {
	if (d_respawn_mar_str != _old_respmar) then {
		//__TRACE_2("","d_respawn_mar_str","_old_respmar")
		_cur_ang = 0;
		if (_old_respmar isNotEqualTo "") then {
			_old_respmar setMarkerDirLocal 0;
		};
		_old_respmar = d_respawn_mar_str;
	};
	if (d_respawn_mar_str isNotEqualTo "") then {
		private _fps = diag_fps;
		if (_fps < 50) then {
			_cur_ang = _cur_ang + 5;
		} else {
			if (_fps < 80) then {
				_cur_ang = _cur_ang + 3;
			} else {
				_cur_ang = _cur_ang + 2;
			};
		};
		if (_cur_ang > 360) then {_cur_ang = _cur_ang - 360};
		_old_respmar setMarkerDirLocal _cur_ang;
	};
	if (_has_sql == 1) then {
		private _lpos = if (d_respawnatsql == 0) then {
			visiblePositionASL (leader (group player)); // assume squad leader
		} else {
			if (count units player > 0) then {
				private _unitsp = (((units player) - [player]) select {[_x] call d_fnc_iseligibletospawnnewunit}) apply {[_x distance2D (xr_death_pos # 0), _x]};
				if (_unitsp isNotEqualTo []) then {
					_unitsp sort false;
					__TRACE_1("_unitsp","")
					visiblePositionASL ((_unitsp # 0) # 1);
				} else {
#ifndef __TT__
					markerPos "base_spawn_1";
#else
					[markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
#endif
				};
			} else {
#ifndef __TT__
				markerPos "base_spawn_1";
#else
				[markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
#endif
			};
		};
		"D_SQL_D" setMarkerPosLocal _lpos;
		if (!isNil "d_respawn_posis" && !isNil "d_resp_lead_idx") then {
			d_respawn_posis set [d_resp_lead_idx, _lpos];
		};
	};
	{
		private _mrs = missionNamespace getVariable [_x # 0, objNull];
		if (!isNull _mrs) then {
			private _opos = _mrs getVariable ["d_vispos_m", [-1,-1,-1]];
			private _vpos = visiblePositionASL _mrs;
			if (_opos isNotEqualTo _vpos) then {
				(_x # 0) setMarkerPosLocal _vpos;
				_mrs setVariable ["d_vispos_m", _vpos];
			};
		};
	} forEach d_mob_respawns;
	sleep 0.01;
};

if (!isNil "d_respawn_anim_markers") then {
	{
		deleteMarkerLocal _x;
	} forEach d_respawn_anim_markers;
};
d_respawn_anim_markers = nil;
d_respawn_mar_str = nil;

deleteMarkerLocal "d_exactpos_radius_mar";
deleteMarkerLocal "d_exactpos_sel_mar";

//__TRACE("Off")