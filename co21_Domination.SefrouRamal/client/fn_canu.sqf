// by Xeno
#include "..\x_setup.sqf"

d_player_canu = alive player && {!(player getVariable "xr_pluncon") && {!(player getVariable ["ace_isunconscious", false])}}
