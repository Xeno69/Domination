// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createmhqenemyteletrig.sqf"
#include "..\x_setup.sqf"

private _mhq = _this;

private _trig = _mhq getVariable "d_enemy_trigger";
if (!isNil "_trig" && {!isNull  _trig}) then {deleteVehicle _trig};

private _trigger = [
	_mhq,
	[d_NoMHQTeleEnemyNear, d_NoMHQTeleEnemyNear, 0, false],
	[d_enemy_side, "PRESENT", true],
	["this",
		format ["%1 setVariable ['d_enemy_near', true, true]", _mhq],
		format ["%1 setVariable ['d_enemy_near', false, true]", _mhq]
	]
] call d_fnc_createtriggerlocal;

_mhq setVariable ["d_enemy_trigger", _trigger];

_trigger attachTo [_mhq, [0,0,0]];