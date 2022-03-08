// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_switcher", "", "_vec"];

if (_vec isKindOf "Air") then {
	if (currentPilot _vec != player) then {
		if (!isNil {_vec getVariable "d_plyonloadoutaction"}) then {
			[_vec, _vec getVariable "d_plyonloadoutaction"] call bis_fnc_holdActionRemove;
			_vec setVariable ["d_plyonloadoutaction", nil];
		};
	} else {
		if (d_pylon_lodout == 0 && {!unitIsUAV _vec && {isClass ((configOf _vec)>>"Components">>"TransportPylonsComponent") && {isNil {_vec getVariable "d_disable_pylonloadout"}}}}) then {
			_vec call d_fnc_addpylon_action;
		};
	};
};
