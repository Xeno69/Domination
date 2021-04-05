// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_build_ranked_gear.sqf"
#include "..\x_setup.sqf"

d_non_check_items = [];
d_non_check_items append (bis_fnc_arsenal_data # 7);
d_non_check_items append (bis_fnc_arsenal_data # 8);
d_non_check_items append (bis_fnc_arsenal_data # 9);
d_non_check_items append (bis_fnc_arsenal_data # 10);
d_non_check_items append (bis_fnc_arsenal_data # 11);
d_non_check_items append (bis_fnc_arsenal_data # 12);
d_non_check_items append (bis_fnc_arsenal_data # 13);
d_non_check_items append (bis_fnc_arsenal_data # 14);
d_non_check_items append (bis_fnc_arsenal_data # 24);
d_non_check_items apply {toLowerANSI _x};


private _radiosb = [];
if (isClass (configFile>>"CfgPatches">>"task_force_radio")) then {
	_radiosb = ((bis_fnc_arsenal_data # 5) select {_x select [0, 3] == "TF_"}) apply {toLowerANSI _x};
};

{
	private _bagclass = toLowerANSI _x;
	private _maxload = [getNumber(configFile>>"CfgVehicles">>_x>>"maximumLoad"), 0] select (_bagclass in _radiosb);
	private _toadd = call {
		if (_maxload < 200) exitWith {
			["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]
		};
		if (_maxload < 300) exitWith {
			["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]
		};
		if (_maxload < 400) exitWith {
			["MAJOR","COLONEL"]
		};
		["COLONEL"]
	};
	{
		private _entry = d_misc_hash getOrDefault [format ["%1_BAGS", _x], []];
		_entry pushBack _bagclass;
		d_misc_hash set [format ["%1_BAGS", _x], _entry];
	} forEach _toadd;
} forEach (bis_fnc_arsenal_data # 5);

private _vpl = vest player;
{
	private _toadd = if (_vpl == _x) then {
		["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]
	} else {
		private _maxload = getNumber(configFile>>"CfgVehicles">>getText(configFile>>"CfgWeapons">>_x>>"ItemInfo">>"containerClass")>>"maximumLoad");
		call {
			if (_maxload < 100) exitWith {
				["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]
			};
			if (_maxload < 121) exitWith {
				["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]
			};
			if (_maxload < 141) exitWith {
				["MAJOR","COLONEL"]
			};
			["COLONEL"]
		};
	};

	private _vestclass = toLowerANSI _x;
	{
		private _entry = d_misc_hash getOrDefault [format ["%1_VESTS", _x], []];
		_entry pushBack _vestclass;
		d_misc_hash set [format ["%1_VESTS", _x], _entry];
	} forEach _toadd;
} forEach (bis_fnc_arsenal_data # 4);

{
	private _headgearclass = toLowerANSI _x;
		{
			private _entry = d_misc_hash getOrDefault [format ["%1_HG", _x], []];
			_entry pushBack _headgearclass;
			d_misc_hash set [format ["%1_HG", _x], _entry];
		} forEach ["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"];
} forEach (bis_fnc_arsenal_data # 6);

d_usave =+ bis_fnc_arsenal_data # 3;

#ifndef ___DEBUG__
if (true) exitWith {};
#endif

private _rankhash = createHashMapFromArray [
	["private", []],
	["corporal", []],
	["sergeant", []],
	["lieutenant", []],
	["captain", []],
	["major", []],
	["colonel", []]
];

{
	private _cfg = configFile>>"CfgWeapons">>_x;
	private _type = getText(_cfg>>"cursor");
	__TRACE_2("","_x","_type")
	private _muzzles = getArray(_cfg>>"muzzles");
	__TRACE_2("","_x","_muzzles")
	private _inertia = getNumber(_cfg>>"inertia");
	__TRACE_2("","_x","_inertia")
	private _aimTransitionSpeed = getNumber(_cfg>>"aimTransitionSpeed");
	__TRACE_2("","_x","_aimTransitionSpeed")
	private _dexterity = getNumber(_cfg>>"dexterity");
	__TRACE_2("","_x","_dexterity")
	private _maxZeroing = getNumber(_cfg>>"maxZeroing");
	__TRACE_2("","_x","_maxZeroing")
	
	// extra muzzle = not a private weapon
	if (count _muzzles > 1) then {
		for "_i" from 1 to (count _muzzles - 1) do {
			private _muzzle = _muzzles # _i;
			private _cursor = getText(_cfg>>_muzzle>>"cursor");
			__TRACE_1("","_cursor")
			// if cursor = "EmptyCursor" then it is a grenade launcher
			// other cursors: srifle, sgun
			// should be arifle normally
			call {
				if (_cursor == "EmptyCursor") exitWith {
					(_rankhash get "sergeant") pushBack _x;
				};
				if (_cursor == "sgun") exitWith {
					(_rankhash get "captain") pushBack _x;
				};
				if (_cursor == "srifle") exitWith {
					(_rankhash get "colonel") pushBack _x;
				};
				(_rankhash get "sergeant") pushBack _x;
			};
		};
	} else {
		call {
			if (_type == "arifle") exitWith {
			};
			if (_type == "smg") exitWith {
			};
			if (_type == "srifle") exitWith {
			};
			if (_type == "mg") exitWith {
			};
		};
	};
} forEach (bis_fnc_arsenal_data # 0);

#ifdef __DEBUG__
{
	diag_log _x;
	diag_log (_rankhash get _x);
} forEach ["private", "corporal", "sergeant", "lieutenant", "captain", "major", "colonel"];
#endif
