// by Xeno
#define THIS_FILE "fn_csidechat.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_num", "_param1", "_param2", "_param3"];

if (_num == 0) exitWith {
#ifndef __TT__
	d_kb_logic1 sideChat format [localize "STR_DOM_MISSIONSTRING_1372", _param1];
#else	
	if (d_player_side == blufor) then {
		d_hq_logic_blufor1 sideChat format [localize "STR_DOM_MISSIONSTRING_1372", _param1];
	} else {
		d_hq_logic_opfor1 sideChat format [localize "STR_DOM_MISSIONSTRING_1372", _param1];
	};
#endif
};

if (_num == 1) exitWith {
#ifndef __TT__
	d_kb_logic1 sideChat format [localize "STR_DOM_MISSIONSTRING_1373", _param1];
#else
	if (d_player_side == blufor) then {
		d_hq_logic_blufor1 sideChat format [localize "STR_DOM_MISSIONSTRING_1373", _param1];
	} else {
		d_hq_logic_opfor1 sideChat format [localize "STR_DOM_MISSIONSTRING_1373", _param1];
	};
#endif
};

if (_num == 2) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_520", d_MHQDisableNearMT, _param1], "HQ"] call d_fnc_HintChatMsg;
};

if (_num == 3) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_1871", _param1, _param2], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 4) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_641", _param1, _param2, _param3], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 5) exitWith {
	player sideChat format [localize "STR_DOM_MISSIONSTRING_1856", d_ranked_a # 23];
};

if (_num == 6) exitWith {
	player sideChat (localize "STR_DOM_MISSIONSTRING_1519");
};

if (_num == 7) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_1752", _param1], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 8) exitWith {
	player createDiaryRecord ["dDBLoad", [localize "STR_DOM_MISSIONSTRING_1750", "<font face='RobotoCondensed' size=24 color='#ffffff'>" + format [localize "STR_DOM_MISSIONSTRING_1753", _param1] + "</font>"]];
};

if (_num == 9) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_1879", _param1, _param2], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 10) exitWith {
	[format [[localize "STR_DOM_MISSIONSTRING_509", localize "STR_DOM_MISSIONSTRING_508"] select (_param1 == 0), _param2], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 11) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_506", _param1, _param2], "GLOBAL"] call d_fnc_HintChatMsg;
};

#ifdef __TT__
if (_num == 12) exitWith {
	private _lstr = ["STR_DOM_MISSIONSTRING_515", "STR_DOM_MISSIONSTRING_514"] select (d_WithRevive == 0);
	player sideChat format [localize _lstr, _param1, _param2, "EAST", d_tt_points # 8];
};

if (_num == 13) exitWith {
	private _hmsg = if (d_sub_tk_points != 0) then {
		[format [localize "STR_DOM_MISSIONSTRING_502", _param1, _param2, d_sub_tk_points], "GLOBAL"]
	} else {
		[format [localize "STR_DOM_MISSIONSTRING_503", _param1, _param2], "GLOBAL"]
	};
	
	_hmsg call d_fnc_HintChatMsg;
};

if (_num == 14) exitWith {
	private _lstr = ["STR_DOM_MISSIONSTRING_515", "STR_DOM_MISSIONSTRING_514"] select (d_WithRevive == 0);
	player sideChat format [localize _lstr, _param1, _param2, "WEST", d_tt_points # 8];
};
#endif

if (_num == 15) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_1462", _param1], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 16) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_1834", _param1], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 17) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_1749", _param1], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 18) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_1957", _param1], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 19) exitWith {
	[localize "STR_DOM_MISSIONSTRING_1958", "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 20) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_507a", _param1, _param2], "GLOBAL"] call d_fnc_HintChatMsg;
	if (_param3 == player) then {
		[_param2, 0] spawn d_fnc_jail;
	};
};

#ifdef __TT__
if (_num == 21) exitWith {
	if (_param2 == 1) then {
		systemChat format [localize "STR_DOM_MISSIONSTRING_516", _param1, "WEST", "EAST", d_tt_points # 7];
	} else {
		if (_param2 == 2) then {
			systemChat format [localize "STR_DOM_MISSIONSTRING_516", _param1, "EAST", "WEST", d_tt_points # 7];
		};
	};
};
#endif

if (_num == 22) exitWith {
	[format [localize "STR_DOM_MISSIONSTRING_506", _param1, _param2], "GLOBAL"] call d_fnc_HintChatMsg;
};

if (_num == 23) exitWith {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_288", _param1];
};

if (_num == 24) exitWith {
	hint "All rappel anchors in use. Please try again.";
};
