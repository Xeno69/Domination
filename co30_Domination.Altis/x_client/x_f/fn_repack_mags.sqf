// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_repack_mags.sqf"
#include "..\..\x_setup.sqf"

if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {};

d_inventory_blocked = true;

"d_ProgressBar2" cutRsc ["d_ProgressBar2", "PLAIN"];
private _control = (uiNamespace getVariable "d_ProgressBar2") displayCtrl 3800;

private _pos = ctrlPosition _control;
_pos set [2, 0.4];
_control ctrlSetPosition _pos;
_control ctrlCommit 5;

private _ular = getUnitLoadout player;

private _conf = configFile>>"CfgMagazines";

private _containerar = [];

for "_i" from 3 to 5 do {
	private _mar = _ular # _i;
	if !(_mar isEqualTo []) then {
		{
			if (_x # 1 == 1) then {
				_x pushBack _i;
				_containerar pushBack _x;
			} else {
				for "_j" from 0 to (_x # 1) do {
					_containerar pushBack [_x # 0, 1, _x # 2, _i];
				};
			};
		} forEach (_mar # 1);
	};
};

for "_w" from 0 to 2 do {
	private _ele = _ular # _w;
	__TRACE_1("before","_ele")
	{
		if (_x isEqualType [] && {!(_x isEqualTo [])}) then {
			private _magname = _x # 0;
			__TRACE_1("","_magname")
			if (_magname isKindOf ["CA_Magazine", _conf] && {getNumber (_conf>>_magname>>"count") > 1 && {_x # 1 != getNumber (_conf>>_magname>>"count")}}) then {
				private _magammo = _x # 1;
				__TRACE_1("","_x")
				private _magidx = _forEachIndex;
				__TRACE_1("","_magidx")
				private _doexit = false;
				__TRACE_1("","_containerar")
				if !(_containerar isEqualTo []) then {
					{
						__TRACE_1("","_x")
						if (_x # 0 == _magname) then {
							private _newammo = _magammo + (_x # 2);
							__TRACE_1("","_newammo")
							private _ammocount = getNumber (_conf>>_magname>>"count");
							__TRACE_1("","_ammocount")
							if (_newammo > _ammocount) then {
								private _ammodiff = _newammo - _ammocount;
								_containerar set [_forEachIndex, [_magname, 1, _ammodiff, (_containerar # _forEachIndex) # 3]];
								_ele set [_magidx, [_magname, _ammocount]];
								_doexit = true;
							} else {
								_ele set [_magidx, [_magname, _newammo]];
								_containerar set [_forEachIndex, -1];
								if (_newammo == _ammocount) then {
									_doexit = true;
								};
							};
						};
						if (_doexit) exitWith {};
					} forEach _containerar;
					_containerar = _containerar - [-1];
				};
			};
		};
	} forEach _ele;
	__TRACE_1("after","_ele")
};

__TRACE("next")
private _count = count _containerar;
for "_i" from 0 to (_count - 2) do {
	private _ele = _containerar # _i;
	if (_ele isEqualType [] && {count _ele == 3 && {_ele # 2 != getNumber(_conf>>(_ele # 0)>>"count")}}) then {
		private _doexit = false;
		for "_z" from (_count - 1) to (_i + 1) step - 1 do {
			private _secele = _containerar # _z;
			if (_secele isEqualType [] && {_ele # 0 == _secele # 0 && {_secele # 2 != getNumber (_conf>>(_secele # 0)>>"count")}}) then {
				private _newammo = (_ele # 2) + (_secele # 2);
				__TRACE_1("2","_newammo")
				private _ammocount = getNumber (_conf>>(_ele # 0)>>"count");
				__TRACE_1("","_ammocount")
				if (_newammo > _ammocount) then {
					private _ammodiff = _newammo - _ammocount;
					_containerar set [_i, [_ele # 0, 1, _ammodiff, (_containerar # _i) # 3]];
					_containerar set [_z, [_secele # 0, 1, _ammocount, (_containerar # _z) # 3]];
					_doexit = true;
				} else {
					_containerar set [_i, [_ele # 0, 1, _newammo, (_containerar # _i) # 3]];
					_containerar set [_z, -1];
					if (_newammo == _ammocount) then {
						_doexit = true;
					};
				};
			};
			if (_doexit) exitWith {};
		};
	};
};
_containerar = _containerar - [-1];

__TRACE("elimnate")

for "_i" from 0 to (count _containerar - 2) do {
	private _ele = _containerar # _i;
	if (_ele isEqualType []) then {
		for "_z" from (_i + 1) to (count _containerar - 1) do {
			private _secele = _containerar # _z;
			if (_secele isEqualType [] && {_ele # 0 == _secele # 0}) then {
				if (count _ele == 3) then {
					_ele set [1, (_ele # 1) + 1];
					_containerar set [_z, -1];
				} else {
					if (_ele # 2 == _secele # 2) then {
						_ele set [1, (_ele # 1) + 1];
						_containerar set [_z, -1];
					};
				};
			};
		};
	};
};
_containerar = _containerar - [-1];

private _tmpar = [[], [], []];
{
	if (count _x == 3) then {
		(_tmpar # ((_x # (count _x - 1)) - 3)) pushBack [_x # 0, _x # 1];
	} else {
		(_tmpar # ((_x # (count _x - 1)) - 3)) pushBack [_x # 0, _x # 1, _x # 2];
	};
} forEach _containerar;

for "_i" from 0 to 2 do {
	private _ularar = _ular # (_i + 3);
	if !(_ularar isEqualTo []) then {
		_ularar set [1, _tmpar # _i];
	};
};

sleep 4.95;
"d_ProgressBar2" cutFadeOut 0;
d_inventory_blocked = false;
if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {};

hintSilent (localize "STR_DOM_MISSIONSTRING_1942");

player setUnitLoadout _ular;