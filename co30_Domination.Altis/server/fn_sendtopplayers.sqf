// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_top10_db_players_serv isEqualTo []) exitWith {};

params ["_receiver"];

__TRACE_1("","_receiver")

private _curreceiver = _receiver;

private _isplayer =  if (isNull _receiver) then {
	_receiver = [0, -2] select isDedicated;
	false
} else {
	true
};

__TRACE_1("","_isplayer")

private _doexit = false;
{
	[_forEachIndex, _x, _curreceiver] remoteExecCall ["d_fnc_receivetop", _receiver];
	__TRACE_2("","_forEachIndex","_x")
	sleep 0.1;
	if (_isplayer && {isNull _receiver}) exitWith {
		_doexit = true;
		__TRACE("_doexit true")
	};
} forEach d_top10_db_players_serv;

if (_doexit) exitWith {};

__TRACE("Sending -99")
[-99] remoteExecCall ["d_fnc_receivetop", _receiver];
