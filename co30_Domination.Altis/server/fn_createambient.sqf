// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_noambient_bf_sounds) exitWith {};

private _sounds = [
	"BattlefieldExplosions1_3D",
	"BattlefieldExplosions2_3D",
	"BattlefieldExplosions3_3D",
	"BattlefieldExplosions4_3D",
	"BattlefieldExplosions5_3D",
	"BattlefieldFirefight1_3D",
	"BattlefieldFirefight2_3D",
	"BattlefieldFirefight3_3D",
	"BattlefieldFirefight4_3D"
];

__TRACE("Running")

while {!d_mt_done} do {
	private _next = time + 5 + (selectRandom [10, 20, 30]) + random 20;
	while {true} do {
		sleep 1;
		if (time > _next || {d_mt_done}) exitWith {};
	};
	
	if (d_mt_done) exitWith {};
	(selectRandom _sounds) remoteExecCall ["d_fnc_playsound", [0, -2] select isDedicated];
};