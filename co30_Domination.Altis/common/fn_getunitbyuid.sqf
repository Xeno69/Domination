// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getunitbyuid.sqf"
#include "..\x_setup.sqf"

params ["_uid"];

private _u = objNull;
allPlayers findIf {
	if (getPlayerUID _x == _uid) then {
		_u = _x;
		true
	} else {
		false
	};
};
_u