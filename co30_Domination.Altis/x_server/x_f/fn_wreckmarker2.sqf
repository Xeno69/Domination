// by Xeno
#define THIS_FILE "fn_wreckmarker2.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith {};
private _vec = _this;
sleep 5;
#ifndef __TT__
while {_vec distance d_wreck_rep > 30 && {(_vec call d_fnc_GetHeight) > 1 && {speed _vec > 1}}} do {sleep 2 + random 2};
if (_vec distance d_wreck_rep <= 30) exitWith {};
#else
while {_vec distance d_wreck_rep > 30 && {_vec distance d_wreck_rep2 > 30 && {(_vec call d_fnc_GetHeight) > 1 && {speed _vec > 1}}}} do {sleep 2 + random 2};
if (_vec distance d_wreck_rep <= 30 || {_vec distance d_wreck_rep2 <= 30}) exitWith {};
#endif
while {speed _vec > 4 && {(getPosATL _vec) # 2 >= -20}} do {sleep 1.532 + random 1.2};
sleep 0.01;
if ((getPosATL _vec) # 2 < -20) then {
	private _aposs = getPosATL _vec;
	_aposs set [2, 0];
	_vec setPos _aposs;
};
if ((vectorUp _vec) # 2 < 0) then {_vec setVectorUp [0,0,1]};
while {speed _vec > 4 && {(getPosATL _vec) # 2 >= -10}} do {sleep 1.532 + random 1.2};
if ((getPosATL _vec) # 2 < -20) then {
	private _aposs = getPosATL _vec;
	_aposs set [2, 0];
	_vec setPos _aposs;
};
private _mname = format ["%1_%2", _vec, time];
private _sav_pos = [getPosWorld _vec # 0, getPosWorld _vec # 1, 0];
_vec setPos _sav_pos;
_vec setVelocity [0,0,0];
[_mname, _sav_pos, "ICON", "ColorBlue", [1,1], format [localize "STR_DOM_MISSIONSTRING_517", [typeOf _vec, "CfgVehicles"] call d_fnc_GetDisplayName], 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
private _timedel = if (d_WreckDeleteTime != -1) then {time + d_WreckDeleteTime} else {time + (1e+011)};
while {!isNull _vec && {_vec distance _sav_pos < 30 && {time < _timedel}}} do {sleep 3.321 + random 2.2};
deleteMarker _mname;
if (time > _timedel && {_vec distance _sav_pos < 50}) then {
	if (unitIsUAV _vec) then {
		{_vec deleteVehicleCrew _x} forEach (crew _vec);
	};
	deleteVehicle _vec;
} else {
	_vec spawn d_fnc_wreckmarker2;
};