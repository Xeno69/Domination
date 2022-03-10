// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_receiver"];

private _curreceiver = _receiver;

private _isplayer =  if (isNull _receiver) then {
	_receiver = [0, -2] select isDedicated;
	false
} else {
	true
};

private _doexit = false;
{
	[_forEachIndex, _x, _curreceiver] remoteExecCall ["d_fnc_receivetop", _receiver];
	sleep 0.1;
	if (_isplayer && {isNull _receiver}) exitWith {
		_doexit = true;
	};
} forEach d_top10_db_players_serv;

if (_doexit) exitWith {};

[-99] remoteExecCall ["d_fnc_receivetop", _receiver];
