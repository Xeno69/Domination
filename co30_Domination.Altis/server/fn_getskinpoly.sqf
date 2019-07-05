// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getskinpoly.sqf"
#include "..\x_setup.sqf"

params ["_vec"];

private _anims = [];
private _animnames = animationNames _vec;
if !(_animnames isEqualTo []) then {
	for "_i" from 0 to count _animnames -1 do {
		_anims pushBack [_animnames select _i, _vec animationPhase (_animnames select _i)];
	};
};

private _airar = [];
if (_vec isKindOf "Air") then {
	_airar pushBack (getPylonMagazines _vec);
	_airar pushBack ((configProperties [configFile >> "CfgVehicles" >> typeOf _vec >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")});
};

[getObjectTextures _vec, _anims, _airar]