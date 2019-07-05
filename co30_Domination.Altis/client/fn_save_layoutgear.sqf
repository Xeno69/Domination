// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_save_layoutgear.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _ar =+ getUnitLoadout player;
player setVariable ["d_layoutgear", _ar];