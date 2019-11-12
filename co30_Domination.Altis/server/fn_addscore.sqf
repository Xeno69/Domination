// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addscore.sqf"
#include "..\x_setup.sqf"

params ["_pl", "_score", "_reason"];

// reason:
// 1 - barracks building destroyed at main target
// 2 - mobile HQ building destroyed at main target
// 3 - radio tower destroyed at main target
// 4 - player has taken camp
// 5 - player has resolved main target mission

_pl addScore _score;
[_reason, _score] remoteExec ["d_fnc_scoreadded", _pl];