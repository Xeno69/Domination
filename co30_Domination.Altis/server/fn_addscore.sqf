// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addscore.sqf"
#include "..\x_setup.sqf"

params ["_pl", "_reason", ["_extra", -1]];

// reason:
// 1 - barracks building destroyed at main target
// 2 - mobile HQ building destroyed at main target
// 3 - radio tower destroyed at main target
// 4 - player has taken camp
// 5 - player has resolved main target mission
// 6 - extra points seizing the main target
// 7 - points for reviving another player
// 8 - points for helping solving the sidemission
// 9 - points for repairing/refueling a vehicle
// 10 - points for healing another unit
// 11 - points for another player healing at a player mash
// 12 - points for another player spawning at squad leader
// 13 - points for transporting another player in a vehicle
// 14 - points for bringing a wreck to the wreck repair point

private _score = if (_extra == -1) then {
	d_addscore_a # (_reason - 1)
} else {
	(d_addscore_a # (_reason - 1)) # _extra
};

if (_reason == 8 && {d_without_sm_bonus == 0}) then {
	_score = _score * 2;
};

_pl addScore _score;
[_reason, _score] remoteExecCall ["d_fnc_scoreadded", _pl];