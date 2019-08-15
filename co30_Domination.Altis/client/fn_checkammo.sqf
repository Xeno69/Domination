// by Xeno
#define THIS_FILE "fn_checkammo.sqf"
#include "..\x_setup.sqf"

if ((_this select 0) isEqualTo "") exitWith {true};

private _ar = d_misc_sc_store getVariable (_this select 0);
if (isNil "_ar") then {
	_ar = [
		//toLower getText(configFile>>"CfgAmmo">>(_this select 0)>>"simulation") in ["shotpipebomb", "shottimebomb", "shotdirectionalbomb", "shotmine"],
		//toLower getText(configFile>>"CfgAmmo">>(_this select 0)>>"simulation") in ["shotsmoke", "shotilluminating", "shotnvgmarker", "shotcm", "shotsmokex"]
		toLowerANSI getText(configFile>>"CfgAmmo">>(_this select 0)>>"simulation") in ["shotpipebomb", "shottimebomb", "shotdirectionalbomb", "shotmine"],
		toLowerANSI getText(configFile>>"CfgAmmo">>(_this select 0)>>"simulation") in ["shotsmoke", "shotilluminating", "shotnvgmarker", "shotcm", "shotsmokex"]
	];
	d_misc_sc_store setVariable [_this select 0, _ar];
};

_ar # (_this select 1)
