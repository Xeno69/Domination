// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addmarker.sqf"
#include "..\x_macros.sqf"

if (!isServer) exitWith {};

__TRACE_1("","_this")
params ["_unit"];
if (!alive _unit) exitWith {};
private _mname = format ["xr_dead_%1", getPlayerUID _unit];
__TRACE_1("","_mname")
if (markerPos _mname isEqualTo [0,0,0]) then {
	[_mname, _this # 1, "ICON", "ColorBlue", [0.4,0.4], format [localize "STR_DOM_MISSIONSTRING_910", _unit call d_fnc_getplayername], 0, "KIA"] call d_fnc_CreateMarkerGlobal;
	if (d_tt_ver) then {
		_unit setVariable ["xr_dml_jip_id", _mname remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (side (group _unit) == blufor)], true];
	};
};
