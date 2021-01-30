// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initvecsspecial.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

{
	__TRACE_1("","_x")
	private _vec = _x;

	_vec setVariable ["d_OUT_OF_SPACE", -1];

	_vec setVariable ["d_vec_islocked", _vec call d_fnc_isVecLocked];
	
	_vec setVariable ["d_WreckMaxRepair", 10000000, true];
	
	_vec setVariable ["d_isspecialvec", true, true];
	
	[_vec, 11] call d_fnc_setekmode;
	
	if (unitIsUAV _vec) then {
		private _uavgrp = createVehicleCrew _vec;
		_vec allowCrewInImmobile true;
		_uavgrp deleteGroupWhenEmpty true;
		[_vec, 7] call d_fnc_setekmode;
		if (d_pylon_lodout == 0 && {isClass ((configOf _vec)>>"Components">>"TransportPylonsComponent")}) then {
			_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
		};
	};
	
	if !(_vec isKindOf "Air") then {
		_vec setVariable ["d_liftit", true, true];
	};
	if (!unitIsUAV _vec && {d_with_dynsim == 0}) then {
		[_vec, 10] spawn d_fnc_enabledynsim;
	};
	if (d_with_ranked) then {
		clearWeaponCargoGlobal _vec;
	};
	
	_vec spawn {
		scriptName "spawn initvecsspecial";
		sleep 10;
		_this allowDamage true;
	};
	
	_vec addEventHandler ["getIn", {call d_fnc_sgetinvec}];

	_vec addEventHandler ["getOut", {call d_fnc_sgetoutvec}];
	
	if (_vec isKindOf "Air" && {getNumber ((configOf _vec) >> "EjectionSystem" >> "EjectionSeatEnabled") == 1}) then {
		_vec addEventHandler ["getOut", {call d_fnc_aftereject}];
	};
	
	if !(_vec isKindOf "Air") then {
		_vec setVariable ["d_liftit", true, true];
	};
	_vec setDamage 0;
} forEach _this;
