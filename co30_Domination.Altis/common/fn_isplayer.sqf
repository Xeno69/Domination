// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_isplayer.sqf"
#include "..\x_setup.sqf"

(isPlayer _this || {_this in allPlayers})