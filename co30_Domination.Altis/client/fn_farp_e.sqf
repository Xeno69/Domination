// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (player getUnitTrait "engineer") then {
	(_this # 0) addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_513"], {call d_fnc_restoreeng}, 0, -1, false, false, "", "!d_eng_can_repfuel && {alive player}", 10];
};
if (d_dis_servicep == 1 && {_this # 1 != player}) then {
	private _farpc = (_this # 0) getVariable ["d_objcont", []];
	if (_farpc isNotEqualTo []) then {
		_farpc params ["_trig"];
		_trig setTriggerActivation ["ANY", "PRESENT", true];
		_trig setTriggerStatements ["[thislist, thisTrigger] call d_fnc_tallservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""];
		_trig setTriggerInterval 1.2;
		d_farp_classes params ["_farptype"];
		private _mapSize = getNumber(configFile>>"CfgVehicles">>_farptype>>"mapSize");
		_trig setTriggerArea [_mapSize, _mapSize, getDir (_this # 0), true, 2];
	};
};
