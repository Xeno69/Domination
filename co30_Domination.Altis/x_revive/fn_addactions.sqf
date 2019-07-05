// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addactions.sqf"
#include "..\x_macros.sqf"

if (!hasInterface || {player == _this}) exitWith {};

private _unit = _this;
if (_unit getVariable ["xr_ReviveAction", -9999] == -9999) then {
	private _id = [
		/* 0 object */						_unit,
		/* 1 action title */				format ["<t color='#FF0000'>%1 %2</t>", [localize "STR_DOM_MISSIONSTRING_924", localize "STR_DOM_MISSIONSTRING_923"] select xr_pl_can_revive, _unit call d_fnc_getplayername],
		/* 2 idle icon */					"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
		/* 3 progress icon */				"A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_reviveMedic_ca.paa",
		/* 4 condition to show */			"_this distance2D _target <= 3.5 && {_target getVariable 'xr_pluncon' && {!(_this getVariable 'xr_pisinaction') && {!(_target getVariable 'xr_dragged')}}}",
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{(player call d_fnc_getplayername) remoteExecCall ["xr_fnc_yougetrevivedm", _this select 0]},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{_this call xr_fnc_cdorevive},
		/* 9 code executed on interruption*/{},
		/* 10 arguments */					[_unit],
		/* 11 action duration */			[6, 3] select (player getUnitTrait "medic"),
		/* 12 priority */					-1,
		/* 13 remove on completion */		false,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd;
	__TRACE_1("id1","_id")
	_unit setVariable ["xr_ReviveAction", _id];
	
	_id = _unit addAction [format ["<t color='#FF0000'>%2 %1</t>", _unit call d_fnc_getplayername, localize "STR_DOM_MISSIONSTRING_1704"], {player setVariable ["xr_cursorTarget", _this select 0]; 0 spawn xr_fnc_drag}, [], -2, false, false, "", "_target getVariable 'xr_pluncon' && {!(_this getVariable 'xr_pisinaction') && {!(_target getVariable 'xr_dragged')}}", 3];
	__TRACE_1("id2","_id")
	_unit setVariable ["xr_DragAction", _id];
};

xr_uncon_units pushBackUnique _unit;
