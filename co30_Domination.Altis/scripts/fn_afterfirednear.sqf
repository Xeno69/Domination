//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_unit"];

while {alive _unit} do {
	private _fired_last = (agent teamMember _unit) getVariable ["civ_last_firednear", 0];
	diag_log ["zooooooooooooooo"];
	if (_fired_last > 0) then {
		diag_log [_fired_last];
	};
	diag_log [unitPos _unit];
	//diag_log [time];
	
	private _threatened = false;
	{
		if !(weaponLowered _x) exitWith {
			sleep random 1;
			_unit setUnitPos "DOWN";
			_threatened = true;
		};
	} forEach (allPlayers select { _x distance2D _unit < 4 });
	
	if (unitPos _unit == "DOWN" && {time - _fired_last > 35 && {!_threatened}}) then {
		sleep random 3;
		_unit setUnitPos "MIDDLE";
	};
	
	sleep (3 + random 3);
};
