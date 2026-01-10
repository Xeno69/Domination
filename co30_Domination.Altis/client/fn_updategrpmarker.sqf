// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("in updategrpmarker")

if (!hasInterface) exitWith {};

__TRACE("in updategrpmarker has interface")

private _mar = (group player) getVariable "d_rally_point";
private _pos = (group player) getVariable "d_rally_point_pos";
__TRACE_2("","_mar","_pos")
if (!isNil "_mar" && {!isNil "_pos" && {markerPos _mar isEqualTo [0,0,0]}}) then {
	_marker = createMarkerLocal [_mar, _pos];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "hd_end_noShadow";
	_marker setMarkerTextLocal (localize "STR_DOM_MISSIONSTRING_2117");
	_marker setMarkerColorLocal "ColorBlack";
};
