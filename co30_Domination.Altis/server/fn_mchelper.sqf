// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mchelper.sqf"
#include "..\x_setup.sqf"

_this allowDamage false;
_this setDamage 0;
private _pos = getPos _this;
_this setPos [_pos # 0, _pos # 1, 10];
sleep 10 + random 2;
_this allowDamage true;
_this setDamage 0;
