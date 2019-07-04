// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_gdbfunctions.sqf"
#include "x_setup.sqf"

#ifdef __GROUPDEBUG__
// the group debug functions are not available in a mission release, no need to compile them with compileFinal
d_fnc_map_group_count_marker = {
	scriptName "d_fnc_map_group_count_marker";
	_mname = "all_groups_yeah";
	_mtext = "Groups: %1, alive units: %2, inf without leader: %3";
	[_mname, [3000,1000,0],"ICON","ColorBlack",[2,2],format [_mtext, 0,0],0,"mil_dot"] call d_fnc_CreateMarkerLocal;
	while {true} do {
		d_all_marker_groups = d_all_marker_groups - [objNull, grpNull];
		_grpcounter = count d_all_marker_groups;
		_units = 0;
		_remgrps = [];
		{
			_alu = {alive _x} count (units _x);
			if (_alu > 0) then {
				_units = _units + _alu;
			} else {
				_remgrps pushBack _x;
			};
		} forEach d_all_marker_groups;
		if (count _remgrps > 0) then {
			d_all_marker_groups = d_all_marker_groups - _remgrps;
		};
		_mname setMarkerTextLocal format [_mtext, _grpcounter,_units, d_infunitswithoutleader];
		sleep 1;
	};
};

d_gcounter = -1;
d_infunitswithoutleader = 0;
d_fnc_groupmarker = {
	scriptName "d_fnc_groupmarker";
	params ["_grp"];
	waitUntil {sleep 0.221;(units _grp) findIf {alive _x} > -1};
	_helper = str _grp;
	private _gname = if (_helper != "") then {_helper} else {d_gcounter = d_gcounter + 1; str d_gcounter};
	private _mname = _gname + "dgrp";
	private _mnamel = _mname + "lm";
	_mnamewp = _mname + "wpm";
	_gname = _gname;
	sleep 1;
	d_all_marker_groups pushBack _grp;
	_vec = vehicle leader _grp;
	_mtype = if (_vec == leader _grp) then {
		switch (side _grp) do {case blufor: {"b_inf"};case opfor: {"o_inf"};default {"n_inf"};}
	} else {
		call {
			if (_vec isKindOf "Wheeled_APC" || {_vec isKindOf "Wheeled_APC_F"}) exitWith {switch (side _grp) do {case blufor: {"b_mech_inf"};case opfor: {"o_mech_inf"};default {"n_mech_inf"};}};
			if (_vec isKindOf "Car") exitWith {switch (side _grp) do {case blufor: {"b_motor_inf"};case opfor: {"o_motor_inf"};default {"n_motor_inf"};}};
			if (_vec isKindOf "Tank") exitWith {switch (side _grp) do {case blufor: {"b_armor"};case opfor: {"o_armor"};default {"n_armor"};}};
			if (_vec isKindOf "Helicopter") exitWith {switch (side _grp) do {case blufor: {"b_air"};case opfor: {"o_air"};default {"n_air"};}};
			if (_vec isKindOf "Plane") exitWith {switch (side _grp) do {case blufor: {"b_plane"};case opfor: {"o_plane"};default {"n_plane"};}};
			if (_vec isKindOf "StaticCannon") exitWith {switch (side _grp) do {case blufor: {"b_art"};case opfor: {"o_art"};default {"n_art"};}};
			if (_vec isKindOf "StaticMortar") exitWith {switch (side _grp) do {case blufor: {"b_mortar"};case opfor: {"o_mortar"};default {"n_mortar"};}};
			switch (side _grp) do {case blufor: {"b_support"};case opfor: {"o_support"};default {"n_support"};};
		}
	};
	[_mname, [0,0,0],"ICON",(switch (side _grp) do {case opfor: {"ColorEAST"};case blufor: {"ColorWEST"};case independent: {"ColorGUER"};default {"ColorCIV"};}),[0.8,0.8],_gname,0,_mtype] call d_fnc_CreateMarkerLocal;
	_gname = _gname + " (%1)";
	while {true} do {
		if (isNull _grp || {(units _grp) findIf {alive _x} == -1}) exitWith {
			deleteMarkerLocal _mname;
			deleteMarkerLocal _mnamel;
			deleteMarkerLocal _mnamewp;
		};
		private _leader = leader _grp;
		if (!isNull _leader) then {
			private _p1 = visiblePositionASL _leader;
			_mname setMarkerPosLocal _p1;
			_mname setMarkerTextLocal format [_gname, {alive _x} count (units _grp)];
			private _wps = wayPoints _grp;
			private _idx = currentWaypoint _grp;
			if (_idx > 0 && {_idx < count _wps}) then {
				private _curwppos = waypointPosition (_wps # _idx);
				if (markerType _mnamewp == "") then {
					[_mnamewp,_curwppos,"ICON","ColorGrey",[0.7, 0.7],"",0,"waypoint"] call d_fnc_CreateMarkerLocal;
				} else {
					_mnamewp setMarkerPosLocal _curwppos;
				};
				__TRACE_3("","_p1","_curwppos","_mnamel")
				[_p1, _curwppos, _mnamel] call d_fnc_linemaker2;
			} else {
				deleteMarkerLocal _mnamel;
				deleteMarkerLocal _mnamewp;
			};
		} else {
			deleteMarkerLocal _mnamel;
			deleteMarkerLocal _mnamewp;
		};
		sleep (0.6 + random 0.2);
	};
};
#endif
