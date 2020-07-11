// by Xeno
#define THIS_FILE "fn_toggle3dm.sqf"
#include "..\x_setup.sqf"

if ((_this # 1) in actionKeys d_3dmarker_userakey_str && {alive player && {!(player getVariable "xr_pluncon") && {!(player getVariable ["ace_isunconscious", false]) && {!(_this # 2) && {!(_this # 3) && {!(_this # 4)}}}}}}) then {
	d_showallnearusermarkers = !d_showallnearusermarkers;
	if (d_showallnearusermarkers) then {
		"d_usermarkers" cutText ["<br/><br/><t color='#339933' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1946" + "</t>", "PLAIN DOWN", -1, true, true];
	} else {
		"d_usermarkers" cutText ["<br/><br/><t color='#FF3333' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1947" + "</t>", "PLAIN DOWN", -1, true, true];
	};
	true
} else {
	false
};