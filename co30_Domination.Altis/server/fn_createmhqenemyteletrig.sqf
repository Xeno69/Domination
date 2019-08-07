// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createmhqenemyteletrig.sqf"
#include "..\x_setup.sqf"

private _mhq = _this;

private _trig = _mhq getVariable "d_enemy_trigger";
if (!isNil "_trig" && {!isNull  _trig}) then {deleteVehicle _trig};

private _trigger = [
	_mhq,
	[d_NoMHQTeleEnemyNear, d_NoMHQTeleEnemyNear, 0, false, 10],
	[d_enemy_side, "PRESENT", true],
	["this",
		"if (alive (thisTrigger getVariable ['d_mhqo', objNull])) then {(thisTrigger getVariable 'd_mhqo') setVariable ['d_enemy_near', true, true]}",
		"if (alive (thisTrigger getVariable ['d_mhqo', objNull])) then {(thisTrigger getVariable 'd_mhqo') setVariable ['d_enemy_near', false, true]}"
	]
] call d_fnc_createtriggerlocal;
_trigger setVariable ["d_mhqo", _mhq];

_mhq setVariable ["d_enemy_trigger", _trigger];

_trigger attachTo [_mhq, [0,0,0]];
