// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkillsai.sqf"
#include "..\..\x_setup.sqf"

private _killer = param [1];
if (!isPlayer _killer) then {
	private _lead = leader _killer;
	if (!isNull _lead && {isPlayer _lead && {side (group _killer) getFriend d_side_enemy < 0.6}}) then {
		_lead addScore (param [0]);
	};
};