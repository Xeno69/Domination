// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

"GrenadeHand" createVehicle (getPos _this);
sleep 4.8;
if (isNull _this) exitWith {};
_s = random 9;
_d = random 359;
_this setVelocity [_s * sin _d, _s * cos _d, 20 + (random 20)];
