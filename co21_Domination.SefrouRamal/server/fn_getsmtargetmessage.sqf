// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

call {
	if (_this == "gov_dead") exitWith {localize "STR_DOM_MISSIONSTRING_949"};
	if (_this == "radar_down") exitWith {localize "STR_DOM_MISSIONSTRING_951"};
	if (_this == "ammo_down") exitWith {localize "STR_DOM_MISSIONSTRING_952"};
	if (_this == "med_down") exitWith {localize "STR_DOM_MISSIONSTRING_953"};
	if (_this == "hq_down") exitWith {localize "STR_DOM_MISSIONSTRING_954"};
	if (_this == "light_down") exitWith {localize "STR_DOM_MISSIONSTRING_955"};
	if (_this == "heavy_down") exitWith {localize "STR_DOM_MISSIONSTRING_956"};
	if (_this == "airrad_down") exitWith {localize "STR_DOM_MISSIONSTRING_958"};
	if (_this == "lopo_dead") exitWith {localize "STR_DOM_MISSIONSTRING_959"};
	if (_this == "dealer_dead") exitWith {localize "STR_DOM_MISSIONSTRING_960"};
	if (_this == "sec_over") exitWith {localize "STR_DOM_MISSIONSTRING_961"};
};