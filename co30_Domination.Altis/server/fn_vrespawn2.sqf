// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

sleep (8 + round 5);

while {true} do {
	{
		private _vec_a = _x;
		_vec_a params ["_vec"];
		
		__TRACE_1("","_vec_a")
		
		private _disabled = false;
		
		private _empty = false;
		
		if (alive _vec) then {
			_disabled = damage _vec >= 0.9;
			_empty = (crew _vec) findIf {alive _x} == -1;
			
			__TRACE_1("","_vec call d_fnc_OutOfBounds")
			
			if (_empty && {!_disabled && {alive _vec && {_vec call d_fnc_OutOfBounds}}}) then {
				private _outb = _vec getVariable "d_OUT_OF_SPACE";
				if (!isNil "_outb") then {
					if (_outb != -1) then {
						if (time > _outb) then {_disabled = true};
					} else {
						_vec setVariable ["d_OUT_OF_SPACE", time + 600];
					};
				} else {
					_vec setVariable ["d_OUT_OF_SPACE", -1];
				};
			} else {
				_vec setVariable ["d_OUT_OF_SPACE", -1];
			};
			sleep 0.01;
		};

		__TRACE_3("","_empty","_disabled","alive _vec")
		__TRACE_1("","underwater _vec")
		
		if (!alive _vec || {_empty && {_disabled || {underwater _vec}}}) then {
			private _number_v = _vec_a # 1;
			private _fuelleft = _vec getVariable ["d_fuel", 1];
			if (_vec getVariable ["d_ammobox", false]) then {
				d_num_ammo_boxes = d_num_ammo_boxes - 1; publicVariable "d_num_ammo_boxes";
			};
			private _canloadbox = _vec getVariable ["d_canloadbox", false];
			if (_number_v < 100 || {(_number_v > 999 && {_number_v < 1100})}) then {
				private _dhqcamo = _vec getVariable ["d_MHQ_Camo", objNull];
				if (!isNull _dhqcamo) then {deleteVehicle _dhqcamo};
			};
			private _isitlocked = _vec getVariable ["d_vec_islocked", false]; // || {_vec call d_fnc_isVecLocked};
			private _skinpoly = [_vec] call d_fnc_getskinpoly;
			private _aslpos = _vec getVariable "d_posasl";
			__TRACE_1("","_skinpoly")
#ifdef __GMCWG__
			private _attribs = _vec getvariable "GM_VEHICLE_ATTRIBUTES";
#endif
			sleep 0.1;
			if (unitIsUAV _vec) then {
				{_vec deleteVehicleCrew _x} forEach (crew _vec);
			};
			deleteVehicle _vec;
			sleep 0.5;
			_vec = createVehicle [_vec_a # 4, _vec_a # 2, [], 0, "NONE"];
			_vec setDir (_vec_a # 3);
			_vec setPos (_vec_a # 2);
			_vec allowDamage false;
			if (!isNil "_aslpos") then {
				_vec setVariable ["d_posasl", _aslpos];
				[_vec] spawn {
					scriptname "spawn vrespawn2";
					params ["_vec"];
					sleep 1;
					_vec setPosASL (_vec getVariable "d_posasl");
					_vec setDamage 0;
					sleep 2;
					_vec allowDamage true;
				};
			};
			_vec setFuel _fuelleft;
			[_vec, _skinpoly] call d_fnc_skinpolyresp;
			_skinpoly = nil;
#ifdef __TT__
			if (_number_v < 1000) then {
				[_vec, 1] call d_fnc_setekmode;
			} else {
				[_vec, 2] call d_fnc_setekmode;
			};
#endif
			[_vec, 9] call d_fnc_setekmode;
			if (_number_v < 100 || {(_number_v > 999 && {_number_v < 1100})}) then {
				if (d_NoMHQTeleEnemyNear > 0) then {
					[_vec, 14] call d_fnc_setekmode;
				};
				if (count _vec_a == 6) then {
					_vec setVariable ["d_vec_is_mhq", [_vec_a # 5, _number_v]];
				};
				[_vec, 10] call d_fnc_setekmode;
				_vec addEventHandler ["handleDamage", {call d_fnc_pshootatmhq}];
#ifndef __TT__
				private _flag = call {
					if (d_own_side == "EAST") exitWith {"\a3\data_f\flags\flag_red_co.paa"};
					if (d_own_side == "WEST") exitWith {"\a3\data_f\flags\flag_blue_co.paa"};
					"\a3\data_f\flags\flag_green_co.paa"			
				};
				_vec forceFlagTexture _flag;
#endif
#ifdef __TT__
				if (_number_v < 100) then {
					_vec setVariable ["d_side", blufor];
				} else {
					if (_number_v > 999 && {_number_v < 1100}) then {
						_vec setVariable ["d_side", opfor];
					};
				};
#endif
			};
			_vec_a set [0, _vec];
			_vec setVariable ["d_OUT_OF_SPACE", -1];
			_vec setVariable ["d_vec", _number_v, true];
			_vec setVariable ["d_vec_islocked", _isitlocked];
			if (_isitlocked) then {_vec lock true};
			if (_canloadbox) then {
				_vec setVariable ["d_canloadbox", true, true];
			};
			if !(_vec isKindOf "Air") then {
				_vec setVariable ["d_liftit", true, true];
			};
			if (unitIsUAV _vec) then {
				private _uavgrp = createVehicleCrew _vec;
				_vec allowCrewInImmobile true;
				_uavgrp deleteGroupWhenEmpty true;
				[_vec, 7] call d_fnc_setekmode;
				if (d_pylon_lodout == 0 && {isClass ((configOf _vec)>>"Components">>"TransportPylonsComponent")}) then {
					_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
				};
			} else {
				if (d_with_dynsim == 0) then {
					[_vec, 10] spawn d_fnc_enabledynsim;
				};
			};
#ifdef __GMCWG__
			if (!isNil "_attribs") then {
				_vec setVariable ["GM_VEHICLE_ATTRIBUTES", _attribs];
				[_vec] spawn gm_core_vehicles_fnc_vehicleMarkingsInit;
			};
#endif
			sleep 0.01;
			_vec remoteExecCall ["d_fnc_initvec", [0, -2] select isDedicated];
			if (d_with_ranked) then {
				clearWeaponCargoGlobal _vec;
			};
			if (isNil "_aslpos") then {
				_vec allowDamage true;
			};
			if (_vec isKindOf "Boat_F") then {
				_vec remoteExecCall ["d_fnc_addpushaction", [0, -2] select isDedicated];
			};
			_vec setDamage 0;
		};
		sleep (8 + random 5);
	} forEach d_vrespawn2_ar;
	sleep (8 + random 5);
};
