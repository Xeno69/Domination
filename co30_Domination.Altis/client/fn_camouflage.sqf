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
					if (player getUnitTrait "camouflageCoef" != 1) then {
						player setUnitTrait ["camouflageCoef", 1];
					};
					if (player getUnitTrait "audibleCoef" != 1) then {
						player setUnitTrait ["audibleCoef ", 1];
					};
				};
				if (_oldstance isEqualTo "CROUCH") exitWith {
					if (player getUnitTrait "camouflageCoef" != 0.8) then {
						player setUnitTrait ["camouflageCoef", 0.8];
					};
					if (player getUnitTrait "audibleCoef" != 0.8) then {
						player setUnitTrait ["audibleCoef ", 0.8];
					};
				};
				if (_oldstance isEqualTo "PRONE") exitWith {
					if (player getUnitTrait "camouflageCoef" != 0.5) then {
						player setUnitTrait ["camouflageCoef", 0.5];
					};
					if (player getUnitTrait "audibleCoef" != 0.5) then {
						player setUnitTrait ["audibleCoef ", 0.5];
					};
				};
				if (player getUnitTrait "camouflageCoef" != 1) then {
					player setUnitTrait ["camouflageCoef", 1];
				};
				if (player getUnitTrait "audibleCoef" != 1) then {
					player setUnitTrait ["audibleCoef ", 1];
				};
			};
		};
	} else {
		waitUntil {sleep 1; d_player_canu};
	};
	sleep 2;
};
