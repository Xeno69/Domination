// by Xeno
#define THIS_FILE "fn_earplugs.sqf"
#include "..\x_setup.sqf"

if ((_this select 1) in actionKeys d_earplugs_userakey_str && {alive player && {!(player getVariable "xr_pluncon") && {!(player getVariable ["ace_isunconscious", false]) && {!(_this select 2) && {!(_this select 3) && {!(_this select 4)}}}}}}) then {
	if (d_earplugs_fitted) then {
		d_earplugs_fitted = false;
		2 fadeSound 1;
		"d_earplugs" cutText ["<t color='#FF3333' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1870" + "</t>", "PLAIN DOWN", -1, true, true];
	} else {
		d_earplugs_fitted = true;
		2 fadeSound 0.2;
		"d_earplugs" cutText ["<t color='#339933' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1869" + "</t>", "PLAIN DOWN", -1, true, true];
	};
	true
} else {
	false
};