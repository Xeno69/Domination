// by Xeno
#define THIS_FILE "fn_checkveckillopfor.sqf"
#include "..\x_setup.sqf"

params ["_vec", "_killer", "_instigator"];

if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
if (!isNull _instigator) then {_killer = _instigator}; // player driven vehicle road kill

if (d_with_ace && {isNull _killer}) then {
	_killer = _vec getVariable ["ace_medical_lastDamageSource", _killer];
};

if !(_killer call d_fnc_isplayer) exitWith {};

if (side (group _killer) == blufor) then {
	if (!isServer) then {
		[_killer, 2] remoteExecCall ["d_fnc_ttpvkill", 2];
	} else {
		[_killer, 2] call d_fnc_ttpvkill;
	};
};
