// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _allmissiono = allMissionObjects "HeliH";

__TRACE_1("","_allmissiono")

{
	private _trig = [
		_x,
		[5.5, 5.5, getDir _x, true, 10],
		["ANY", "PRESENT", true],
		["[thislist, thisTrigger] call d_fnc_tchopservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;
	_trig setPosASL ((getPosASL _x) vectorAdd [0, 0, -0.5]);
	_trig setTriggerInterval 1;
	__TRACE_1("chopperservice","_trig")
} forEach (_allmissiono select {(str _x) select [0, 17] isEqualTo "d_chopper_trigger"});

{
	private _height = [10, 20] select (surfaceIsWater (getPosASL _x));
	private _trig = [
		_x,
		[5.5, 5.5, getDir _x, true, _height],
		["ANY", "PRESENT", true],
		["[thislist, thisTrigger] call d_fnc_tvecservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;
	_trig setPosASL ((getPosASL _x) vectorAdd [0, 0, -0.5]);
	_trig setTriggerInterval 1;
	__TRACE_1("vecservice","_trig")
} forEach (_allmissiono select {(str _x) select [0, 15] isEqualTo "d_vecre_trigger"});

{
	private _trig = [
		_x,
		[15, 19, getDir _x, true, 15],
		["ANY", "PRESENT", true],
		["[thislist, thisTrigger] call d_fnc_tjetservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;
	_trig setPosASL ((getPosASL _x) vectorAdd [0, 0, -0.5]);
	_trig setTriggerInterval 1;
	__TRACE_1("jetservice","_trig")
} forEach (_allmissiono select {(str _x) select [0, 13] isEqualTo "d_jet_trigger"});

{
	private _trig = [
		_x,
		[12, 12, getDir _x, true, 15],
		["ANY", "PRESENT", true],
		["[thislist, thisTrigger] call d_fnc_tallservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""]
	] call d_fnc_createtriggerlocal;
	_trig setPosASL ((getPosASL _x) vectorAdd [0, 0, -0.5]);
	_trig setTriggerInterval 1;
	__TRACE_1("serviceall","_x")
	__TRACE_3("serviceall","_trig","getPos _trig","getPos _x")
} forEach (_allmissiono select {(str _x) select [0, 20] isEqualTo "d_serviceall_trigger"});
