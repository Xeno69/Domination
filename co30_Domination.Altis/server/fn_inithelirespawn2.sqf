// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_inithelirespawn2.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

__TRACE("Start")

d_helirespawn2_ar = [];
{
	private _vec_a = _x;
	_vec_a params ["_vec"];
	if (!isNil "_vec" && {!isNull _vec}) then {
		_vec_a params ["", "_number_v", "_ifdamage"];
		private _vposp = (getPosATL _vec) vectorAdd [0, 0, 0.1];
		d_helirespawn2_ar pushBack [_vec, _number_v, _ifdamage, -1, _vposp, direction _vec, typeOf _vec, if (_ifdamage) then {-1} else {_vec_a # 3}];
		
		_vec setVariable ["d_OUT_OF_SPACE", -1];
		_vec setVariable ["d_vec", _number_v, true];
		_vec setVariable ["d_vec_islocked", _vec call d_fnc_isVecLocked];
		
		_vec setPos _vposp;
		_vec setDamage 0;
		
		_vec addEventhandler ["local", {_this call d_fnc_heli_local_check}];
		
#ifdef __TT__
		if (_number_v < 4000) then {
			[_vec, "d_cvkblu"] call d_fnc_setekmode;
		} else {
			[_vec, "d_cvkopf"] call d_fnc_setekmode;
		};
#endif
		
		[_vec, "d_chkill"] call d_fnc_setekmode;
	
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

__TRACE("Before d_fnc_helirespawn2")

0 spawn d_fnc_helirespawn2;
