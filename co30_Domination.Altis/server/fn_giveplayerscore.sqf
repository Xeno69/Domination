// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_giveplayerscore.sqf"
#include "..\x_setup.sqf"

params ["_origpl", "_netid", "_transscore"];

private _receiver = objectFromNetId _netid;

if (isNil "_receiver" || {isNull _receiver}) exitWith {};

_origpl addScore (-_transscore);
_receiver addScore _transscore;

[format [localize "STR_DOM_MISSIONSTRING_1879", _transscore, _origpl call d_fnc_getplayername], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", _receiver];
