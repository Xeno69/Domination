// by Xeno
#define THIS_FILE "fn_farp_e.sqf"
#include "..\..\x_setup.sqf"

if (player getUnitTrait "engineer") then {
	(_this select 0) addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_513"], {_this call d_fnc_restoreeng}];
};
if (_this select 1 != player) then {
	private _farpc = (_this select 0) getVariable ["d_objcont", []];
	if !(_farpc isEqualTo []) then {
		_farpc params ["_trig"];
		_trig setTriggerActivation ["ANY", "PRESENT", true];
		_trig setTriggerStatements ["thislist call d_fnc_tallservice", "0 = [thislist] spawn d_fnc_reload", ""];
	};
};
