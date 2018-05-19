// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_baseenemies.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

switch (_this select 0) do {
	case 0: {
		hint composeText[
			parseText format ["<t color='#f0ff0000' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_676"], lineBreak,
			parseText format ["<t size='1'>%1</t>", localize "STR_DOM_MISSIONSTRING_677"]
		];
	};
	case 1: {
		hint composeText[
			parseText format ["<t color='#f00000ff' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_678"], lineBreak,		
			parseText format ["<t size='1'>%1</t>", localize "STR_DOM_MISSIONSTRING_679"]
		];
	};
};