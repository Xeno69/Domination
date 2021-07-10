// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("dismissbuttonaction")
if (player getVariable "d_recdbusy") exitWith {};

disableSerialization;

player setVariable ["d_recdbusy", true];
__TRACE("dismissbuttonaction2")
private _dispx = uiNamespace getVariable "d_AIRecruitDialog";
private _control = _dispx displayCtrl 1001;
private _idx = lbCurSel _control;
__TRACE_1("",_idx)
if (_idx == -1) exitWith {
	player setVariable ["d_recdbusy", false];
};

d_current_ai_num = d_current_ai_num - 1;
__TRACE_1("","d_current_ai_num")

_control lbDelete _idx;

private _unit = d_current_ai_units # _idx;
d_current_ai_units deleteAt _idx;

if !(_unit call d_fnc_isplayer) then {
	if (isNull objectParent _unit) then {
		deleteVehicle _unit;
	} else {
		(vehicle _unit) deleteVehicleCrew _unit;
	};
};

private _ctrl = _dispx displayCtrl 1010;
if (!ctrlShown _ctrl) then {
	_ctrl ctrlShow true;
};

if (d_current_ai_num < 0) then {d_current_ai_num = 0};

if (d_current_ai_num == 0) then {
	(_dispx displayCtrl 1011) ctrlShow false;
	(_dispx displayCtrl 1012) ctrlShow false;
	enableSentences false;
	d_hasrecruited = nil;
};

(_dispx displayCtrl 1030) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_693", d_current_ai_num, [round linearConversion [0, 20, 21 - count d_allplayers, 0, d_max_ai, true], d_max_ai] select !d_ai_dyn_recruit];
player setVariable ["d_recdbusy", false];