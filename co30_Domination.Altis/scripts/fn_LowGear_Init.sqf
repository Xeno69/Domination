// by WINSE
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_veh"];

RIP_LOWGEARON = false;
RIP_LOWGEARACTON = nil;
RIP_LOWGEARACTOFF = nil;

while {true} do {
		sleep 0.1;
		if (!RIP_LOWGEARON && {player == driver _veh && {canMove _veh && {isNil "RIP_LOWGEARACTON"}}}) then {
			RIP_LOWGEARACTON = _veh addAction [localize "STR_DOM_MISSIONSTRING_2034", {0 spawn d_fnc_LowGearOn}, "", -1, false, false, "", "driver  _target == _this"];
		};
		if (player != driver _veh && {!isNil "RIP_LOWGEARACTON"}) then {
			_veh removeAction RIP_LOWGEARACTON;
			RIP_LOWGEARACTON = nil;
		};
		if (!d_player_in_vec) exitWith {};
};

if (!isNil "RIP_LOWGEARACTON") then {
	_veh removeAction RIP_LOWGEARACTON;
	RIP_LOWGEARON = false;
	RIP_LOWGEARACTON = nil;
};