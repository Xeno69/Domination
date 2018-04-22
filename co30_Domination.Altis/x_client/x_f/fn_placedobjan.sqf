// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_placedobjan.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated || {!hasInterface}) exitWith {};

if (d_string_player == _this) then {
	if (player getUnitTrait "Medic") then {
		player setVariable ["d_medtent", []];
		player setVariable ["d_medic_tent", objNull];
		systemChat (localize "STR_DOM_MISSIONSTRING_656");
	};
	if (player getUnitTrait "engineer") then {
		player setVariable ["d_farp_pos", []];
		player setVariable ["d_farp_obj", objNull];
		systemChat (localize "STR_DOM_MISSIONSTRING_658");
	};
};