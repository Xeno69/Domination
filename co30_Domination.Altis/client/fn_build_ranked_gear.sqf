// by Xeno
//#define __DEBUG__
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
	_radiosb = ((bis_fnc_arsenal_data # 5) select {_x find "TF_" == 0}) apply {toLowerANSI _x};
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

#ifndef __DEBUG__
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
	
	/*private _aimTransitionSpeed = getNumber(_cfg>>"aimTransitionSpeed");
	__TRACE_2("","_x","_aimTransitionSpeed")
	private _dexterity = getNumber(_cfg>>"dexterity");
	__TRACE_2("","_x","_dexterity")
	private _maxZeroing = getNumber(_cfg>>"maxZeroing");
	__TRACE_2("","_x","_maxZeroing")*/
	
	// extra muzzle = not a private weapon
	private _addtorank = "";
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
					_addtorank = "sergeant";
				};
				if (_cursor == "sgun") exitWith {
					_addtorank = "captain";
				};
				if (_cursor == "srifle") exitWith {
					_addtorank = "colonel";
				};
				_addtorank = "sergeant";
			};
		};
	} else {
		private _inertia = getNumber(_cfg>>"inertia");
		__TRACE_2("","_x","_inertia")
		call {
			if (_type == "arifle") exitWith {
				call {
					if (_inertia <= 0.5) exitWith {
						_addtorank = "private";
					};
					if (_inertia <= 0.6) exitWith {
						_addtorank = "corporal";
					};
					if (_inertia <= 0.7) exitWith {
						_addtorank = "sergeant";
					};
					_addtorank = "lieutenant";
				};
			};
			if (_type == "smg") exitWith {
				call {
					if (_inertia <= 0.3) exitWith {
						_addtorank = "private";
					};
					if (_inertia <= 0.4) exitWith {
						_addtorank = "corporal";
					};
					_addtorank = "sergeant";
				};
			};
			if (_type == "srifle") exitWith {
				call {
					if (_inertia <= 0.5) exitWith {
						_addtorank = "corporal";
					};
					if (_inertia <= 0.6) exitWith {
						_addtorank = "sergeant";
					};
					if (_inertia <= 0.7) exitWith {
						_addtorank = "lieutenant";
					};
					if (_inertia <= 0.8) exitWith {
						_addtorank = "captain";
					};
					if (_inertia <= 1.1) exitWith {
						_addtorank = "major";
					};
					_addtorank = "colonel";
				};
			};
			if (_type == "mg") exitWith {
				call {
					if (_inertia <= 0.6) exitWith {
						_addtorank = "private";
					};
					if (_inertia <= 0.7) exitWith {
						_addtorank = "corporal";
					};
					if (_inertia <= 0.8) exitWith {
						_addtorank = "sergeant";
					};
					if (_inertia <= 0.9) exitWith {
						_addtorank = "lieutenant";
					};
					if (_inertia <= 1) exitWith {
						_addtorank = "captain";
					};
					if (_inertia <= 1.1) exitWith {
						_addtorank = "major";
					};
					_addtorank = "colonel";
				};
			};
			if (_type == "sgun") exitWith {
				call {
					if (_inertia <= 0.5) exitWith {
						_addtorank = "private";
					};
					if (_inertia <= 0.6) exitWith {
						_addtorank = "corporal";
					};
					_addtorank = "lieutenant";
				};
			};
		};
	};
	__TRACE_2("","_x","_addtorank")
	//(_rankhash get _addtorank) pushBack _x;
} forEach (bis_fnc_arsenal_data # 0);

{
	private _cfg = configFile>>"CfgWeapons">>_x;
	private _magazines = getArray(_cfg>>"magazines");
	__TRACE_1("","_magazines")
	private _magmodes = [];
	private _manualctrl = [];
	{
		private _ammo = getText (configFile>>"CfgMagazines">>_x>>"ammo");
		_magmodes pushBack getNumber(configFile>>"CfgAmmo">>_ammo>>"airLock");
		_manualctrl pushBack ([0, 1] select (getNumber (configFile>>"CfgAmmo">>_ammo>>"manualControl") > 0 || {getNumber (configFile>>"CfgAmmo">>_ammo>>"weaponLockSystem") > 0}));
	} forEach _magazines;
	__TRACE_1("","_magmodes")
	__TRACE_1("","_manualctrl")
	//airLock = 0; // Cannot target air units
	//airLock = 1; // Can target air and ground units
	//airLock = 2; // Can target air units ONLY
	if (count _magmodes == 1 && {_magmodes # 0 == 2}) then {
		// is AA launcher only
		(_rankhash get "private") pushBack _x;
	} else {
		private _num = 0;
		{_num = _num + _x} forEach _manualctrl;
		__TRACE_1("","_num")
		if (_num == 0) then {
			(_rankhash get "private") pushBack _x;
		};
	};
	
	//f (getNumber (configFile>>"CfgAmmo">>(_this # 4)>>"manualControl") > 0 || {getNumber (configFile>>"CfgAmmo">>(_this # 4)>>"weaponLockSystem") > 0}) then {
	
	//inertia = 1.2;
	//aimTransitionSpeed = 0.5;
	//dexterity = 1;
	//cmImmunity = 0;
	
	private _dexterity = getNumber(_cfg>>"dexterity");
	__TRACE_2("","_x","_dexterity")
	private _aimTransitionSpeed = getNumber(_cfg>>"aimTransitionSpeed");
	__TRACE_2("","_x","_aimTransitionSpeed")
	private _inertia = getNumber(_cfg>>"inertia");
	__TRACE_2("","_x","_inertia")
	private _cmImmunity = getNumber(_cfg>>"cmImmunity");
	__TRACE_2("","_x","_cmImmunity")
	
} forEach (bis_fnc_arsenal_data # 1);

#ifdef __DEBUG__
{
	diag_log _x;
	diag_log (_rankhash get _x);
} forEach ["private", "corporal", "sergeant", "lieutenant", "captain", "major", "colonel"];
#endif
