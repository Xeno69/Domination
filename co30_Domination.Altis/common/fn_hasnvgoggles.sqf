// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

if (isNil "_this") exitWith {false};

(getText(configFile>>"CfgWeapons">>(hmd _this)>>"simulation") == "NVGoggles")