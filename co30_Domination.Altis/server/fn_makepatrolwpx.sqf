// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_makepatrolwpx.sqf"
#include "..\x_setup.sqf"

// supports also patrols in square areas, including angle
params ["_grp", "_start_pos", "_wp_array", ["_timeout", []], ["_wpstatements", ""], ["_mindist", 1], ["_full", false], ["_water", 0]];

__TRACE_1("","_this")

if (_start_pos isEqualType objNull) then {_start_pos = getPosATL _start_pos};

if (!(_start_pos isEqualType []) || {_start_pos isEqualTo [] || {isNull _grp}}) exitWith {
	diag_log ["makepatrolwpx, _start_pos is no array or empty or group is null", _this];
};

if (_wp_array isEqualType objNull) then {_wp_array = getPosATL _wp_array};

if !(_wp_array isEqualType []) exitWith {
	diag_log ["makepatrolwpx, _wp_array is no array", _this];
};

if (count _wp_array == 4 && {(_wp_array select 0) isEqualTo []}) exitWith {
	diag_log ["makepatrolwpx, _wp_array 0 is an empty array", _this];
};

if (!_full) then {
	_grp setBehaviour "SAFE";
} else {
	_grp setBehaviour "AWARE";
	_grp setSpeedMode "FULL";
};

private _cur_pos = _start_pos;
private _no_pos_found = false;

for "_i" from 0 to (2 + (floor (random 3))) do {
	private _wp_pos = call {
		if (count _wp_array == 2) exitWith {
			[_wp_array # 0, _wp_array # 1, _mindist, 0.7, _water, false, false] call d_fnc_GetRanPointCircle
		};
		if (count _wp_array == 4) exitWith {
			_wp_array call d_fnc_GetRanPointSquare
		};
		[]
	};
	__TRACE_1("1","_wp_pos")
	if (_wp_pos isEqualTo []) exitWith {_no_pos_found = true};
	
	private _counter = 0;
	while {_wp_pos distance2D _cur_pos < ((_wp_array # 1)/6) && {_counter < 100}} do {
		_wp_pos = call {
			if (count _wp_array == 2) exitWith {
				[_wp_array # 0, _wp_array # 1, _mindist, 0.7, _water, false, false] call d_fnc_GetRanPointCircle
			};
			if (count _wp_array == 4) exitWith {
				_wp_array call d_fnc_GetRanPointSquare
			};
			[]
		};
		if (_wp_pos isEqualTo []) exitWith {};
		_counter = _counter + 1;
	};
	__TRACE_1("2","_wp_pos")
	if (_wp_pos isEqualTo []) exitWith {_no_pos_found = true};
	
	_wp_pos = _wp_pos call d_fnc_WorldBoundsCheck;
	
	_cur_pos = _wp_pos;
	private _wp = _grp addWaypoint [_wp_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius (0 + random 10);
	
	if (_timeout isNotEqualTo []) then {
		_wp setWaypointTimeout _timeout;
	};
	
	if (!_full) then {
		if (_i == 0) then {
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointFormation "STAG COLUMN";
		};
	} else {
		if (_i > 0) then {
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointFormation "STAG COLUMN";
			_wp setWaypointBehaviour "SAFE";
		} else {
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointFormation "STAG COLUMN";
		};
	};
	if (_wpstatements != "") then {
		_wp setWaypointStatements ["TRUE", _wpstatements];
	};
};
private _wp1 = _grp addWaypoint [_start_pos, 0];

if (_no_pos_found) exitWith {
	diag_log ["makepatrolwpx, no pos found", _this];
	_wp1 setWaypointType "SAD";
};

_wp1 setWaypointType "MOVE";
_wp1 setWaypointCompletionRadius (10 + random 10);

if (_timeout isNotEqualTo []) then {
	_wp1 setWaypointTimeout _timeout;
};
if (_wpstatements != "") then {
	_wp1 setWaypointStatements ["TRUE", _wpstatements];
};

private _wp = _grp addWaypoint [_start_pos, 0];
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius (10 + random 10);
