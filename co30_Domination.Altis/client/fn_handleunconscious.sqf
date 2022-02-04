// by Xeno, ACE support by Auge
#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (d_with_ace && {d_ACEMedicalR == 1}) then {
	params ["_unit", "_state"];
	
	if(!_state) then {
		
		reviveHelpers = _unit getVariable ["reviveHelpers", []];
		
		__TRACE_1("REVIVED WITH HELPERS: ", "reviveHelpers")
		
		{
		 	[_x, 7] remoteExecCall ["d_fnc_addscore", 2];
		 
		} forEach reviveHelpers;
		
		_unit setVariable ["reviveHelper", [], true];
	}
	else {
		_unit setVariable ["reviveHelper", [], true];
	};
	
	false
};
