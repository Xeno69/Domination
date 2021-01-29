// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playsound.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (d_cur_tgt_pos isNotEqualTo [] && {player distance2D d_cur_tgt_pos < d_mttarget_radius_patrol}) then {
	playSound _this;
};