// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_plcheckkill.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_killed", "_killer", "_insti"];
if (isNull _insti) then {_insti = UAVControl vehicle _killer # 0}; // UAV/UGV player operated road kill
if (isNull _insti) then {_insti = _killer}; // player driven vehicle road kill

if (isNull _insti) exitWith {};

if ((d_with_ranked || {d_database_found}) && {d_sub_kill_points != 0 && {side (group _insti) getFriend side (group _killed) < 0.6}}) then {
	_killed addScore d_sub_kill_points;
};

private _isp = _insti call d_fnc_isplayer;

if (d_with_ai) then {	
	if (!_isp && {side (group _insti) getFriend side (group _killed) >= 0.6 && {vehicle _killed != vehicle _insti}}) then {
		_leader_killer = leader _insti;
		if (_leader_killer call d_fnc_isplayer) then {
			[name _leader_killer, name _killed, _insti] call d_fnc_TKKickCheck;
		};
	};
};

if (_isp && {vehicle _insti != vehicle _killed}) then {
	if (d_tk_forgive == 0 && {d_WithRevive == 0}) then {
		_insti remoteExecCall ["d_fnc_forgive", _killed];
	} else {
		[name _insti, name _killed, _insti] call d_fnc_TKKickCheck;
		[name _killed, name _insti] remoteExecCall ["d_fnc_unit_tk", [0, -2] select isDedicated];
	};
};
