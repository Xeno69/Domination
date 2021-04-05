// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sgetoutvec.sqf"
#include "..\x_setup.sqf"

params ["_vec"];
#ifndef __TT__
if (alive _vec && {(crew _vec) findIf {alive _x} == -1 && {_vec distance2D d_FLAG_BASE > 800}}) then {
	private _mname = format ["%1_ab%2", _vec call d_fnc_markername, time];
#else
private _vside = _vec getVariable "D_VEC_SIDE";
if (alive _vec && {(crew _vec) findIf {alive _x} == -1 && {_vside == 2 && {_vec distance2D d_WFLAG_BASE > 800} || {_vside == 1 && {_vec distance2D d_EFLAG_BASE > 800}}}}) then {
	private _mbegin = ["d_abm_blu_%1_%2", "d_abm_opf_%1_%2"] select (_vside == 1);
	private _mname = format [_mbegin, _vec call d_fnc_markername, time];
#endif
	[_mname, _vec, "ICON", "ColorBlue", [1,1], format [localize "STR_DOM_MISSIONSTRING_1566", [_vec] call d_fnc_GetDisplayName], 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
	[_mname, "STR_DOM_MISSIONSTRING_1566", [_vec] call d_fnc_GetDisplayName] remoteExecCall ["d_fnc_setmatxtloc", [0, -2] select isDedicated];
	_vec setVariable ["d_abandoned_ma", _mname];
#ifdef __TT__
	if (_vside == 1) then {
		_mname remoteExecCall ["deleteMarkerLocal", blufor];
	} else {
		_mname remoteExecCall ["deleteMarkerLocal", opfor];
	};
#endif
};