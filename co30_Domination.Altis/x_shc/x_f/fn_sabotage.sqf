// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sabotage.sqf"
#include "..\..\x_setup.sqf"

params ["_grp"];

if (isNull _grp) exitWith {};

_grp setBehaviour "AWARE";
_grp setCombatMode "YELLOW";

#ifdef __OA__
// TODO
{_x addMagazine "PipeBomb"} forEach (units _grp);
#endif

while {(units _grp) findIf {alive _x} > -1} do {
	private _leader = leader _grp;
	if (isNull _leader) then {
		sleep 5.121;
	};
	if (!isNull _leader) then {
		// TODO search for what objects?
		private _no = nearestObjects [_leader,["TK_WarfareBAircraftFactory_EP1","US_WarfareBAircraftFactory_EP1"],300];
		sleep 0.32;
		if (count _no > 0) then {
			private _obj = selectRandom _no;
			if (alive _obj) then {
				private _obj_pos = getPos _obj;
				_units = units _grp;
				for "_i" from 1 to 3 do {
					private _one_shell = "";
					private _shell_unit = objNull;
					{
						scopeName "xxxx3";
						private _mags = magazines _x;
						_shell_unit = _x;
						{
							if (_x == "PipeBomb") then {
								_one_shell = _x;
								breakOut "xxxx3";
							};
						} forEach _mags;
						sleep 0.011;
					} forEach _units;
					if (_shell_unit == objNull) exitWith {};
					_units = _units - [_shell_unit];
					if (_one_shell != "") then {
						_shell_unit selectWeapon "PipeBombMuzzle";
						if (_leader == _shell_unit) then {
							_shell_unit doMove _obj_pos;
							_shell_unit doTarget _obj;
							_shell_unit doFire _obj;
						} else {
							_shell_unit commandMove _obj_pos;
							_shell_unit commandTarget _obj;
							_shell_unit commandFire _obj;
						};
					};
					if (!alive _obj) exitWith {};
				};
			};
		};
		_no = nil;
	};
	_timeend = time + 240 + (random 80);
	waitUntil {sleep 3.472; time > _timeend || {isNull _grp}};
};
