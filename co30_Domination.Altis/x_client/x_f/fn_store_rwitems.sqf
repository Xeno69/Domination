// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_store_rwitems.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

private _primary = primaryWeapon player;
if (_primary != player getVariable "d_pprimweap") then {
	player setVariable ["d_pprimweap", _primary];
};
private _secondary = secondaryWeapon player;
if (_secondary != player getVariable "d_psecweap") then {
	player setVariable ["d_psecweap", _secondary];
};
private _handgun = handgunWeapon player;
if (_handgun != player getVariable "d_phandgweap") then {
	player setVariable ["d_phandgweap", _handgun];
};

__TRACE_3("","_primary","_secondary","_handgun")

private _primaryitems = primaryWeaponItems player;
if !(_primaryitems isEqualTo (player getVariable "d_pprimweapitems")) then {
	player setVariable ["d_pprimweapitems", _primaryitems];
};
private _secondaryitems = secondaryWeaponItems player;
if !(_secondaryitems isEqualTo (player getVariable "d_psecweapitems")) then {
	player setVariable ["d_psecweapitems", _secondaryitems];
};
private _handgunitems = handgunItems player;
if !(_handgunitems isEqualTo (player getVariable "d_phandgweapitems")) then {
	player setVariable ["d_phandgweapitems", _handgunitems];
};

__TRACE_3("","_primaryitems","_secondaryitems","_handgunitems")