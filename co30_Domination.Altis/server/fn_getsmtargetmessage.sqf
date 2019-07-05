// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getsmtargetmessage.sqf"
#include "..\x_setup.sqf"

switch (_this) do {
	case "gov_dead": {localize "STR_DOM_MISSIONSTRING_949"};
	case "radar_down": {localize "STR_DOM_MISSIONSTRING_951"};
	case "ammo_down": {localize "STR_DOM_MISSIONSTRING_952"};
	case "med_down": {localize "STR_DOM_MISSIONSTRING_953"};
	case "hq_down": {localize "STR_DOM_MISSIONSTRING_954"};
	case "light_down": {localize "STR_DOM_MISSIONSTRING_955"};
	case "heavy_down": {localize "STR_DOM_MISSIONSTRING_956"};
	case "airrad_down": {localize "STR_DOM_MISSIONSTRING_958"};
	case "lopo_dead": {localize "STR_DOM_MISSIONSTRING_959"};
	case "dealer_dead": {localize "STR_DOM_MISSIONSTRING_960"};
	case "sec_over": {localize "STR_DOM_MISSIONSTRING_961"};
};