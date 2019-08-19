// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initservicepoints.sqf"
#include "..\x_setup.sqf"
if (!hasInterface) exitWith {};

if (isMultiplayer) then {
	while {true} do {
		sleep 0.232;
		if (!d_still_in_intro) exitWith {};
	};
};

{
	private _trig = [
		getPos _x,
		[5, 5, getDir _x, true, 10],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tchopservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach ((allMissionObjects "Land_HelipadSquare_F") select {(str _x) select [0, 17] isEqualTo "d_chopper_trigger"});

{
	private _trig = [
		getPos _x,
		[5, 5, getDir _x, true, 10],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tvecservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach ((allMissionObjects "Land_HelipadSquare_F") select {(str _x) select [0, 15] isEqualTo "d_vecre_trigger"});

{
	private _trig = [
		getPos _x,
		[7, 7, getDir _x, true, 10],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tjetservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach ((allMissionObjects "Land_HelipadSquare_F") select {(str _x) select [0, 13] isEqualTo "d_jet_trigger"});

{
	private _trig = [
		getPos _x,
		[5, 5, getDir _x, true, 10],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tallservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach ((allMissionObjects "Land_HelipadSquare_F") select {(str _x) select [0, 20] isEqualTo "d_serviceall_trigger"});


