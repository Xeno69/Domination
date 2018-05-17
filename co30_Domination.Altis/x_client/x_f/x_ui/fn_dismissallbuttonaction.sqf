// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dismissallbuttonaction.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated || {player getVariable "d_recdbusy"}) exitWith {};

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
} forEach ((units group player) select {!(_x call d_fnc_isplayer)});
if (_has_ai) then {[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_216")};
private _dispx = uiNamespace getVariable "d_AIRecruitDialog";
(_dispx displayCtrl 1011) ctrlShow false;
(_dispx displayCtrl 1012) ctrlShow false;
d_current_ai_num = 0;

(_dispx displayCtrl 1030) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_693", d_current_ai_num, d_max_ai];

private _ctrl = _dispx displayCtrl 1010;
if (!ctrlShown _ctrl) then {
	_ctrl ctrlShow true;
};

lbClear (_dispx displayCtrl 1001);

d_current_ai_units = [];
player setVariable ["d_recdbusy", false];