// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _chemar = [];
{
	_chemar pushBackUnique (_x # 0);
} forEach ((throwables player) select {getText(configFile>>"CfgMagazines">>(_x # 0)>>"nameSound") == "Chemlight"});

_chemar