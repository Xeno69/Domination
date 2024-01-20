//#define __DEBUG__
#include "..\x_setup.sqf"

private _cKiller = _this # 1;
private _cInstigator = _this # 2;
private "_punishMe";

if (isPlayer [_cKiller]) then {
	_punishMe = _cKiller;
} else {
	private _cKillerName = str _cKiller;	
	if (_cKillerName find "artyvec" != -1) then {
		//civ was killed by artillery, find who fired
		if (!isNil "_cInstigator" && {!isNull _cInstigator && {isPlayer [_cInstigator]}}) then {
			_punishMe = _cInstigator;
		};
	};
};

if (isNil "_punishMe") exitWith {};

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, format ["Player (_punishMe) %1 killed a civilian.", _punishMe]];
#endif

if (d_force_isstreamfriendlyui == 1) then {
	private _civkilledkb = selectRandom[
		"PenaltyKilledCivilianNoTextCeaseFire",
		"PenaltyKilledCivilianNoTextCheckYourFire",
		"PenaltyKilledCivilianNoTextHoldFire"];
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	_civkilledkb,
    	d_kbtel_chan
    ];
} else {
	d_kb_logic1 kbTell [
    	d_kb_logic2,
    	d_kb_topic_side,
    	"PenaltyKilledCivilian",
    	["1", "", name _punishMe, []],
    	["2", "", str d_civ_pnts, []],
    	d_kbtel_chan
    ];
};

//subtract penalty for killing a civilian
_punishMe addScore (d_civ_pnts * -1);
