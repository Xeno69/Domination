// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_pos", "_caller"];

if (isNull _caller) exitWith {};

private _grp = group _caller;

private _marker = _grp getVariable "d_rally_point";
if (!isNil "_marker") then {
	deleteMarker _marker;
};

_marker = createMarker ["d_grp_" + str _grp, _pos, 3, _caller];
_grp setVariable ["d_rally_point", _marker];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_end_noShadow";
_marker setMarkerText "Rallypoint";
_marker setMarkerColor "ColorBlack";
