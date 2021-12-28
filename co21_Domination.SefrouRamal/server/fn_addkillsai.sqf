// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_p", "_killer", "_insti"];

if (isNull _insti) exitWith {};

if !(_insti call d_fnc_isplayer) then {
	private _lead = leader _insti;
	if (!isNull _lead && {(_lead call d_fnc_isplayer) && {side (group _insti) getFriend d_side_enemy < 0.6}}) then {
		_lead addScore (_this # 0);
	};
};