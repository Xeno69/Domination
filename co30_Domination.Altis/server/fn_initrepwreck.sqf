// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initrepwreck.sqf"
#include "..\x_setup.sqf"

{
	private _trig = [
		_x,
		[25, 25, getDir _x, true, 30],
		["ANYPLAYER", "PRESENT", true],
		["this",
			"thisTrigger setVariable ['d_noplayer', false]; if !(thisTrigger getVariable ['d_fsmisrunning', false]) then {0 = [thisTrigger getVariable 'd_repwreckobj', localize 'STR_DOM_MISSIONSTRING_0', thisTrigger] execFSM 'fsms\fn_RepWreck.fsm'}",
			"thisTrigger setVariable ['d_noplayer', true]"
		]
	] call d_fnc_createtriggerlocal;
	_trig setVariable ["d_repwreckobj", _x];	
} forEach ((allMissionObjects "Land_HelipadSquare_F") select {(str _x) select [0, 11] isEqualTo "d_wreck_rep"});