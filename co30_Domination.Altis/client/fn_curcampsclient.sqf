// by Xeno
#define THIS_FILE "fn_curcampsclient.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

d_deletecamptrigs = [];

{
	if (isNil {_x getVariable "d_trigger"}) then {
		private _trig = [
			_x,
			[12, 12, getDir _x, true, 20],
			["ANYPLAYER", "PRESENT", true],
			["(vehicle player) in thislist && {alive player && {!(player getVariable 'xr_pluncon') && {!(player getVariable ['ace_isunconscious', false])}}}",
				"thisTrigger setVariable ['d_noplayer', false]; 0 = [thisTrigger getVariable 'd_wf', thisTrigger] execFSM 'fsms\fn_CampDialog.fsm'",
				"thisTrigger setVariable ['d_noplayer', true]"
			]
		] call d_fnc_createtriggerlocal;
		_trig setVariable ["d_wf", _x];
		_x setVariable ["d_trigger", _trig];
		d_deletecamptrigs pushBack _trig;
	};
} forEach d_currentcamps;
