// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")
params ["_plnid", "_apos", "_npl", "_aritype", "_ari_salv"];

private _mname = format ["d_arttmx|%1|%2|%3", ["1", _plnid] select (isMultiplayer), _aritype, _ari_salv];
__TRACE_1("","_mname")
private _pl = objectFromNetId _plnid;
private _pa = d_player_hash getOrDefault [getPlayerUID _pl, []];
if (_pa isNotEqualTo []) then {
	private _omar = _pa # 10;
	__TRACE_1("","_omar")
	if (_omar isNotEqualTo "" && {markerPos _omar isNotEqualTo [0,0,0]}) then {
		deleteMarker _omar;
	};
	_pa set [10, _mname];
};
[_mname, _apos, "ICON", d_color_m_marker, [1, 1], _npl, 0, d_arty_m_marker] call d_fnc_CreateMarkerGlobal;
#ifdef __TT__
_mname remoteExecCall ["deleteMarkerLocal", [blufor, opfor] select (side (group _pl) == blufor)];
#endif

if (d_no_ai) then {
#ifdef __TT__
	private _artopside = side (group _pl);
	__TRACE_1("","_artopside")
#endif
	{
		private _aunit = missionNamespace getVariable _x;
		__TRACE_1("","_aunit")
		if (!isNil "_aunit" && {!isNull _aunit && {_aunit != _pl}}) then {
#ifdef __TT__
		if (side (group _aunit) == _artopside) then {
#endif
			_npl remoteExecCall ["d_fnc_upd_aop", _aunit];
#ifdef __TT__
		};
#endif
		};
	} forEach d_can_use_artillery;
};