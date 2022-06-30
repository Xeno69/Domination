// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

_this allowDamage false;
_this setDamage 0;
_this setPosASL ((getPosWorld _this) vectorAdd [0, 0, 10]);
sleep 10 + random 2;
_this allowDamage true;
_this setDamage 0;
