// by Xeno edited by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

d_mt_radio_down = true;
d_campscaptured = d_sum_camps;
if (d_ao_markers == 1) then {
	deleteMarker "d_m_t_rt";
};
if (d_ao_check_for_ai < 2) then {
	d_mt_barracks_down = true;
};
0 spawn d_fnc_target_clear;
