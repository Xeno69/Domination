// by Xeno
#define THIS_FILE "fn_changeleader.sqf"
#include "..\..\x_macros.sqf"

player setVariable ["xr_isleader", player == leader (group player)];
