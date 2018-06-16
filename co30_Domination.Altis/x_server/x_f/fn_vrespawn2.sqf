// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vrespawn2.sqf"
#include "..\..\x_setup.sqf"

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
				if (_outb != -1) then {
					if (time > _outb) then {_disabled = true};
				} else {
					_vec setVariable ["d_OUT_OF_SPACE", time + 600];
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
			if (_number_v < 100 || {(_number_v > 999 && {_number_v < 1100})}) then {
				private _dhqcamo = _vec getVariable ["d_MHQ_Camo", objNull];
				if (!isNull _dhqcamo) then {deleteVehicle _dhqcamo};
			};
			private _isitlocked = _vec getVariable ["d_vec_islocked", false]; // || {_vec call d_fnc_isVecLocked};
			sleep 0.1;
			deleteVehicle _vec;
			sleep 0.5;
			_vec = createVehicle [_vec_a # 4, _vec_a # 2, [], 0, "NONE"];
			_vec setDir (_vec_a # 3);
			_vec setPos (_vec_a # 2);
			if (_vec isKindOf "Air") then {
				private _cposc = _vec_a # 2;
				__TRACE_2("","_vec","_cposc")
				if (surfaceIsWater _cposc) then {
					_cposc set [2, (getPosASL d_FLAG_BASE) # 2];
					[_vec, _cposc] spawn {
						params ["_vec", "_cposc"];
						sleep 1;
						_vec setPosASL _cposc;
						_vec setDamage 0;
					};
				};
			};
			_vec setFuel _fuelleft;
#ifdef __TT_
			if (_number_v < 1000) then {
				_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_checkveckillblufor}}];
			} else {
				_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_checkveckillopfor}}];
			};
#endif
			if (_number_v < 100 || {(_number_v > 999 && {_number_v < 1100})}) then {
				_vec addMPEventhandler ["MPKilled", {(_this select 0) call d_fnc_MHQFunc}];
				if (count _vec_a == 6) then {
					_vec setVariable ["d_vec_is_mhq", [_vec_a # 5, _number_v]];
				};
				_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_fuelCheck; _this call d_fnc_mhqmsg}}];
				_vec addEventHandler ["handleDamage", {_this call d_fnc_pshootatmhq}];
			};
			_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_fuelCheck}}];
			_vec_a set [0, _vec];
			_vec setVariable ["d_OUT_OF_SPACE", -1];
			_vec setVariable ["d_vec", _number_v, true];
			_vec setAmmoCargo 0;
			_vec setVariable ["d_vec_islocked", _isitlocked];
			if (_isitlocked) then {_vec lock true};
			if (_vec isKindOf "Air") then {
				_vec enableCopilot false;
			} else {
				_vec setVariable ["d_liftit", true, true];
			};
			sleep 0.01;
			_vec remoteExecCall ["d_fnc_initvec", [0, -2] select isDedicated];
		};
		sleep (8 + random 5);
	} forEach d_vrespawn2_ar;
	sleep (8 + random 5);
};
