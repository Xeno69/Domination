// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkillsai.sqf"
#include "..\x_setup.sqf"

params ["_p", "_killer", "_insti"];

if (isNull _insti) then {_insti = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
if (isNull _insti) then {_insti = _killer}; // player driven vehicle road kill

if (isNull _insti) exitWith {};

if !(_insti call d_fnc_isplayer) then {
	private _lead = leader _insti;
	if (!isNull _lead && {(_lead call d_fnc_isplayer) && {side (group _insti) getFriend d_side_enemy < 0.6}}) then {
		_lead addScore (_this select 0);
	};
};