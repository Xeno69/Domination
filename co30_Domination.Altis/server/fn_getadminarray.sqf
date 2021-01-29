// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getadminarray.sqf"
#include "..\x_setup.sqf"

if (remoteExecutedOwner isEqualTo 0) exitWith {};
(d_player_hash getOrDefault [_this, []]) remoteExecCall ["d_fnc_seturinf", remoteExecutedOwner];
