// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_flag", "_marker"];

player reveal _flag;

if (d_jumpflag_vec isEqualTo "") then {
	_flag setVariable ["d_jf_id", _flag addAction [format ["<t color='#D64C30' size='1.2'>%1</t>", localize "STR_DOM_MISSIONSTRING_296"], {_this spawn d_fnc_paraj}, 1, 1.5, true, true, "", "true", 10]];
} else {
	_flag setVariable ["d_jf_id", _flag addAction [format ["<t color='#AAD9EF'>%1</t>", format [localize "STR_DOM_MISSIONSTRING_297", [d_jumpflag_vec, "CfgVehicles"] call d_fnc_GetDisplayName]], {_this spawn d_fnc_bike}, [d_jumpflag_vec, 1], 1.5, true, true, "", "true", 10]];
};

#ifndef __TT__
d_near_player_flag_pos = getPosASL _flag vectorAdd [0, 0, 10];
d_near_player_flag_marker = _marker;
d_near_player_flag_pos2 = getPosASL _flag;
d_near_player_flag_pos2 set [2, 15];
d_near_player_flag = _flag;
#endif
