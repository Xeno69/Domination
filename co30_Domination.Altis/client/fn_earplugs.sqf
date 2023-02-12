// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if ((_this # 1) in d_ak_earplugs) then {
	if (d_player_canu && {!(_this # 2) && {!(_this # 3) && {!(_this # 4)}}}) then {
		if (d_earplugs_fitted) then {
			d_earplugs_fitted = false;
			2 fadeSound 1;
			"d_earplugs" cutText ["<t color='#FF3333' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1870" + "</t>", "PLAIN DOWN", -1, true, true];
		} else {
			d_earplugs_fitted = true;
			2 fadeSound 0.2;
			"d_earplugs" cutText ["<t color='#339933' size='2'font='PuristaBold'>" + localize "STR_DOM_MISSIONSTRING_1869" + "</t>", "PLAIN DOWN", -1, true, true];
		};
		__TRACE("true")
		true
	} else {
		false
	};
} else {
	__TRACE("false")
	false
};