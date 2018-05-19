//#define __DEBUG__
// by Xeno
#define THIS_FILE "fn_kehflogic.sqf"
#include "..\x_setup.sqf"

params ["_killed"];

private _var = _killed getVariable "d_hq_logic_name";
private _side = _killed getVariable "d_hq_logic_side";
private _kdata = _killed getVariable "d_kddata";
private _kgrp = group _killed;
_killed removeAllEventHandlers "killed";
_killed removeAllEventHandlers "handleDamage";
deleteVehicle _killed;
if (isNull _kgrp) then {
	_kgrp = [_side] call d_fnc_creategroup;
	if (d_with_ai) then {
		_kgrp setVariable ["d_do_not_delete", true];
	};
};
private _unit = _kgrp createUnit [typeOf _killed,[0,0,0],[],0,"NONE"];
missionNamespace setVariable [_var, _unit];
[_unit] joinSilent _kgrp;
_unit addEventHandler ["handleDamage",{0}];
[_unit, false] remoteExecCall ["enableSimulationGlobal", 2];
publicVariable _var;
_unit setVariable ["d_hq_logic_name", _var];
_unit setVariable ["d_hq_logic_side", _side];
_unit setVariable ["d_kddata", _kdata];

{
	_unit kbAddTopic[_x,"x_bikb\domkba3.bikb"];
} forEach (_kdata # 0);
_unit setIdentity (_kdata # 1);
_unit setRank "COLONEL";
_unit setGroupIdGlobal [_kdata # 2];
_unit addEventHandler ["killed", {_this call d_fnc_kEHflogic}];
removeAllWeapons _unit;
[_var, _side] remoteExecCall ["d_fnc_kbunits", [0, -2] select isDedicated];
