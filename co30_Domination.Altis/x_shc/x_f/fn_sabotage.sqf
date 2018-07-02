// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sabotage.sqf"
#include "..\..\x_setup.sqf"

params ["_grp"];

if (isNull _grp) exitWith {};

_grp setBehaviour "AWARE";
_grp setCombatMode "YELLOW";

while {(units _grp) findIf {alive _x} > -1} do {
	private _leader = leader _grp;
	if (isNull _leader) then {
		sleep 5.121;
		_leader = leader _grp;
	};
	private _shell_units = [];
	if (!isNull _leader) then {
		// TODO... search for something else? Buildings? Add the old mode again destroying facs?
		private _no = nearestObjects [_leader, ["LandVehicle", "Air"], 300, true];
		sleep 0.32;
		if (count _no > 0) then {
			private _obj = selectRandom _no;
			if (alive _obj) then {
				private _obj_pos = getPos _obj;
				_units = units _grp;
				for "_i" from 1 to 3 do {
					private _one_shell = [];
					private _shell_unit = objNull;
					{
						_one_shell = (magazines _x) select {_x == "DemoCharge_Remote_Mag"};
						if !(_one_shell isEqualTo []) exitWith {
							_shell_unit = _x;
						};
						sleep 0.01;
					} forEach _units;
					if (_shell_unit == objNull) exitWith {};
					_units = _units - [_shell_unit];
					if !(_one_shell isEqualTo []) then {
						_shell_unit selectWeapon "DemoChargeMuzzle";
						if (_leader == _shell_unit) then {
							_shell_unit doMove _obj_pos;
							_shell_unit doTarget _obj;
							_shell_unit doFire _obj;
						} else {
							_shell_unit commandMove _obj_pos;
							_shell_unit commandTarget _obj;
							_shell_unit commandFire _obj;
						};
						_shell_units pushBack _shell_unit;
					};
					if (!alive _obj) exitWith {};
				};
			};
		};
		_no = nil;
	};
	_timeend = time + 240 + (random 80);
	waitUntil {sleep 3.472; time > _timeend || {isNull _grp}};
	{_x addMagazine "DemoCharge_Remote_Mag"} forEach (_shell_units select {alive _x});
	_shell_units = [];
};
