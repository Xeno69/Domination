// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_nearplayercheck.sqf"
#include "..\x_macros.sqf"

private _xr_near_players = [];
{
		_xr_near_players append (crew _x);
} forEach ((player nearEntities 50) select {alive _x});

xr_near_players = _xr_near_players select {(_x call d_fnc_isplayer) && {_x != player && {!(_x getVariable ["xr_pluncon", false]) && {xr_side_pl getFriend side (group _x) >= 0.6}}}};

__TRACE_1("","xr_near_players")
if !(xr_near_players isEqualTo []) then {
	{
		player remoteExecCall ["xr_fnc_announcenear", _x];
	} forEach (xr_near_players select {!isNull _x});
};
xr_next_pl_near_check = time + 60;

if (_this) then {
	call xr_fnc_nearplayercheckui;
};