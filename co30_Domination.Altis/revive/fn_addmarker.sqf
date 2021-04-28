// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

__TRACE_1("","_this")
params ["_unit", "_pos", "_mname"];

if (!alive _unit) exitWith {};

if (markerPos _mname isNotEqualTo [0,0,0]) then {
	deleteMarker _mname;
};
[_mname, _pos, "ICON", "ColorBlue", [0.4,0.4], format [localize "STR_DOM_MISSIONSTRING_910", name _unit], 0, "KIA"] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
_mname remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (side (group _unit) == blufor)];
[_mname, name _unit] remoteExecCall ["xr_fnc_setmatxtloc", [blufor, opfor] select (side (group _unit) == opfor)];
#else
[_mname, name _unit] remoteExecCall ["xr_fnc_setmatxtloc", [0, -2] select isDedicated];
#endif
