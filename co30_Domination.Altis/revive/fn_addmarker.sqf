// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addmarker.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

__TRACE_1("","_this")
params ["_unit"];
if (!alive _unit) exitWith {};
#ifndef __TT__
private _mname = format ["xr_dead_%1", getPlayerID _unit];
#else
private _mbegin = ["xr_opf_dead_%1", "xr_blu_dead_%1"] select (side (group _unit) == blufor);
private _mname = format [_mbegin, getPlayerID _unit];
#endif
__TRACE_1("","_mname")
if (markerPos _mname isEqualTo [0,0,0]) then {
	[_mname, _this # 1, "ICON", "ColorBlue", [0.4,0.4], format [localize "STR_DOM_MISSIONSTRING_910", name _unit], 0, "KIA"] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
	_mname remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (side (group _unit) == blufor)];
#endif
};
