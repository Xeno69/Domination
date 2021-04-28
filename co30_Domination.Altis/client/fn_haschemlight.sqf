// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _chemar = [];
{
	_chemar pushBackUnique _x;
} forEach ((magazines player) select {getText(configFile>>"CfgMagazines">>_x>>"nameSound") == "Chemlight"});

_chemar