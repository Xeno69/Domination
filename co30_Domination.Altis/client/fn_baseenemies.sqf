// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_baseenemies.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (_this # 0 == 0) exitWith {
	hint composeText[
		parseText format ["<t color='#f0ff0000' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_676"], lineBreak,
		parseText format ["<t size='1'>%1</t>", localize "STR_DOM_MISSIONSTRING_677"]
	];
};
hint composeText[
	parseText format ["<t color='#f00000ff' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_678"], lineBreak,		
	parseText format ["<t size='1'>%1</t>", localize "STR_DOM_MISSIONSTRING_679"]
];
