// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (admin remoteExecutedOwner != 2) exitWith {};

params ["_netid", "_score"];

private _receiver = objectFromNetId _netid;

if (isNil "_receiver" || {isNull _receiver}) exitWith {};

_receiver addScore _score;

[25, _score] remoteExecCall ["d_fnc_csidechat", _receiver];
