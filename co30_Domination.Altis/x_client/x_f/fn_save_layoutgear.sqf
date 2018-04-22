// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_save_layoutgear.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

player setVariable ["d_layoutgear", getUnitLoadout player];