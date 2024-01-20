// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

if (player getVariable "d_recdbusy") exitWith {};

disableSerialization;

player setVariable ["d_recdbusy", true];
private _has_ai = false;
{
	_has_ai = true;
	if (isNull objectParent _x) then {
		deleteVehicle _x;
	} else {
		(vehicle _x) deleteVehicleCrew _x;
	};
} forEach ((units player) select {!(isPlayer [_x])});
if (_has_ai) then {[1, localize "STR_DOM_MISSIONSTRING_216"] call d_fnc_sideorsyschat;};
private _dispx = uiNamespace getVariable "d_AIRecruitDialog";
(_dispx displayCtrl 1011) ctrlShow false;
(_dispx displayCtrl 1012) ctrlShow false;
d_current_ai_num = 0;

(_dispx displayCtrl 1030) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_693", d_current_ai_num, [round linearConversion [0, 20, 21 - count d_allplayers, 0, d_max_ai, true], d_max_ai] select !d_ai_dyn_recruit];

private _ctrl = _dispx displayCtrl 1010;
if (!ctrlShown _ctrl) then {
	_ctrl ctrlShow true;
};

lbClear (_dispx displayCtrl 1001);

d_current_ai_units = [];
player setVariable ["d_recdbusy", false];
