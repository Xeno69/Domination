// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_skinpolyresp.sqf"
#include "..\..\x_setup.sqf"

params ["_vec", "_skinpoly"];

if (_skinpoly isEqualTo ([_vec] call d_fnc_getskinpoly)) exitWith {};

_skinpoly params ["_textures", "_anims", "_airar"];

if (!(_textures isEqualTo []) && {!(getObjectTextures _vec isEqualTo _textures)}) then {
	for "_i" from 0 to count _textures - 1 do {
		_vec setObjectTextureGlobal [_i, _textures select _i];
	};
};

if !(_anims isEqualTo []) then {
	{_vec animate _x} forEach _anims;
};

if (_vec isKindOf "air") then {
	{
		_vec removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")
	} forEach getPylonMagazines _vec;
	private _pylonPaths = _airar # 1;
	{
		_vec setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]
	} forEach (_airar # 0);
};
