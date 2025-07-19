// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_pos", "_caller", ["_mode", 0]];

if (isNull _caller) exitWith {};

private _grp = group _caller;
private _marker = _grp getVariable "d_rally_point";

if (_mode == 0) then {
	if (!isNil "_marker") then {
		deleteMarker _marker;
	};

	_marker = createMarker ["d_grp_" + str _grp, _pos, 3, _caller];
	_grp setVariable ["d_rally_point", _marker, true];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "hd_end_noShadow";
	_marker setMarkerText (localize "STR_DOM_MISSIONSTRING_2117");
	_marker setMarkerColor "ColorBlack";
} else {
	if (!isNil "_marker") then {
		deleteMarker _marker;
	};
};