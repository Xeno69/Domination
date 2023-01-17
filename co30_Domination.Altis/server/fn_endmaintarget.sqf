// by Xeno edited by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

d_mt_radio_down = true;
d_campscaptured = d_sum_camps;
if (d_ao_markers == 1) then {
	deleteMarker "d_m_t_rt";
};
d_target_clear = true;
publicVariable "d_target_clear";
0 spawn d_fnc_target_clear;
