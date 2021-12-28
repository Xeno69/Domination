// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

_this allowDamage false;
_this spawn {
	scriptname "spawn nodamoff";
	sleep 20;
	_this allowDamage true;
};