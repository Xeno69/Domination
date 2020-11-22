// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_umadel.sqf"
#include "..\x_setup.sqf"

params ["_opos", "_radpatr"];
_opos =+ _opos;

sleep 5;

private _musers = [];
private _mmarkers = [];
{
	__TRACE_1("","_x")
	if (_opos distance2D (markerPos _x) < _radpatr) then {
		deleteMarker _x;
	} else {
		private _chars = [];
		private _count = 15;
		private _c = "";
		while {true} do {
			_c = _x select [_count, 1];
			if (_c == "/") exitWith {};
			_chars pushBack _c;
			_count = _count + 1;
		};
		private _user = _chars joinString "";
		private _idx = _musers findIf {
			_x == _user
		};
		if (_idx != -1) then {
			private _ar = _mmarkers # _idx;
			_ar pushBack _x;
		} else {
			_musers pushBack _user;
			_mmarkers pushBack [_x];
		};
	};
	sleep 0.01;
} forEach (allMapMarkers select {_x select [0, 15] == "_USER_DEFINED #"});
__TRACE_1("","_musers")
__TRACE_1("","_mmarkers")
if (_musers isNotEqualTo []) then {
	{
		if (count _x > 6) then {
			{
				deleteMarker _x;
			} forEach _x;
		};
	} forEach _mmarkers;
};
