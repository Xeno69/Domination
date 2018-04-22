// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mchelper.sqf"
#include "..\..\x_setup.sqf"

_this allowDamage false;
private _pos = getPos _this;
_this setPos [_pos # 0, _pos # 1, 10];
sleep 8 + random 2;
_this allowDamage true;