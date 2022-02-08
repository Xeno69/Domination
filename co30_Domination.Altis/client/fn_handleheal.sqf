// by Xeno, ACE support by Auge
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!d_with_ace || {d_with_ace && {d_ACEMedicalR == 0}}) then {
	params ["_healed", "_healer"];
	if (alive _healed && {alive _healer && {_healed != _healer && {!(_healed getVariable ["xr_pluncon", false]) && {!(_healer getVariable ["xr_pluncon", false])}}}}) then {
		[_healed, _healer] spawn {
			scriptName "spawn_handleheal";
			params ["_healed", "_healer"];
			sleep 3;
			if (alive _healed && {alive _healer && {_healed != _healer && {!(_healed getVariable ["xr_pluncon", false]) && {!(_healer getVariable ["xr_pluncon", false])}}}}) then {
				[_healer, 5] remoteExecCall ["d_fnc_ascfc", 2];
			};
		};
	};
	false
} else {	
	// Use ACE medical system
	params ["_healer", "_healed", "_bodyPart", "_medicItem"];
	private _medicPoints = 0;
	
	if (alive _healed && {alive _healer && {_healed != _healer && {!(_healed getVariable ["ace_isunconscious", false]) && {!(_healer getVariable ["ace_isunconscious", false])}}}}) then {
		// Select points (You can add different cases in here to support multiple ace medical actions and distribute points accordingly) 
		// This differentiates between "normal" soldiers and ace medics - medics who have set Ace_medical_medicClass to 1 or 2 can get different points
		if (!isNil {_healer getVariable "Ace_medical_medicClass"} && {(_healer getVariable "Ace_medical_medicClass") > 0}) then {
			// it's the same?
			// Medic & Doctor point rewards
			_medicPoints = [0, d_ranked_a # 17] select (_medicItem == "PersonalAidKit");
		} else {
			// Standard soldier point rewards
			_medicPoints = [0, d_ranked_a # 17] select (_medicItem == "PersonalAidKit");
		};
		
		// Add points to player
		if (_medicPoints > 0) then {
			[_healer, 10] remoteExecCall ["d_fnc_addscore", 2];
		};
	};
	
	if(alive _healed && {alive _healer && {_healed != _healer && {_healed getVariable ["ace_isunconscious", false] && {!(_healer getVariable ["ace_isunconscious", false])}}}}) then {
				
		if(_medicItem != "CheckBloodPressure" && {_medicItem != "CheckPulse"}) then{
			
			reviveHelpers = _healed getVariable ["reviveHelpers", []];
			if ( reviveHelpers findIf { _x == _healer } == -1 ) then {
				reviveHelpers pushBack _healer;
			};
			
			_healed setVariable ["reviveHelpers", reviveHelpers, true];
		};
	};
	false
};
