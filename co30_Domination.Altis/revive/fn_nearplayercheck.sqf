// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

xr_near_players = d_allplayers select {alive _x && {_x != player && {!(_x getVariable ["xr_pluncon", false]) && {_x distance2D player < 50}}}};

//__TRACE_1("","xr_near_players")
if (xr_near_players isNotEqualTo []) then {
	player remoteExecCall ["xr_fnc_announcenear", xr_near_players select {!isNull _x}];
};
xr_next_pl_near_check = time + 60;

if (_this) then {
	call xr_fnc_nearplayercheckui;
};