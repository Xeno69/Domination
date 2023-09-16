// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

count ((allPlayers - (entities "HeadlessClient_F")) select {!(_x isKindOf "VirtualMan_F")})