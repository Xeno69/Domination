// by Xeno
//#define __DEBUG__
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