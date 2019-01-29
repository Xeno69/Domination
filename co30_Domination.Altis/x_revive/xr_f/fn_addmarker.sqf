// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addmarker.sqf"
#include "..\..\x_macros.sqf"

if (!isServer) exitWith {};

params ["_unit"];
if (!alive _unit) exitWith {};
private _mname = format ["%1_xr_dead", _unit];
if (markerPos _mname isEqualTo [0,0,0]) then {
	[_mname, _this select 1, "ICON", "ColorBlue", [0.4,0.4], format [localize "STR_DOM_MISSIONSTRING_910", _unit call d_fnc_getplayername], 0, "KIA"] call d_fnc_CreateMarkerGlobal;
	if (d_tt_ver) then {
		_unit setVariable ["xr_dml_jip_id", _mname remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (side (group _unit) == blufor)], true];
	};
};
