// by Xeno
//#define __DEBUG__
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
		
		_vec addEventhandler ["local", {call d_fnc_heli_local_check}];
		
#ifdef __TT__
		if (_number_v < 4000) then {
			[_vec, 1] call d_fnc_setekmode;
		} else {
			[_vec, 2] call d_fnc_setekmode;
		};
#endif
		
		[_vec, 8] call d_fnc_setekmode;
	
		if (unitIsUAV _vec) then {
			_vec allowCrewInImmobile true;
		} else {
			if (d_with_dynsim == 0) then {
				[_vec, 10] spawn d_fnc_enabledynsim;
			};
		};
		if (d_with_ranked) then {
			clearWeaponCargoGlobal _vec;
		};
		_vec setDamage 0;
	};
} forEach _this;

__TRACE("Before d_fnc_helirespawn2")

0 spawn d_fnc_helirespawn2;
