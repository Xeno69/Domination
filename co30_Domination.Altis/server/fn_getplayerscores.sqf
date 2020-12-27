// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getplayerscores.sqf"
#include "..\x_setup.sqf"

while {true} do {
	{
		if (!isNull _x) then {
			private _ps = getPlayerScores _x;
			if (_ps isNotEqualTo []) then {
				private _p = d_player_hash getOrDefault [getPlayerUID _x, []];
				if (_p isNotEqualTo []) then {
					_p set [12, _ps];
				};
			};
		};
		sleep 1;
	} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x});
	sleep 2;
};