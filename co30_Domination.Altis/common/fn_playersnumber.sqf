// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (time > d_nump_h_ar # 1) then {
	d_nump_h_ar set [1, time + 20];
	d_nump_h_ar set [0, count ((allPlayers - (entities "HeadlessClient_F")) select {!(_x isKindOf "VirtualMan_F")})];
};
//count ((allPlayers - (entities "HeadlessClient_F")) select {!(_x isKindOf "VirtualMan_F")})
d_nump_h_ar # 0
