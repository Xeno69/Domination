// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_helilift_wreck.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_chopper"];

private _menu_lift_shown = false;
private _liftobj = objNull;
private _id = -1212;
private _release_id = -1212;

_chopper setVariable ["d_vec_attached", false];
_chopper setVariable ["d_vec_released", false];
_chopper setVariable ["d_Attached_Vec", objNull];

private _possible_types = _chopper getVariable ["d_lift_types", []];

sleep 10.123;

while {alive _chopper && {alive player && {player in _chopper}}} do {
	if (driver _chopper == player) then {
		private _pos = getPosVisual _chopper;
		
		if (!(_chopper getVariable ["d_vec_attached", false]) && {_pos # 2 > 2.5 && {_pos # 2 < 50}}) then {
			_liftobj = objNull;
			private _nobjects = nearestObjects [_chopper, ["LandVehicle","Air"], 70];
			if !(_nobjects isEqualTo []) then {
				_nobjects params ["_dummy"];
				if (_dummy == _chopper) then {
					if (count _nobjects > 1) then {_liftobj = _nobjects # 1};
				} else {
					_liftobj = _dummy;
				};
			};
			if (!isNull _liftobj) then {
				if (_liftobj isKindOf "CAManBase") then {
					_liftobj = objNull;
				} else {
					private _isvalid = _liftobj getVariable "d_canbewlifted";
					if (isNil "_isvalid") then {
						_isvalid = !isNil {_liftobj getVariable "d_isspecialvec"} || {toUpper (typeof _liftobj) in _possible_types};
						_liftobj setVariable ["d_canbewlifted", _isvalid];
					};
					if (!_isvalid || {damage _liftobj < 1}) then {_liftobj = objNull};
				};
			};
			sleep 0.1;
			if ((_liftobj getVariable ["d_WreckMaxRepair", d_WreckMaxRepair]) > 0 && {!isNull _liftobj && {_liftobj != _chopper getVariable "d_Attached_Vec"}}) then {
				if (_chopper inArea [_liftobj, 10, 10, 0, false]) then {
					if (!_menu_lift_shown) then {
						_id = _chopper addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_254"], {_this call d_fnc_heli_action},-1,100000];
						_menu_lift_shown = true;
					};
				} else {
					_liftobj = objNull;
					if (_menu_lift_shown) then {
						_chopper removeAction _id;
						_id = -1212;
						_menu_lift_shown = false;
					};
				};
			};
		} else {
			__TRACE_1("","_menu_lift_shown")
			if (_menu_lift_shown) then {
				_chopper removeAction _id;
				_id = -1212;
				_menu_lift_shown = false;
			};
			
			sleep 0.1;
			
			if (isNull _liftobj) then {
				_chopper setVariable ["d_vec_attached", false];
				_chopper setVariable ["d_vec_released", false];
			} else {
				__TRACE_1("","_liftobj")
				if (_chopper getVariable "d_vec_attached") then {
					_release_id = _chopper addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_255"], {_this call d_fnc_heli_release}, -1, 100000];
					_chopper vehicleChat (localize "STR_DOM_MISSIONSTRING_252");
					_chopper setVariable ["d_Attached_Vec", _liftobj];
					
					private _fuelloss = switch (true) do {
						case (_liftobj isKindOf "Wheeled_APC" || {_liftobj isKindOf "Wheeled_APC_F"}): {0.0003};
						case (_liftobj isKindOf "Car" || {_liftobj isKindOf "Car_F"}): {0.0002};
						case (_liftobj isKindOf "Air"): {0.0004};
						case (_liftobj isKindOf "TANK"): {0.0006};
						default {0.0001};
					};
					
					_liftobj engineOn false;
					_liftobj attachTo [_chopper, [0, 0, -15]];
					_chopper setVariable ["d_attachedto_v", _liftobj, true];
					if (d_with_ranked || {d_database_found}) then {
						_liftobj setVariable ["d_lift_pilot", player, true];
					};
					
					while {alive _chopper && {player in _chopper && {!isNull _liftobj && {alive player && {!isNull attachedTo _liftobj && {!(_chopper getVariable "d_vec_released")}}}}}} do {
						_chopper setFuel ((fuel _chopper) - _fuelloss);
						sleep 0.312;
					};
					__TRACE("Out of while loop")
					
					if (!isNull attachedTo _liftobj) then {
						detach _liftobj;
					};
					
					_chopper setVariable ["d_attachedto_v", nil, true];
										
					if (!isNull _liftobj) then {
						detach _liftobj;
						[_liftobj, [0,0,0]] remoteExecCall ["setVelocity", _liftobj];
					};
					
					_chopper setVariable ["d_vec_attached", false];
					_chopper setVariable ["d_vec_released", false];
					
					_chopper setVariable ["d_Attached_Vec", objNull];
					
					if (alive _chopper) then {
						if (alive player) then {_chopper vehicleChat (localize "STR_DOM_MISSIONSTRING_253")};
						_chopper removeAction _release_id;
						_release_id = -1212;
					};
					
					if (!isNull _liftobj) then {
						if (!(_liftobj isKindOf "StaticWeapon") && {(getPosVisual _liftobj) # 2 < 200}) then {
							waitUntil {sleep 0.222;(getPosVisual _liftobj) # 2 < 10};
						} else {
							private _npos = getPosVisual _liftobj;
							_liftobj setPos [_npos # 0, _npos # 1, 0];
						};					
					
						detach _liftobj;
						[_liftobj, [0,0,0]] remoteExecCall ["setVelocity", _liftobj];
					};
					
					sleep 1.012;
				};
			};
		};
	};
	sleep 0.51;
};

if (alive _chopper) then {
	if (_id != -1212) then {_chopper removeAction _id};
	if (_release_id != -1212) then {_chopper removeAction _release_id};
};