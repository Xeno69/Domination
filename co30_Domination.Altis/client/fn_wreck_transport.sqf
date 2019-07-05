// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_wreck_transport.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_vec"];

__TRACE_1("","_vec")

private _menu_trans_shown = false;
private _transobj = objNull;
private _id = -1212;
private _release_id = -1212;

_vec setVariable ["d_vec_attached", false];
_vec setVariable ["d_vec_released", false];
_vec setVariable ["d_Attached_Vec", objNull];

private _possible_types = _vec getVariable ["d_lift_types", []];

sleep 10.123;

while {alive _vec && {alive player && {player in _vec}}} do {
	if (driver _vec == player) then {
		if !(_vec getVariable ["d_vec_attached", false]) then {
			_transobj = objNull;
			private _nobjects = nearestObjects [_vec, ["LandVehicle", "Air"], 70];
			__TRACE_1("","_nobjects")
			if !(_nobjects isEqualTo []) then {
				_nobjects params ["_dummy"];
				if (_dummy == _vec) then {
					if (count _nobjects > 1) then {_transobj = _nobjects # 1};
				} else {
					_transobj = _dummy;
				};
			};
			__TRACE_1("1","_transobj")
			if (!isNull _transobj) then {
				if (_transobj isKindOf "CAManBase") then {
					_transobj = objNull;
				} else {
					private _isvalid = _transobj getVariable "d_canbewlifted";
					if (isNil "_isvalid") then {
						_isvalid = !isNil {_transobj getVariable "d_isspecialvec"} || {toUpper (typeOf _transobj) in _possible_types};
						_transobj setVariable ["d_canbewlifted", _isvalid];
					};
					if (!_isvalid || {damage _transobj < 1}) then {_transobj = objNull};
				};
			};
			sleep 0.1;
			if ((_transobj getVariable ["d_WreckMaxRepair", d_WreckMaxRepair]) > 0 && {!isNull _transobj && {_transobj != _vec getVariable "d_Attached_Vec"}}) then {
				if (_vec inArea [_transobj, 10, 10, 0, false]) then {
					if (!_menu_trans_shown) then {
						_id = _vec addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_1742"], {_this call d_fnc_heli_action},-1,100000];
						_menu_trans_shown = true;
					};
				} else {
					_transobj = objNull;
					if (_menu_trans_shown) then {
						_vec removeAction _id;
						_id = -1212;
						_menu_trans_shown = false;
					};
				};
			};
			__TRACE_1("2","_transobj")
		} else {
			if (_menu_trans_shown) then {
				_vec removeAction _id;
				_id = -1212;
				_menu_trans_shown = false;
			};
			
			sleep 0.1;
			
			if (isNull _transobj) then {
				_vec setVariable ["d_vec_attached", false];
				_vec setVariable ["d_vec_released", false];
			} else {
				if (_vec getVariable "d_vec_attached") then {
					_release_id = _vec addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_255"], {_this call d_fnc_heli_release}, -1, 100000];
					_vec vehicleChat (localize "STR_DOM_MISSIONSTRING_1743");
					_vec setVariable ["d_Attached_Vec", _transobj];
					
					private _fuelloss = switch (true) do {
						case (_transobj isKindOf "Wheeled_APC" || {_transobj isKindOf "Wheeled_APC_F"}): {0.0003};
						case (_transobj isKindOf "Car" || {_transobj isKindOf "Car_F"}): {0.0002};
						case (_transobj isKindOf "Air"): {0.0004};
						case (_transobj isKindOf "TANK"): {0.0006};
						default {0.0001};
					};
					
					_transobj engineOn false;
					if (d_ifa3lite) then {
						_transobj attachTo [_vec, [0, -15, 1]];
					} else {
						_transobj attachTo [_vec, [0, -15, 0]];
					};
					_vec setVariable ["d_attachedto_v", _transobj, true];
					if (d_with_ranked || {d_database_found}) then {
						_transobj setVariable ["d_lift_pilot", player, true];
					};
					
					while {alive _vec && {player in _vec && {!isNull _transobj && {alive player && {!isNull attachedTo _transobj && {!(_vec getVariable "d_vec_released")}}}}}} do {
						_vec setFuel ((fuel _vec) - _fuelloss);
						sleep 0.312;
					};
					
					if (!isNull attachedTo _transobj) then {
						detach _transobj;
					};
					
					_vec setVariable ["d_attachedto_v", nil, true];
										
					if (!isNull _transobj) then {
						detach _transobj;
						[_transobj, [0,0,0]] remoteExecCall ["setVelocity", _transobj];
						_transobj setPos (_vec modelToWorldVisual [0, -2, 0]);
					};
					
					_vec setVariable ["d_vec_attached", false];
					_vec setVariable ["d_vec_released", false];
					_vec setVariable ["d_Attached_Vec", objNull];
					
					if (alive _vec) then {
						_vec removeAction _release_id;
						_release_id = -1212;
						if (alive player) then {_vec vehicleChat (localize "STR_DOM_MISSIONSTRING_253")};
					};
					
					private _npos = getPosATLVisual _transobj;
					_transobj setPos [_npos # 0, _npos # 1, 0];
					
					//[_transobj, [0,0,0]] remoteExecCall ["setVelocity", _transobj];
					
					sleep 1.012;
				};
			};
		};
	};
	sleep 0.51;
};

if (alive _vec) then {
	if (_id != -1212) then {_vec removeAction _id};
	if (_release_id != -1212) then {_vec removeAction _release_id};
};