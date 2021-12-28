// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_do_hint"];

__TRACE_1("","d_cur_sm_idx")

if (d_cur_sm_idx == -1) exitWith {};

//if (isServer && {!isDedicated}) then {
if (!isServer) then {
	if (d_cur_sm_idx < 50000) then {
		call compileScript [format ["missions\%3\%2%1.sqf", d_cur_sm_idx, d_sm_fname, d_sm_folder], false];
	} else {
		[d_cur_sm_idx] call d_fnc_getbymarkersm;
	};
};

if (d_with_ranked || {d_database_found}) then {
	d_was_at_sm = false;
	d_sm_running = true;

	if (d_cur_sm_idx != -1 && {d_x_sm_type != "convoy"}) then {
		(d_x_sm_pos # 0) spawn d_fnc_sm_dist;
	};
};

if (_do_hint) then {
	playSound "d_IncomingChallenge2";
	hint composeText[
		parseText ("<t color='#f000ffff' size='1'>" + (localize "STR_DOM_MISSIONSTRING_710") + "</t>"),
		lineBreak,
		lineBreak,
		d_cur_sm_txt
	];
};

[true, "d_sm_task", [d_cur_sm_txt, "Side Mission", format ["d_XMISSIONM%1", d_cur_sm_idx + 1]], d_x_sm_pos # 0, false, 1, true, "Attack", false] call d_fnc_taskcreate;
