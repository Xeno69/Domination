// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addkillsai.sqf"
#include "..\x_setup.sqf"

params ["_p", "_killer", "_instigator"];

if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill

if (isNull _instigator) exitWith {};

if !(_instigator call d_fnc_isplayer) then {
	private _lead = leader _instigator;
	if (!isNull _lead && {(_lead call d_fnc_isplayer) && {side (group _instigator) getFriend d_side_enemy < 0.6}}) then {
		_lead addScore (_this select 0);
	};
};