// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_buildaddrespoints.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","d_additional_respawn_points_orig")

if (d_additional_respawn_points_orig isNotEqualTo []) then {
	private _helparrp = [];
	{
		_helparrp pushBack [_x # 2, _forEachIndex];
	} forEach d_additional_respawn_points_orig;
	_helparrp sort true;
	__TRACE_1("","_helparrp")

	private _tempar =+ d_additional_respawn_points_orig;
	__TRACE_1("","_tempar")
	d_additional_respawn_points = [];
	d_add_resp_points_uni = [];
	d_add_resp_points_pos = [];
	private "_ele";
	{
		_ele = _tempar select (_x # 1);
		__TRACE_1("","_ele")
		d_additional_respawn_points pushBack _ele;
		d_add_resp_points_uni pushBack (_ele # 0);
	} forEach _helparrp;

	{
		if (_x # 1 isEqualType "") then {
			if (markerPos (_x # 1) isNotEqualTo [0,0,0]) then {
#ifdef __TT__
				if (d_player_side != _x # 3) then {
					(_x # 1) setMarkerAlphaLocal 0;
					d_additional_respawn_points set [_forEachIndex, -1];
					d_add_resp_points_uni set [_forEachIndex, -1];
				} else {
					_x set [1, markerPos (_x # 1)];
				};
#else
				_x set [1, markerPos (_x # 1)];
#endif
			} else {
#ifdef __TT__
				if (d_player_side != _x # 3) then {
					d_additional_respawn_points set [_forEachIndex, -1];
					d_add_resp_points_uni set [_forEachIndex, -1];
				} else {
					private _dadao = missionNamespace getVariable (_x # 1);
					_x set [1, getPos _dadao];
					_dadao addAction [format ["<t color='#FF0000' size='1.5'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {call d_fnc_teleportx}];
					if (d_ParaAtBase == 0) then {
						_dadao setVariable ["d_jf_id", _dadao addAction [format ["<t color='#D64C30' size='1.2'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0]];
					};
					if (count _x > 4 && {_x # 4}) then {
						_dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1816"], {[0, 0, 0, [d_create_bike # 0, 1]] spawn d_fnc_bike}];
					};
				};
#else
				private _dadao = missionNamespace getVariable (_x # 1);
				_x set [1, getPos _dadao];
				if (isNil {_dadao getVariable "d_teleidx"}) then {
					_dadao setVariable ["d_teleidx", _dadao addAction [format ["<t color='#FF0000' size='1.5'>%1</t>", localize "STR_DOM_MISSIONSTRING_533"], {call d_fnc_teleportx}]];
				};
				if (d_ParaAtBase == 0) then {
					if (isNil {_dadao getVariable "d_jf_id"}) then {
						_dadao setVariable ["d_jf_id", _dadao addAction [format ["<t color='#D64C30' size='1.2'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 0]];
					};
				};
				if (count _x > 4 && {_x # 4}) then {
					if (isNil {_dadao getVariable "d_bikeidx"}) then {
						_dadao setVariable ["d_bikeidx", _dadao addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1816"], {[0, 0, 0, [d_create_bike # 0, 1]] spawn d_fnc_bike}]];
					};
				};
#endif
			};
		};
	} forEach d_additional_respawn_points;
#ifdef __TT__
	d_additional_respawn_points = d_additional_respawn_points - [-1];
	d_add_resp_points_uni = d_add_resp_points_uni - [-1];

	private _whichm = ["d_farp_marker_b", "d_farp_marker_o"] select (d_player_side == blufor);

	{
		deleteMarkerLocal _x;
	} forEach (allMapMarkers select {_x select [0, 15] == _whichm});
#endif
	__TRACE_1("","d_additional_respawn_points")
	__TRACE_1("","d_add_resp_points_uni")
	d_add_resp_points_pos pushBack (getPos D_FLAG_BASE);
	{
		if (isNil {(_x # 6) getVariable "d_farptaken"}) then {
			d_add_resp_points_pos pushBack (_x # 1);
		};
	} forEach d_additional_respawn_points;
};

if (d_add_resp_points_pos isEqualTo []) then {
	d_add_resp_points_pos pushBack (getPos D_FLAG_BASE);
};