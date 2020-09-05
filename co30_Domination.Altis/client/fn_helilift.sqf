// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_helilift.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_chopper"];

private _menu_lift_shown = false;
private _liftobj = objNull;
private _id = -1212;
private _release_id = -1212;

sleep 10.123;

while {alive _chopper && {alive player && {player in _chopper}}} do {
	if (currentPilot _chopper == player) then {
		private _pos = getPosVisual _chopper;

		if (!(_chopper getVariable ["d_vec_attached", false]) && {_pos # 2 > 2.5 && {_pos # 2 < 11}}) then {
			_liftobj = objNull;
			private _nobjects = nearestObjects [_chopper, ["LandVehicle", "Air"], 50];
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
					private _isvalid = _liftobj getVariable ["d_liftit", false] && {!(_liftobj getVariable ["d_no_lift", false])};
#ifndef __TT__
					if (!_isvalid || {speed _liftobj > 10 || {(getPosVisual _liftobj) # 2 > 5}}) then {_liftobj = objNull};
#else
					if (!_isvalid || {speed _liftobj > 10 || {(getPosVisual _liftobj) # 2 > 5 || {_liftobj getVariable ["d_side", d_player_side] != d_player_side}}}) then {_liftobj = objNull};
#endif
				};
			};
			sleep 0.1;
			if (!isNull _liftobj && {_liftobj != _chopper getVariable ["d_Attached_Vec", objNull]}) then {
				if !(_liftobj getVariable ["d_MHQ_Deployed", false]) then {
					if (_chopper inArea [_liftobj, 10, 10, 0, false]) then {
						if (!_menu_lift_shown) then {
							_id = _chopper addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_250"], {_this call d_fnc_heli_action}, -1, 100000, false, true, "", "currentPilot _target == player"];
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
			};
			__TRACE_1("1","_id")
		} else {
			__TRACE("attached")
			if (_menu_lift_shown) then {
				_chopper removeAction _id;
				_id = -1212;
				_menu_lift_shown = false;
			};
			__TRACE_1("2","_id")

			sleep 0.1;

			if (isNull _liftobj) then {
				_liftobj = _chopper getVariable ["d_Attached_Vec", objNull];
				__TRACE_1("liftobject null, new one","_liftobj")
			};

			if (isNull _liftobj) then {
				if (!isNil {_chopper getVariable "d_vec_attached"}) then {
					_chopper setVariable ["d_vec_attached", nil, true];
				};
				if (!isNil {_chopper getVariable "d_vec_released"}) then {
					_chopper setVariable ["d_vec_released", nil, true];
				};
			} else {
				if (_chopper getVariable ["d_vec_attached", false]) then {
					_release_id = _chopper addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_251"], {_this call d_fnc_heli_release}, -1, 100000, false, true, "", "currentPilot _target == player"];
					private _ropes = [];
					private _oldmass = -1;
					if (isNull (_chopper getVariable ["d_Attached_Vec", objNull])) then {
						_chopper vehicleChat (localize "STR_DOM_MISSIONSTRING_252");
						_chopper setVariable ["d_Attached_Vec", _liftobj, true];

						_mhqfuel = _liftobj getVariable "d_vecfuelmhq";
						if (!isNil "_mhqfuel") then {
							[_liftobj, _mhqfuel] remoteExecCall ["setFuel", _liftobj];
							_liftobj setVariable ["d_vecfuelmhq", nil, true];
						};

						if (_liftobj getVariable ["d_vec_type", ""] == "MHQ") then {
							_liftobj setVariable ["d_in_air", true, true];
							_lon = _liftobj getVariable "d_vec_name";
							_chopper setVariable ["d_mhq_lift_obj", [_liftobj, _lon], true];							
							[0, _lon] remoteExecCall ["d_fnc_csidechat", d_player_side];
						};

						[_liftobj, false] remoteExecCall ["engineOn", _liftobj];

						private _maxload = getNumber((configOf _chopper)>>"maximumLoad");
						private _slipos = [[0,0,1], _chopper selectionPosition "slingload0"] select !(_chopper selectionPosition "slingload0" isEqualTo [0,0,0]);
						__TRACE_2("","_maxload","_slipos")
						//_chopper addEventhandler ["RopeAttach", {player sideChat str(_this);player sideChat "bla"}];

						_oldmass = getMass _liftobj;
						private _newmass = -1;
						__TRACE_2("1","_liftobj","_oldmass")
						if (_oldmass > _maxload - 200) then {
							// *sigh* yet another MP inconsistency... setMass is not a command with global effects but only local...
							// means, if we want to cheat and reduce the mass of an object it needs to be set everywhere (or at least where the object is local, not tested)
							_newmass = (_maxload - 1500) max 100;
							[_liftobj, _newmass] remoteExecCall ["setMass"];

							_chopper setVariable ["d_lobm", [_liftobj, _oldmass], true];

							sleep 0.1;
							[_liftobj, _newmass] remoteExecCall ["setMass"];
						} else {
							_oldmass = -1;
						};
						__TRACE_1("","_oldmass")
						//#ifdef __DEBUG__
						//_lobmm = getMass _liftobj;
						//__TRACE_1("","_lobmm")
						//#endif

						private _slcmp = getArray((configOf _liftobj)>>"slingLoadCargoMemoryPoints");

						// Fix for vehicles with slingload points at null position (lots of mod vehicles...)
						private _slcmp_null = true;
						if !(_slcmp isEqualTo []) then {
							{
								if !(_liftobj selectionPosition _x isEqualTo [0,0,0]) exitWith {_slcmp_null = false};
							} forEach _slcmp;
						};

						if (_slcmp_null) then {
							{
								_ropes pushBack (ropeCreate [_chopper, _slipos, _liftobj, _x, 20]);
							} forEach ([_liftobj] call d_fnc_getcorners);
						} else {
							{
								_ropes pushBack (ropeCreate [_chopper, _slipos, _liftobj, _liftobj selectionPosition _x, 20]);
							} forEach _slcmp;
						};

						__TRACE_1("","_ropes")

						if (_newmass > -1) then {
							[_liftobj, _newmass] remoteExecCall ["setMass"];
							sleep 0.1;
							[_liftobj, _newmass] remoteExecCall ["setMass"];
						};

						_chopper setVariable ["d_ropes", _ropes, true];
					} else {
						_ropes = _chopper getVariable ["d_ropes", []];
					};

					// ropeBreak event?
					// player in chopper? What if switch to copilot happens... Needs check and handling, because only the pilot has the actions, etc
					while {alive _chopper && {alive _liftobj && {alive player && {currentPilot _chopper == player && {_ropes findIf {alive _x} > -1 && {!(_chopper getVariable ["d_vec_released", false]) && {player in _chopper}}}}}}} do {
						sleep 0.312;
					};

					if (alive _chopper && {alive player && {alive _liftobj && {player in _chopper && {currentPilot _chopper != player && {!(_chopper getVariable ["d_vec_released", false])}}}}}) exitWith {
						if (_release_id != -1212) then {_chopper removeAction _release_id};
					};

					{
						ropeDestroy _x;
					} forEach (_ropes select {!isNull _x});

					if (_oldmass > -1) then {
						[_liftobj, _oldmass] remoteExecCall ["setMass"];
						_chopper setVariable ["d_lobm", nil, true];
					};
					[_liftobj, [0,0,0]] remoteExecCall ["setVelocity", _liftobj];

					[_liftobj, false] remoteExecCall ["engineOn", _liftobj];
					if ((getPosVisual _liftobj) # 2 > 5) then {
						_liftobj spawn {
							scriptName "spawn_helilift";
							while {(getPosVisual _this) # 2 > 5} do {
								_this setDamage ((damage _this) + 0.01);
								sleep 0.1;
								if (!alive _this) exitWith {};
							};
						};
					};
					_chopper setVariable ["d_ropes", nil, true];

					_chopper setVariable ["d_vec_attached", nil, true];
					_chopper setVariable ["d_vec_released", nil, true];

					if (_liftobj getVariable ["d_vec_type", ""] == "MHQ") then {
						_liftobj setVariable ["d_in_air", false, true];
						_chopper setVariable ["d_mhq_lift_obj", nil, true];
						[1, _liftobj getVariable "d_vec_name"] remoteExecCall ["d_fnc_csidechat", d_player_side];
					};

					_chopper setVariable ["d_Attached_Vec", nil, true];

					if (alive _chopper) then {
						if (alive player) then {_chopper vehicleChat (localize "STR_DOM_MISSIONSTRING_253")};
						_chopper removeAction _release_id;
					};

					if (!(_liftobj isKindOf "StaticWeapon") && {(getPosVisual _liftobj) # 2 < 200}) then {
						while {true} do {
							sleep 0.222;
							if ((getPosVisual _liftobj) # 2 < 10) exitWith {};
						};
					} else {
						private _npos = getPosVisual _liftobj;
						_liftobj setPos [_npos # 0, _npos # 1, 0];
					};
					[_liftobj, [0,0,0]] remoteExecCall ["setVelocity", _liftobj];

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
