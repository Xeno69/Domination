// by Xeno, ACE support by Auge
#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (d_with_ace && {d_ACEMedicalR == 1}) then {
	params ["_unit", "_state"];
	
	//If waked up
	if(!_state) then {
		
		//Grant all players that helped stabilizing the unconscious player points for reviving
		reviveHelpers = _unit getVariable ["d_reviveHelpers", []];
		{
		 	[_x, 7] remoteExecCall ["d_fnc_addscore", 2];
		 
		} forEach reviveHelpers;
		
		//reset reviveHelpers
		_unit setVariable ["d_reviveHelper", [], true];
	}
	else {
		// if went unconscious remove previous revive helpers
		_unit setVariable ["d_reviveHelper", [], true];
	};
	
	false
};
