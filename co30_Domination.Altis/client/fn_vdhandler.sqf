// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifndef __DEBUG__
sleep 15;
#else
sleep 5;
#endif

while {true} do {
	sleep 1;
	if (d_cur_tgt_pos isNotEqualTo []) exitWith {};
};

private _checkvdpos = {
	if (player distance2D d_cur_tgt_pos < 550) exitWith {
		true
	};
	if (player distance2D d_flag_base < 550) exitWith {
		true
	};
	false
};

while {true} do {
	if (isNil "d_maintarget_auto_vd") then {
		d_maintarget_auto_vd = true; // d_maintarget_auto_vd suddenly was nil in MP testing and I have no idea why, so small workaround to avoid script errors
	};
	if (d_maintarget_auto_vd) then {
		if (!d_isvdreduced && {isNil "d_is_sat_on" && {isNull (findDisplay 312) && {viewDistance > 600 && {isNull objectParent player && {call _checkvdpos}}}}}) then {
			setViewDistance 600;
			setObjectViewDistance 700;
			d_isvdreduced = true;
		} else {
			if (d_isvdreduced && {alive player && {!isNil "d_is_sat_on" || {!isNull (findDisplay 312) || {!isNull objectParent player || {!(call _checkvdpos)}}}}}) then {
				setViewDistance d_curviewdistance;
				setObjectViewDistance d_curobjectdistance;
				d_isvdreduced = false;
			};
		};
	} else {
		if (d_isvdreduced) then {
			setViewDistance d_curviewdistance;
			setObjectViewDistance d_curobjectdistance;
			d_isvdreduced = false;
		};
	};
	sleep 10;
};