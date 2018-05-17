// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_save_respawngear.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

if (d_without_nvg == 0 || {d_without_vec_ti == 0}) then {
	private _doexit = 0;
	{
		private _omc = configFile>>"CfgWeapons">>_x>>"ItemInfo">>"OpticsModes";
		__TRACE_1("","_omc")
		if (isClass _omc) then {
			for "_i" from 0 to count _omc - 1 do {
				private _modes = getArray((_omc select _i)>>"visionMode");
				__TRACE_1("","_modes")
				if (d_without_nvg == 0 && {"NVG" in _modes}) exitWith {
					_doexit = 1;
				};
				if (d_without_vec_ti == 0 && {"Ti" in _modes}) exitWith {
					_doexit = 2;
				};
			};
		};
		if (_doexit != 0) exitWith {
			if (_doexit == 1) then {
				systemChat localize "STR_DOM_MISSIONSTRING_1645";
			} else {
				systemChat localize "STR_DOM_MISSIONSTRING_1646";
			};
			player removePrimaryWeaponItem _x;
		};
	} forEach (primaryWeaponItems player);
};

player setVariable ["d_respawngear", getUnitLoadout player];