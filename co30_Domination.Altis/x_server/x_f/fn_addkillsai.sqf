// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkillsai.sqf"
#include "..\..\x_setup.sqf"

private _killer = param [1];
if !(_killer call d_fnc_isplayer) then {
	private _lead = leader _killer;
	if (!isNull _lead && {(_lead call d_fnc_isplayer) && {side (group _killer) getFriend d_side_enemy < 0.6}}) then {
		_lead addScore (param [0]);
	};
};