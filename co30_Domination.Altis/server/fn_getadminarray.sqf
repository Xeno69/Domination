// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getadminarray.sqf"
#include "..\x_setup.sqf"

(d_player_hash getOrDefault [_this # 1, []]) remoteExecCall ["d_fnc_seturinf", _this # 0];
