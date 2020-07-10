//#define __DEBUG__
#define THIS_FILE "fn_civmodulekilleh.sqf"
#include "..\x_setup.sqf"

private _cKiller = _this select 1;
private "_punishMe";

if (_cKiller call d_fnc_isplayer) then {
	_punishMe = _cKiller;
} else {
	private _cKillerName = str _cKiller;					
	if (_cKillerName find "artyvec" != -1) then {
		//civ was killed by artillery, find who fired		
		private _whof = _cKiller getVariable "d_who_fired";
		if (!isNil "_whof" && {!isNull _whof}) then {
			private _guiltyArtyUser = objectFromNetId _whof;
#ifdef __DEBUG__
			diag_log [diag_frameno, diag_ticktime, time, format ["_guiltyUser is: %1", _guiltyArtyUser call d_fnc_getplayername]];
			diag_log [diag_frameno, diag_ticktime, time, format ["_whof is: %1", _whof]];
#endif
			_punishMe = _guiltyArtyUser;
		};
	};
};

if (isNil "_punishMe") exitWith {};

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, format ["Player (_punishMe) %1 killed a civilian.", _punishMe]];
#endif

d_kb_logic1 kbTell [
	d_kb_logic2,
	d_kb_topic_side,
	"PenaltyKilledCivilian",
	["1", "", _punishMe call d_fnc_getplayername, []],
	["2", "", str d_civ_pnts, []],
	d_kbtel_chan
];

//subtract penalty for killing a civilian
_punishMe addScore (d_civ_pnts * -1);
