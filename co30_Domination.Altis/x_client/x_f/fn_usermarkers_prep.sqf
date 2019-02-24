// by Xeno
#define THIS_FILE "fn_usermarkers_prep.sqf"
#include "..\..\x_setup.sqf"

d_usermarkers_prep = [];
private _pos_cam = positionCameraToWorld [0,0,0];
private ["_distp", "_pos", "_col", "_m"];
private _toshow = d_allnearusermarkers # currentChannel;
{
	if (getMarkerColor _x == "") exitWith {};
	_pos = markerPos _x;
	_pos set [2, 6];
	_distp = _pos_cam distance _pos;
	_m = 1 - (_distp / 1000);
	_col = getArray (configfile>>"CfgMarkerColors">>(getMarkerColor _x)>>"color");
	if (_col isEqualTo []) then {_col = [1, 1, 1, 1]};
	_col set [3, _m];
	d_usermarkers_prep pushBack [getText (configfile>>"CfgMarkers">>(markerType _x)>>"icon"), _col, _pos, _m, _m, 0, markerText _x, 1, 0.033 - (_distp / 15000), "RobotoCondensed"];
} forEach _toshow;
