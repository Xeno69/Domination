// by Xeno
#include "..\x_setup.sqf"

params ["_pr"];

private _ret = false;

if (d_sm_mt_protectionAI == 1 || {d_sm_mt_protectionAI == 3}) then {
	__TRACE("In 1 or 3")
	if (d_cur_sm_idx != -1 && {!isNil "d_x_sm_pos"}) then {
		__TRACE_1("","d_x_sm_pos")
		if (d_x_sm_type == "convoy") exitWith {};
		private _checkpos = [d_x_sm_pos # 1, d_x_sm_pos # 0] select (d_x_sm_type != "deliver");
		if (_pr distance2D _checkpos < 1000) then {
			player sideChat (localize "STR_DOM_MISSIONSTRING_2106");
			_ret = true;
		};
	};
};
if (d_sm_mt_protectionAI == 2 || {d_sm_mt_protectionAI == 3}) then {
	__TRACE("In 2 or 3")
	if (d_cur_tgt_pos isNotEqualTo []) then {
		__TRACE("cur target pos ok")
		if (_pr distance2D d_cur_tgt_pos < 1000) then {
			__TRACE("dist below 1000")
			player sideChat (localize "STR_DOM_MISSIONSTRING_2107");
			_ret = true;
		};
	};
};

_ret
