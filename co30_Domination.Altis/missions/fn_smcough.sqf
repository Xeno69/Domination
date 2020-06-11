// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_smcough.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _sounds = [
    "A3\Sounds_f\characters\human-sfx\Person0\P0_choke_02.wss",
    "A3\Sounds_f\characters\human-sfx\Person0\P0_choke_03.wss",
    "A3\Sounds_f\characters\human-sfx\Person0\P0_choke_04.wss",
    "A3\Sounds_f\characters\human-sfx\Person1\P1_choke_04.wss",
    "A3\Sounds_f\characters\human-sfx\Person2\P2_choke_04.wss",
    "A3\Sounds_f\characters\human-sfx\Person2\P2_choke_05.wss",
    "A3\Sounds_f\characters\human-sfx\Person3\P3_choke_02.wss",
    "A3\Sounds_f\characters\human-sfx\P06\Soundbreathinjured_Max_2.wss",
    "A3\Sounds_f\characters\human-sfx\P05\Soundbreathinjured_Max_5.wss"
];

private _nextcrytime = -1;

while {!isNil "d_sm_curptrigger"} do {
	if (time >= _nextcrytime) then {
		playSound3D [selectRandom _sounds, player, false, getPosASL player, 2, 1, 100];
		_nextcrytime = time + 2 + (random 2);
		player setDamage ((getDammage player) + 0.05);
	};
	sleep 1;
};