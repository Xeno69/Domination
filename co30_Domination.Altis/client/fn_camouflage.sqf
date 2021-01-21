// by Xeno
#define THIS_FILE "fn_camouflage.sqf"
#include "..\x_setup.sqf"

private _oldstance = stance player;

sleep 10;

while {true} do {
	if (d_player_canu) then {
		if (stance player isNotEqualTo _oldstance) then {
			_oldstance = stance player;
			call {
				if (_oldstance isEqualTo "STAND") exitWith {
					player setUnitTrait ["camouflageCoef", 1];
				};
				if (_oldstance isEqualTo "CROUCH") exitWith {
					player setUnitTrait ["camouflageCoef", 0.8];
				};
				if (_oldstance isEqualTo "PRONE") exitWith {
					player setUnitTrait ["camouflageCoef", 0.5];
				};
				player setUnitTrait ["camouflageCoef", 1];
			};
		};
	} else {
		waitUntil {sleep 1; d_player_canu};
	};
	sleep 2;
};
