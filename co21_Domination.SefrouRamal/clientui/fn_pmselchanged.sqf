// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

private _selIdx = (_this # 0) # 1;
if (_selIdx == -1) exitWith {};

if (d_show_player_marker != _selIdx) then {
	d_show_player_marker = _selIdx;
	if (d_show_player_marker > 0) then {
		switch (d_show_player_marker) do {
			case 1: {systemChat (localize "STR_DOM_MISSIONSTRING_205")};
			case 2: {systemChat (localize "STR_DOM_MISSIONSTRING_206")};
			case 3: {systemChat (localize "STR_DOM_MISSIONSTRING_208")};
		};
	} else {
		systemChat (localize "STR_DOM_MISSIONSTRING_210");
	};
};