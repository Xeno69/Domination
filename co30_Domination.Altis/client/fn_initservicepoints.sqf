// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initservicepoints.sqf"
#include "..\x_setup.sqf"

private _allmissiono = (allMissionObjects "Land_HelipadSquare_F") + (allMissionObjects "Land_HelipadEmpty_F");

{
	private _trig = [
		_x,
		[5.5, 5.5, getDir _x, true, 10],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tchopservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach (_allmissiono select {(str _x) select [0, 17] isEqualTo "d_chopper_trigger"});

{
	private _trig = [
		_x,
		[5.5, 5.5, getDir _x, true, 10],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tvecservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach (_allmissiono select {(str _x) select [0, 15] isEqualTo "d_vecre_trigger"});

{
	private _trig = [
		_x,
		[15, 19, getDir _x, true, 15],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tjetservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach (_allmissiono select {(str _x) select [0, 13] isEqualTo "d_jet_trigger"});

{
	private _trig = [
		_x,
		[5.5, 5.5, getDir _x, true, 10],
		["ANYPLAYER", "PRESENT", true],
		["thislist call d_fnc_tallservice", "0 = [thislist] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;	
} forEach (_allmissiono select {(str _x) select [0, 20] isEqualTo "d_serviceall_trigger"});
