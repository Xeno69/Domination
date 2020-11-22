// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getplayerscores.sqf"
#include "..\x_setup.sqf"

while {true} do {
	{
		if (!isNull _x) then {
			private _ps = getPlayerScores _x;
			if (_ps isNotEqualTo []) then {
				private _p = d_player_store getVariable (getPlayerUID _x);
				if (!isNil "_p") then {
					_p set [12, _ps];
				};
			};
		};
		sleep 1;
	} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x});
	sleep 2;
};