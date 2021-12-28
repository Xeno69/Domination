// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

player setVariable ["d_pprimweap", primaryWeapon player];
player setVariable ["d_psecweap", secondaryWeapon player];
player setVariable ["d_phandgweap", handgunWeapon player];
player setVariable ["d_pprimweapitems", primaryWeaponItems player];
player setVariable ["d_psecweapitems", secondaryWeaponItems player];
player setVariable ["d_phandgweapitems", handgunItems player];
