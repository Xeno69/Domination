// by Xeno
#define THIS_FILE "fn_checkammo.sqf"
#include "..\..\x_setup.sqf"

if (param [0] isEqualTo "") exitWith {true};

private _ar = d_misc_sc_store getVariable (param [0]);
if (isNil "_ar") then {
	_ar = [
		toUpper getText(configFile>>"CfgAmmo">>(param [0])>>"simulation") in ["SHOTPIPEBOMB", "SHOTTIMEBOMB", "SHOTDIRECTIONALBOMB", "SHOTMINE"],
		toUpper getText(configFile>>"CfgAmmo">>(param [0])>>"simulation") in ["SHOTSMOKE", "SHOTILLUMINATING", "SHOTNVGMARKER", "SHOTCM", "SHOTSMOKEX"]
	];
	d_misc_sc_store setVariable [param [0], _ar];
};

_ar # (param [1])
