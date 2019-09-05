// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_repack_mags.sqf"
#include "..\x_setup.sqf"

if (!alive player || {player getVariable ["xr_pluncon", false]}) exitWith {};

d_inventory_blocked = true;

"d_ProgressBar2" cutRsc ["d_ProgressBar2", "PLAIN"];
private _control = (uiNamespace getVariable "d_ProgressBar2") displayCtrl 3800;

_control ctrlSetPositionW 0.4;
_control ctrlCommit 5;

private _ular =+ getUnitLoadout player;

private _conf = configFile>>"CfgMagazines";

#ifdef __DEBUG__
{
	__TRACE_1("_ular","_x")
} forEach _ular;
#endif

for "_i" from 3 to 5 do {
	private _row = _ular # _i;
	if (_row isEqualType [] && {!(_row isEqualTo [])}) then {
		private _containerar = [];
		{
			if (_x # 1 == 1 || {count _x == 2}) then {
				_containerar pushBack _x;
			} else {
				for "_j" from 1 to (_x # 1) do {
					_containerar pushBack [_x # 0, 1, _x # 2];
				};
			};
		} forEach (_row # 1);
		(_ular # _i) set [1, _containerar];
		__TRACE_1("1","_containerar")
	};
};

private _fnc_search345 = {
	params ["_mag", "_ammocount", "_maxammo", "_endrow", "_endidx"];
	private _doend = false;
	private _result = _ammocount;
	private _diff = _maxammo - _ammocount;

	for "_z" from 5 to _endrow step -1 do {
		private _currow = _ular # _z;
		if (_currow isEqualType [] && {!(_currow isEqualTo [])}) then {
			private _search_ar = _currow # 1;
			if (_endidx + 1 < count _search_ar) then {
				for "_b" from (count _search_ar - 1) to (_endidx + 1) step -1 do {
					private _ele = _search_ar # _b;
					if (_ele isEqualType [] && {(_ele # 0) == _mag}) then {
						if (_ele # 2 > _diff) then {
							_search_ar set [_b, [_ele # 0, 1, (_ele # 2) - _diff]];
							__TRACE_1("1","_search_ar")
							_doend = true;
							_result = _maxammo;
						} else {
							if ((_ele # 2) - _diff == 0) then {
								_search_ar set [_b, -1];
								_doend = true;
								_result = _maxammo;
							} else {
								_diff = _diff - _ele # 2;
								_search_ar set [_b, -1];
								_result = _maxammo - _diff;
							};
						};
					};
					if (_doend) exitWith {};
				};
			};
		};
		if (_doend) exitWith {};
	};

	_result
};

for "_i" from 0 to 2 do {
	private _row = _ular # _i;
	if (_row isEqualType [] && {!(_row isEqualTo [])}) then {
		{
			if (_x isEqualType [] && {!(_x isEqualTo [])}) then {
				private _mag = _x # 0;
				private _ammocount = _x # 1;
				if (_mag isKindOf ["CA_Magazine", _conf] && {getNumber (_conf>>_mag>>"count") > 1 && {_ammocount < getNumber (_conf>>_mag>>"count")}}) then {
					private _res = [_mag, _ammocount, getNumber (_conf>>_mag>>"count"), 3, -1] call _fnc_search345;
					__TRACE_1("1","_res")
					if (_res != _ammocount) then {
						_row set [_forEachIndex, [_mag, _res]];
					};
				};
			};
		} forEach _row;
	};
};

for "_i" from 3 to 5 do {
	private _row = _ular # _i;
	if (_row isEqualType [] && {!(_row isEqualTo [])}) then {
		private _searchrow = _row # 1;
		if !(_searchrow isEqualTo []) then {
			{
				if (count _x == 3) then {
					private _mag = _x # 0;
					private _ammocount = _x # 2;
					if (_mag isKindOf ["CA_Magazine", _conf] && {getNumber (_conf>>_mag>>"count") > 1 && {_ammocount < getNumber (_conf>>_mag>>"count")}}) then {
						private _res = [_mag, _ammocount, getNumber (_conf>>_mag>>"count"), _i, _forEachIndex] call _fnc_search345;
						__TRACE_1("2","_res")
						if (_res != _ammocount) then {
							_searchrow set [_forEachIndex, [_mag, 1, _res]];
						};
					};
				};
			} forEach _searchrow;
		};
	};
};

for "_i" from 3 to 5 do {
	private _row = _ular # _i;
	if !(_row isEqualTo []) then {
		private _containerar = [];

		private _ar = _row # 1;
		_ar = _ar - [-1];
		private _countar = count _ar - 1;
		{
			if (_x isEqualType []) then {
				if (_forEachIndex < _countar) then {
					if (count _x == 3) then {
						private _mcount = 1;
						for "_b" from (_forEachIndex + 1) to _countar do {
							private _ele = _ar # _b;
							if ((_ele # 0) == (_x # 0) && {(_ele # 2) == (_x # 2)}) then {
								_mcount = _mcount + 1;
								_ar set [_b, -1];
							};
						};
						_containerar pushBack [_x # 0, _mcount, _x # 2];
					} else {
						_containerar pushBack [_x # 0, _x # 1];
					};
				} else {
					if (count _x == 3) then {
						_containerar pushBack [_x # 0, 1, _x # 2];
					} else {
						_containerar pushBack [_x # 0, _x # 1];
					};
				};
			};
		} forEach _ar;

		(_ular # _i) set [1, _containerar];
	};
};


#ifndef __DEBUG__
sleep 4.95;
#else
sleep 0.5;
#endif

"d_ProgressBar2" cutFadeOut 0;
d_inventory_blocked = false;
if (!alive player || {player getVariable ["xr_pluncon", false]}) exitWith {};

hintSilent parseText format ["<t color='#00ff00' size='1.5' align='center'>%1</t>", localize "STR_DOM_MISSIONSTRING_1942"];

#ifdef __DEBUG__
{
	__TRACE_1("_ular2","_x")
} forEach _ular;
#endif

player setUnitLoadout _ular;