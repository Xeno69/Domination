// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initvrespawn2.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

d_vrespawn2_ar = [];
{
	__TRACE_1("","_x")
	_x params ["_vec", "_number_v"];
	if (!isNil "_vec" && {!isNull _vec}) then {
		private _vposp = if (_vec isKindOf "Air") then {
			(getPosATL _vec) vectorAdd [0, 0, 0.1];
		} else {
			getPosATL _vec;
		};
		if (count _x == 2) then {
			d_vrespawn2_ar pushBack [_vec, _number_v, _vposp, getDir _vec, typeOf _vec];
		} else {
			d_vrespawn2_ar pushBack [_vec, _number_v, _vposp, getDir _vec, typeOf _vec, _x # 2];
			_vec setVariable ["d_vec_is_mhq", [_x # 2, _number_v]];
		};
		
		_vec setVariable ["d_OUT_OF_SPACE", -1];
		_vec setVariable ["d_vec", _number_v, true];
		_vec setVariable ["d_vec_islocked", _vec call d_fnc_isVecLocked];
#ifdef __TT__
		if (_number_v < 1000) then {
			[_vec, "d_cvkblu"] call d_fnc_setekmode;
		} else {
			[_vec, "d_cvkopf"] call d_fnc_setekmode;
		};
#endif
		[_vec, "d_fuelc"] call d_fnc_setekmode;
		if (_number_v < 100 || {_number_v > 999 && {_number_v < 1100}}) then {
			if (d_NoMHQTeleEnemyNear > 0) then {
				[_vec, "d_mhqf"] call d_fnc_setekmode;
			};
			[_vec, "d_mhqmsg"] call d_fnc_setekmode;
			_vec addEventHandler ["handleDamage", {_this call d_fnc_pshootatmhq}];
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
		if !(_vec isKindOf "Air") then {
			_vec setVariable ["d_liftit", true, true];
		};
		if (unitIsUAV _vec) then {
			_vec allowCrewInImmobile true;
		} else {
			if (d_with_dynsim == 0) then {
				_vec spawn {
					scriptName "spawn enable dyn";
					sleep 10;
					if (alive _this) then {
						_this enableDynamicSimulation true;
					};
				};
			};
		};
		if (d_with_ranked) then {
			clearWeaponCargoGlobal _vec;
		};
	};
} forEach _this;

0 spawn d_fnc_vrespawn2;
