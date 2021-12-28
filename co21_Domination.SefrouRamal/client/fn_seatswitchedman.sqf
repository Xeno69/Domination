// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_switcher", "_unit2", "_vec"];

__TRACE_1("","assignedVehicleRole player");

if ((assignedVehicleRole player) # 0 == "Cargo" || {!isNil {_vec getVariable "d_vec_type"}}) exitWith {
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
