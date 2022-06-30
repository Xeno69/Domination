// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

_this allowDamage false;
_this setDamage 0;
//_this setPosASL ((getPosWorld _this) vectorAdd [0, 0, 10]);
//sleep 10 + random 2;

private _pos = getPosATL _this;
private _start = +_pos;
_start set [2, 100];
while {lineIntersects [ATLToASL _start, ATLToASL _pos]} do {
	_pos set [2, (_pos select 2) + 0.25];
	sleep 0.01;
};
_this setPosATL _pos;

_this allowDamage true;
_this setDamage 0;
