// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_switcher", "_unit2", "_vec"];

__TRACE_1("","assignedVehicleRole player");

if ((assignedVehicleRole player) isNotEqualTo []) then {
	if ((assignedVehicleRole player) # 0 != "cargo") then {
		if (d_isvdreduced) then {
			d_isvdreduced = false;
		};
		private _vp = _this # 2;
		if (_vp isKindOf "Car" || {_vp isKindOf "Tank" || {_vp isKindOf "Motorcycle" || {_vp isKindOf "Ship"}}}) then {
			if (d_ViewDistanceVec != viewDistance) then {
				setViewDistance d_ViewDistanceVec;
				setObjectViewDistance d_ViewDistanceVec + 100;
			};
		} else {
			if (_vp isKindOf "Helicopter" || {_vp isKindOf "Plane"}) then {
				if (d_ViewDistanceAir != viewDistance) then {
					setViewDistance d_ViewDistanceAir;
					setObjectViewDistance d_ViewDistanceAir + 100;
				};
			};
		};
	} else {
		if (d_curviewdistance != viewDistance) then {
			setViewDistance d_curviewdistance;
			setObjectViewDistance d_curobjectdistance + 100;
		};
	};
};

if (!d_with_ranked) exitWith {};

if (((assignedVehicleRole player) isNotEqualTo [] && {(assignedVehicleRole player) # 0 == "Cargo"}) || {!isNil {_vec getVariable "d_vec_type"}}) exitWith {
	d_vec_role_pl = assignedVehicleRole player;
};

(_vec call d_fnc_allowedvec) params ["_not_allowed", "_needed_rank"];

if (_not_allowed) then {
	private _old_assigned = [];
	if (!isNull _unit2) then {
		_old_assigned = assignedVehicleRole player;
		moveOut _unit2;
	};
	__TRACE_1("","d_vec_role_pl");
	private _co = count d_vec_role_pl;
	__TRACE_1("","_co")
	if (_co == 0) then {
		player action ["getOut", _vec];
	} else {
		if (_co == 1) then {
			call {
				if (d_vec_role_pl # 0 == "Driver") exitWith {moveOut player;player moveInDriver _vec};
				if (d_vec_role_pl # 0 == "Cargo") exitWith {moveOut player;player moveInCargo _vec};
			};
		} else {
			moveOut player;
			player moveInTurret [_vec, d_vec_role_pl # 1];
		};
	};
	if (!isNull _unit2 && {_old_assigned isNotEqualTo []}) then {
		private _co = count _old_assigned;
		__TRACE_1("","_co")
		
		if (_co == 1) then {
			call {
				if (_old_assigned # 0 == "Driver") exitWith {_unit2 moveInDriver _vec};
				if (_old_assigned # 0 == "Cargo") exitWith {_unit2 moveInCargo _vec};
			};
		} else {
			if (_co > 1) then {
				_unit2 moveInTurret [_vec, _old_assigned # 1];
			};
		};
	};
	[format [localize "STR_DOM_MISSIONSTRING_308", (rank player) call d_fnc_GetRankString, _needed_rank, [_vec] call d_fnc_GetDisplayName], "HQ"] call d_fnc_HintChatMsg;
} else {
	d_vec_role_pl = assignedVehicleRole player;
};
