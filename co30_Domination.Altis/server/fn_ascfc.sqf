// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ascfc.sqf"
#include "..\x_setup.sqf"

d_sc_hash = createHashMapFromArray [
	[0, (d_ranked_a # 3) * -1],
	[1, (d_ranked_a # 2) * -1],
	[2, (d_ranked_a # 15) * -1],
	[3, (d_ranked_a # 5) * -1],
	[4, (d_ranked_a # 16) * -1],
	[5, d_ranked_a # 17],
	[6, (d_ranked_a # 19) * -1],
	[7, d_ranked_a # 17],
	[8, (d_ranked_a # 4) * -1],
	[9, (d_ranked_a # 19) * -1],
	[10, (d_ranked_a # 20) * -1]
];

(_this # 0) addScore (d_sc_hash get (_this # 1));