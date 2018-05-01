// by Xeno
#define THIS_FILE "fn_allplayers.sqf"
#include "..\..\x_setup.sqf"

while {true} do {
	d_allplayers = (allPlayers - entities "HeadlessClient_F") select {!isNull _x && {d_player_side getFriend side (group _x) >= 0.6}};
	sleep 2;
};