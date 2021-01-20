// by Xeno
#define THIS_FILE "fn_canu.sqf"
#include "..\x_setup.sqf"

d_player_canu = alive player && {!(player getVariable "xr_pluncon") && {!(player getVariable ["ace_isunconscious", false])}}
