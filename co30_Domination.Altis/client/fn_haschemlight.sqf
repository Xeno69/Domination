// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_haschemlight.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _chemar = [];
{
	_chemar pushBackUnique _x;
} forEach ((magazines player) select {getText(configFile>>"CfgMagazines">>_x>>"nameSound") == "Chemlight"});

_chemar