// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];
while {d_player_in_vec} do {
#ifndef __TT__
	if (fuel _vec != 0 && {player == currentPilot _vec && {!(_vec inArea d_base_array)}}) then {
#else
	if (fuel _vec != 0 && {player == currentPilot _vec && {!(_vec inArea (d_base_array # 0)) && {!(_vec inArea (d_base_array # 1))}}}) then {
#endif
		if (d_current_target_index != -1) then {
			if (d_cur_tgt_pos isNotEqualTo [] && {_vec distance2D d_cur_tgt_pos <= d_MHQDisableNearMT}) then {
				_vec setVariable ["d_vecfuelmhq", fuel _vec, true];
				[_vec, 0] remoteExecCall ["setFuel", _vec];
				[2, _vec getVariable "d_vec_name"] remoteExecCall ["d_fnc_csidechat", d_player_side];
			};
		};
	};
	sleep 0.531;
};
d_playerInMHQ = false;
