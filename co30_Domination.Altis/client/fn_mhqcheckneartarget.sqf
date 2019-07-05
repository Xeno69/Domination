// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mhqcheckneartarget.sqf"
#include "..\x_setup.sqf"

params ["_vec"];
while {d_player_in_vec} do {
#ifndef __TT__
	if (fuel _vec != 0 && {player == driver _vec && {!(_vec inArea d_base_array)}}) then {
#else
	if (fuel _vec != 0 && {player == driver _vec && {!(_vec inArea (d_base_array # 0)) && {!(_vec inArea (d_base_array # 1))}}}) then {
#endif
		if (d_current_target_index != -1) then {
			if (!(d_cur_tgt_pos isEqualTo []) && {_vec distance2D d_cur_tgt_pos <= d_MHQDisableNearMT}) then {
				_vec setVariable ["d_vecfuelmhq", fuel _vec, true];
				[_vec, 0] remoteExecCall ["setFuel", _vec];
				[format [localize "STR_DOM_MISSIONSTRING_520", d_MHQDisableNearMT, _vec getVariable "d_vec_name"], "HQ"] remoteExecCall ["d_fnc_HintChatMsg", d_player_side];
			};
		};
	};
	sleep 0.531;
};
d_playerInMHQ = false;
