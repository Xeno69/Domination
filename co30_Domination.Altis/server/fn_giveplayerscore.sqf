// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_origpl", "_netid", "_transscore"];

private _receiver = objectFromNetId _netid;

if (isNil "_receiver" || {isNull _receiver}) exitWith {};

_origpl addScore (-_transscore);
_receiver addScore _transscore;

[9, _transscore, name _origpl] remoteExecCall ["d_fnc_csidechat", _receiver];