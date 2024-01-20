// by Xeno
//#include "..\x_setup.sqf"

params ["_vec", "_killer", "_insti"];

if (isNull _insti) then {_insti = UAVControl vehicle _killer # 0}; // UAV/UGV player operated road kill
if (!isNull _insti) then {_killer = _insti}; // player driven vehicle road kill

if (d_with_ace && {isNull _killer}) then {
	_killer = _vec getVariable ["ace_medical_lastDamageSource", _killer];
};

if !(isPlayer [_killer]) exitWith {};

if (side (group _killer) == blufor) then {
	if (!isServer) then {
		[_killer, 2] remoteExecCall ["d_fnc_ttpvkill", 2];
	} else {
		[_killer, 2] call d_fnc_ttpvkill;
	};
};
