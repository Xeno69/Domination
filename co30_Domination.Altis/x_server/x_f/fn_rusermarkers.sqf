// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rusermarkers.sqf"
#include "..\..\x_setup.sqf"

private _del_markers = [];
{
	private _split_ar = _x splitString "#/";
	if (_split_ar # 1 != "") then {
		private _unit = objectFromNetId (_split_ar # 1);
		if (isNil "_unit" || {isNull _unit}) then {
			_del_markers pushBack _x;
		};
	};
} forEach (allMapMarkers select {_x select [0, 15] == "_USER_DEFINED #"});

if !(_del_markers isEqualTo []) then {
	{deleteMarker _x} forEach _del_markers;
};