// by Xeno
#define THIS_FILE "fn_m_a_h_a.sqf"
#include "..\..\x_setup.sqf"

if (player != param [1]) then {
	(param [0]) addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_286a"], {_this call d_fnc_healatmash}, 0, -1, false, false, "", "damage player > 0 && {alive player && {!(player getVariable ['xr_pluncon', false]) && {!(player getVariable ['ace_isunconscious', false]) && {!(player getVariable 'd_isinaction')}}}}"];
};
